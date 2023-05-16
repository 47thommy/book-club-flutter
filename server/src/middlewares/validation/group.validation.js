const { param, body } = require("express-validator");

createGroupValidation = [
  body("name", "Group name is required.").notEmpty(),
  body("description", "Group description is required.").notEmpty(),
];
deleteGroupValidation = [param("id").isInt()];

module.exports = { deleteGroupValidation, createGroupValidation };
