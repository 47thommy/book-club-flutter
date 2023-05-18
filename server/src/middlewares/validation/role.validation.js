const { body, param } = require("express-validator");

const createRoleValidator = [
  body("name", "Role name field is required.").notEmpty(),
  body("permissions", "Permissions must be an array").isArray(),
  param("groupId", "Group id must be an integer").isInt(),
];

module.exports = {
  createRoleValidator,
};
