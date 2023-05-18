const { Like } = require("typeorm");
const { Group, Role, Membership, User } = require("../models/");
const database = require("../configs/db.config");
const userService = require("./user.service");
const roleService = require("./role.service");
const permissionService = require("./permissions.service");
const { Permissions } = permissionService;

const getAllGroups = async () => {
  return await database.getRepository(Group).find({
    include: { all: true },
    // relations: { members: true, roles: true, creator: true },
  });
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

    return group;
  }
};

const getGroupById = async (id) => {
  if (!id) return null;

  const group = await database.getRepository(Group).findOne({
    where: { id },
    relations: { members: true, creator: true, roles: true },
  });

  return group;
};

const createGroup = async (groupName, creator, description) => {
  const group = database.getRepository(Group).create({
    name: groupName,
    description,
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

  return await addMember(creator.id, creatorRole.id, newGroup.id, creator);
};

const deleteGroup = async (groupId, user) => {
  const group = await getGroupById(groupId);

  await permissionService.isAuthorized(user, group, [Permissions.DELETE_GROUP]);

  if (!group) {
    throw new Error("Group not found");
  }

  await removeAllMembers(groupId);

  for (let role of group.roles) {
    await roleService.deleteRole(role.id);
  }

  await database.getRepository(Group).remove(group);

  return group;
};

const addMember = async (memberId, roleId, groupId, actionIssuer) => {
  const newMember = await userService.getUserById(memberId);
  const memberRole = await roleService.getRoleById(roleId);
  const group = await getGroupById(groupId);

  if (!newMember || !memberRole || !group) throw Error("Not found");

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

const removeAllMembers = async (groupId) => {
  const group = await getGroupById(groupId);

  for (let member of group.members) {
    await database.getRepository(Membership).remove(member);
  }
};

module.exports = {
  getAllGroups,
  getGroupById,
  getGroupsByName,
  createGroup,
  deleteGroup,
  addMember,
  removeMember,
};
