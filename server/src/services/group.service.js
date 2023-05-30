const { Like } = require("typeorm");
const { Group, Role, Membership, User } = require("../models/");
const database = require("../configs/db.config");
const roleService = require("./role.service");
const permissionService = require("./permissions.service");
const { Permissions } = permissionService;

const getAllGroups = async () => {
  const groups = await database.getRepository(Group).find({
    include: { all: true },
    relations: { members: true, roles: true, creator: true },
  });

  for (let group of groups) {
    for (let member of group.members) {
      member.role = await roleService.getRoleById(member.role.id);
    }
  }

  return groups;
};

const getGroupsByName = async (name, exact = false) => {
  if (!name) return null;

  if (exact) {
    const group = await database.getRepository(Group).findOne({
      where: { name },
      relations: { members: true, creator: true, roles: true },
    });

    return group;
  } else {
    const group = await database.getRepository(Group).find({
      where: { name: Like(`%${name}%`) },
      relations: { members: true, creator: true, roles: true },
    });

    for (let member of group.members) {
      member.role = await roleService.getRoleById(member.role.id);
    }

    return group;
  }
};

const getGroupById = async (id) => {
  if (!id) return null;

  const group = await database.getRepository(Group).findOne({
    where: { id },
    relations: { members: true, creator: true, roles: true },
  });

  for (let member of group.members) {
    member.role = await roleService.getRoleById(member.role.id);
  }

  return group;
};

const createGroup = async (groupName, creator, description, imageUrl) => {
  let group = database.getRepository(Group).create({
    name: groupName,
    description,
    imageUrl,
  });

  group.creator = creator;
  const newGroup = await database.getRepository(Group).save(group);

  const creatorRole = await roleService.createRole(
    roleService.CREATOR,
    creator,
    newGroup
  );

  await roleService.createRole(roleService.MEMBER, creator, newGroup);

  await roleService.createRole(roleService.ORGANIZER, creator, newGroup);

  group = await addMember(creator.id, creatorRole.id, newGroup.id, creator);

  return await getGroupById(group.id);
};

const updateGroup = async (
  groupId,
  groupName,
  description,
  imageUrl,
  actionIssuer
) => {
  const group = await getGroupById(groupId);

  await permissionService.isAuthorized(actionIssuer, group, [
    Permissions.MODIFY_GROUP,
  ]);

  group.name = groupName;
  group.description = description;
  group.imageUrl = imageUrl;

  return await database.getRepository(Group).save(group);
};

const deleteGroup = async (groupId, user) => {
  const group = await getGroupById(groupId);

  await permissionService.isAuthorized(user, group, [Permissions.DELETE_GROUP]);

  if (!group) {
    throw new Error("Group not found");
  }

  await removeAllMembers(groupId, user);

  for (let role of group.roles) {
    await roleService.deleteRole(role.id);
  }

  await database.getRepository(Group).remove(group);

  return group;
};

const addMember = async (memberId, roleId, groupId, actionIssuer) => {
  const userService = require("./user.service");
  const newMember = await userService.getUserById(memberId);
  let memberRole = await roleService.getRoleById(roleId);
  const group = await getGroupById(groupId);

  if (!newMember || !group) throw Error("Not found");

  if (!memberRole) {
    for (let role of group.roles) {
      if (role.name != roleService.CREATOR) memberRole = role;
      if (role.name == roleService.MEMBER) {
        memberRole = role;
        break;
      }
    }
  }

  // by pass authorization for group creator
  if (group.creator.id != memberId) {
    await permissionService.isAuthorized(actionIssuer, group, [
      Permissions.ADD_MEMBER,
    ]);
  }

  // check if user is already a member
  const [alreadyMember] = group.members.filter(
    (mem) => mem.user.id == memberId
  );
  if (alreadyMember) throw Error("Conflict");

  const membership = database.getRepository(Membership).create({
    role: memberRole,
  });

  group.members.push(membership);
  newMember.memberships.push(membership);

  await database.getRepository(User).save(newMember);
  return await database.getRepository(Group).save(group);
};

const removeMember = async (userId, groupId, actionIssuer) => {
  const group = await getGroupById(groupId);

  await permissionService.isAuthorized(actionIssuer, group, [
    Permissions.REMOVE_MEMBER,
  ]);

  if (group.creator.id == userId) {
    throw Error("Unauthorized");
  }
  for (let membership of group.members) {
    if (membership.user.id == userId) {
      await database.getRepository(Membership).remove(membership);
    }
  }
};

const removeAllMembers = async (groupId, actionIssuer) => {
  const group = await getGroupById(groupId);

  await permissionService.isAuthorized(actionIssuer, group, [
    Permissions.REMOVE_MEMBER,
  ]);

  for (let member of group.members) {
    await database.getRepository(Membership).remove(member);
  }
};

// check membership

const isMember = async (groupId, memberId) => {
  const userService = require("./user.service");
  const group = await getGroupById(groupId);
  const user = await userService.getUserById(memberId);

  if (!group || !user) {
    throw new Error("Group or user not found");
  }

  const [membership] = user.memberships.filter(
    (membership) => membership.group.id === group.id
  );

  if (!membership) {
    return false;
  }

  return true;
};

//join a group
const joinGroup = async (groupId, userId) => {
  const group = await getGroupById(groupId);
  if (!group) {
    throw new Error("Group not found");
  }
  const userService = require("./user.service");
  const user = await userService.getUserById(userId);

  if (!user) {
    throw new Error("User not found");
  }

  const groupCreator = await userService.getUserById(group.creator.id);
  await addMember(userId, roleService.MEMBER, groupId, groupCreator);
};

//leave a group
const leaveGroup = async (groupId, userId) => {
  const group = await getGroupById(groupId);

  if (!group) {
    throw new Error("Group not found");
  }
  const userService = require("./user.service");
  const user = await userService.getUserById(userId);

  const [membership] = user.memberships.filter(
    (membership) => membership.group.id === group.id
  );
  if (!membership) throw Error("Unauthorized");

  const groupCreator = await userService.getUserById(group.creator.id);
  await removeMember(userId, groupId, groupCreator);
};
// remove a member
module.exports = {
  getAllGroups,
  getGroupById,
  getGroupsByName,
  createGroup,
  updateGroup,
  deleteGroup,
  addMember,
  joinGroup,
  leaveGroup,
  removeMember,
  isMember,
};
