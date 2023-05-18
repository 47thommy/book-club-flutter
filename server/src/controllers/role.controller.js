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
      return res.status(StatusCodes.CREATED).json();
    }
  } catch (err) {
    return res.status(StatusCodes.CONFLICT).json("Role already exists.");
  }
  res.status(StatusCodes.BAD_REQUEST).json();
};

module.exports = {
  createRole,
};
