const { body, query } = require("express-validator");

getUser = [query("id").isInt().optional(), query("email").isEmail().optional()];

updateValidation = [
  body("email").isEmail().optional({ nullable: true }),
  body("password", "Password must be 6 or more characters")
    .isLength({
      min: 6,
    })
    .optional({ nullable: true }),
];

module.exports = { updateValidation, getUser };
