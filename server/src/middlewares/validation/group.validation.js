const { param, body } = require("express-validator");

const createGroupValidation = [
  body("name", "Group name is required.").notEmpty(),
  body("description", "Group description is required.").notEmpty(),
];

const deleteGroupValidation = [param("id").isInt()];

const membershipValidation = [body("memberId").isInt()];

module.exports = {
  deleteGroupValidation,
  createGroupValidation,
  membershipValidation,
};
