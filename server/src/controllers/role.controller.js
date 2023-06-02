const { StatusCodes } = require("http-status-codes");
const { validationResult } = require("express-validator");

const groupService = require("../services/group.service");
const roleService = require("../services/role.service");

const createRole = async (req, res) => {
  const result = validationResult(req);

  if (!result.isEmpty()) {
    res.status(StatusCodes.BAD_REQUEST).json({ errors: result.array() });
    return;
  }

  const group = await groupService.getGroupById(req.params.groupId);
  const roleName = req.body.name;
  const permissionIds = req.body.permissions;

  if (!group) {
    return res.status(StatusCodes.NOT_FOUND).json("Group not found.");
  }

  try {
    const newRole = await roleService.createRole(
      roleName,
      req.user,
      group,
      permissionIds
    );

    if (newRole) {
      return res.status(StatusCodes.CREATED).json(newRole);
    }
  } catch (err) {
    switch (err.message) {
      case "Unauthorized":
        return res
          .status(StatusCodes.FORBIDDEN)
          .json("Insufficient priviledges to perform action.");
      case "Not found":
        return res
          .status(StatusCodes.NOT_FOUND)
          .json("Role, group or user not found.");
      case "Conflict":
        return res
          .status(StatusCodes.CONFLICT)
          .json("User is already a member.");
      default:
        return res.status(StatusCodes.CONFLICT).json(err.message);
    }
  }
  res.status(StatusCodes.BAD_REQUEST).json();
};

const getGroupRoles = async (req, res) => {
  const group = await groupService.getGroupById(req.params.groupId);

  if (group) return res.json(group.roles);

  res.status(StatusCodes.NOT_FOUND).json();
};

const getRole = async (req, res) => {};
const updateRole = async (req, res) => {
  try {
    const role = await roleService.updateRole(
      req.params.roleId,
      req.body.name,
      req.body.permissions,
      req.user
    );
    if (role) {
      return res.status(StatusCodes.OK).json(role);
    }
  } catch (error) {
    return res.status(StatusCodes.BAD_REQUEST).json(error);
  }
  return res.status(StatusCodes.BAD_REQUEST).json(error);
};

const deleteRole = async (req, res) => {
  try {
    const role = await roleService.deleteRole(req.params.roleId, req.user);
    if (role) {
      return res.status(StatusCodes.OK).json();
    }
  } catch (error) {
    return res.status(StatusCodes.BAD_REQUEST).json(error);
  }
  return res.status(StatusCodes.BAD_REQUEST).json(error);
};

const assignRole = async (req, res) => {
  try {
    console.log("...");
    const role = await roleService.assignRole(
      req.body.roleId,
      req.body.userId,
      req.params.groupId,
      req.user
    );
    console.log(role);
    if (role) {
      return res.status(StatusCodes.OK).json();
    }
  } catch (error) {
    return res.status(StatusCodes.BAD_REQUEST).json(error);
  }
  return res.status(StatusCodes.BAD_REQUEST).json(error);
};

module.exports = {
  createRole,
  getGroupRoles,
  getRole,
  updateRole,
  deleteRole,
  assignRole,
};
