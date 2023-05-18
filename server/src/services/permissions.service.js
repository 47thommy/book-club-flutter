const { Permission, Role } = require("../models/");
const database = require("../configs/db.config");

const Permissions = {
  CREATE_POLL: 1,
  MODIFY_POLL: 2,
  CREATE_MEETING: 3,
  MODIFY_MEETING: 4,
  CREATE_READING_LIST: 5,
  MODIFY_READING_LIST: 6,
  ADD_MEMBER: 7,
  REMOVE_MEMBER: 8,
  DELETE_GROUP: 9,
};

const permissions = [
  { id: Permissions.CREATE_POLL, name: "Create poll" },
  { id: Permissions.MODIFY_POLL, name: "Modify poll" },
  { id: Permissions.CREATE_MEETING, name: "Create meeting" },
  { id: Permissions.MODIFY_MEETING, name: "Modify meeting" },
  { id: Permissions.CREATE_READING_LIST, name: "Create reading list" },
  { id: Permissions.MODIFY_READING_LIST, name: "Modify reading list" },
  { id: Permissions.ADD_MEMBER, name: "Add member" },
  { id: Permissions.REMOVE_MEMBER, name: "Remove member" },
  { id: Permissions.DELETE_GROUP, name: "Delete group" },
];

const initializePermissions = async () => {
  const dbPermissions = await getAllPermissions();
  if (dbPermissions.length > 0) return;
  for (let permission of permissions) {
    await database.getRepository(Permission).save(permission);
  }
};

const getPermissionById = async (id) => {
  if (!id) return null;

  const permission = await database.getRepository(Permission).findOne({
    where: { id },
  });

  return permission;
};

const getAllPermissions = async () => {
  return await database
    .getRepository(Permission)
    .find({ include: { all: true } });
};

const isAuthorized = async (user, group, requiredPermissions = []) => {
  const [membership] = user.memberships.filter(
    (membership) => membership.group.id === group.id
  );

  if (!membership || !membership.role || !membership.role.id)
    throw Error("Unauthorized");

  const userRole = await database.getRepository(Role).findOne({
    where: { id: membership.role.id },
    relations: { permissions: true },
  });

  const permissions = userRole.permissions.map((permission) => permission.id);

  if (!permissions) throw Error("Unauthorized");

  for (let permission of requiredPermissions) {
    if (!permissions.includes(permission)) {
      throw Error("Unauthorized");
    }
  }
};

module.exports = {
  Permissions,
  initializePermissions,
  getPermissionById,
  getAllPermissions,
  isAuthorized,
};
