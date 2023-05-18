const { Role } = require("../models/");
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
    relations: { group: true },
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

const updateRole = async (roleId, user, newName, permissionIds) => {
  const role = await getRoleById(id);

  if (!role) throw Error("Role not found.");

  if (role.name == CREATOR) throw Error("Creator role can't be edited.");

  if (newName) {
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

const deleteRole = async (id) => {
  const role = await getRoleById(id);

  if (!role) {
    throw new Error("Role not found.");
  }

  await database.getRepository(Role).remove(role);

  return role;
};

module.exports = {
  CREATOR,
  ORGANIZER,
  MEMBER,
  getRoleById,
  createRole,
  updateRole,
  deleteRole,
};
