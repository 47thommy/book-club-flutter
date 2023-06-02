const { Role, Group, User, Membership } = require("../models/");
const database = require("../configs/db.config");
const permissionService = require("./permissions.service");

const { Permissions } = permissionService;

// Default roles and permissions for group
const CREATOR = "Owner";
const ORGANIZER = "Organizer";
const MEMBER = "Reader";
const ORGANIZER_DEFAULT_PERMISSIONS = [
  Permissions.ADD_MEMBER,
  Permissions.CREATE_MEETING,
  Permissions.CREATE_POLL,
  Permissions.CREATE_READING_LIST,
];
const MEMBER_DEFAULT_PERMISSIONS = [Permissions.ADD_MEMBER];

const getRoleById = async (id) => {
  if (!id) return null;

  const role = await database.getRepository(Role).findOne({
    where: { id },
    relations: { group: true, permissions: true },
  });

  return role;
};

const createRole = async (roleName, creator, group, permissionIds) => {
  if (group.creator.id != creator.id) throw Error("Unauthorized");

  const role = database.getRepository(Role).create({
    name: roleName,
  });

  if (group.roles) {
    for (let r of group.roles) {
      if (r.name == roleName) {
        throw Error("Role already exists.");
      }
    }
  }

  role.group = group;

  if (role.name == CREATOR) {
    role.permissions = await permissionService.getAllPermissions();
    const newRole = await database.getRepository(Role).save(role);
    return newRole;
  } else if (role.name == ORGANIZER) {
    permissionIds = ORGANIZER_DEFAULT_PERMISSIONS;
  } else if (role.name == MEMBER) {
    permissionIds = MEMBER_DEFAULT_PERMISSIONS;
  }

  role.permissions = [];

  let permission;

  for (let id of permissionIds) {
    permission = await permissionService.getPermissionById(id);

    if (permission) {
      role.permissions.push(permission);
    }
  }

  const newRole = await database.getRepository(Role).save(role);

  return newRole;
};

const updateRole = async (roleId, newName, permissionIds, actionIssuer) => {
  const role = await getRoleById(roleId);

  if (!role) throw { error: "Role not found." };

  if (role.group.creator.id != actionIssuer.id) throw { error: "Unauthorized" };

  if (role.name == CREATOR) throw { error: "Creator role can't be edited." };

  if (newName && role.name != MEMBER) {
    role.name = newName;
  }

  if (permissionIds) {
    role.permissions = [];

    let permission;

    for (let id of permissionIds) {
      permission = await permissionService.getPermissionById(id);

      if (permission) {
        role.permissions.push(permission);
      }
    }
  }

  const updatedRole = await database.getRepository(Role).save(role);

  return updatedRole;
};

const deleteRole = async (id, actionIssuer) => {
  const role = await getRoleById(id);

  if (!role) {
    throw new { error: "Role not found." }();
  }

  const group = role.group;

  if (group.creator.id != actionIssuer.id) {
    throw {
      error: "Unauthorized",
    };
  }

  if (role.name == CREATOR || role.name == MEMBER)
    throw { error: `${role.name} role can't be deleted.` };

  if (group) {
    group.roles = group.roles.filter((role) => role.id !== id);
    await database.getRepository(Group).save(role.group);
  }

  await database.getRepository(Role).remove(role);

  return role;
};

const assignRole = async (roleId, userId, groupId, actionIssuer) => {
  const userService = require("./user.service");
  const groupService = require("./group.service");

  const user = await userService.getUserById(userId);
  console.log("1");
  const group = await groupService.getGroupById(groupId);
  console.log("2");
  const role = await getRoleById(roleId);
  console.log("3");

  console.log(user, group, role);

  if (!role || !user || !group) throw { error: "Not found" };

  if (group.creator.id != actionIssuer.id) throw { error: "Unauthorized" };

  if (!(await groupService.isMember(groupId, userId)))
    throw { error: "User is not member of this group" };

  await groupService.removeMember(userId, groupId, actionIssuer);
  return await groupService.addMember(userId, roleId, groupId, actionIssuer);
};

const revokeRole = async (roleId, userId, groupId, actionIssuer) => {
  const userService = require("./user.service");
  const groupService = require("./group.service");

  const user = await userService.getUserById(userId);
  const group = await groupService.getGroupById(groupId);
  const role = await getRoleById(roleId);

  if (!role || !user || !group) throw { error: "Not found" };

  if (group.creator.id != actionIssuer.id) throw { error: "Unauthorized" };

  if (!(await groupService.isMember(groupId, userId)))
    throw { error: "User is not member of this group" };

  await groupService.removeMember(userId, groupId, actionIssuer);
  await groupService.addMember(userId, MEMBER, groupId, actionIssuer);
};

module.exports = {
  CREATOR,
  ORGANIZER,
  MEMBER,
  getRoleById,
  createRole,
  updateRole,
  deleteRole,
  assignRole,
};
