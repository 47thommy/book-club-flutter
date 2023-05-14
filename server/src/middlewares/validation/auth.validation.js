const { body } = require("express-validator");

registerValidator = [
  body("email", "Please include a valid email").isEmail(),
  body("password", "Password must be 6 or more characters")
    .notEmpty()
    .isLength({
      min: 6,
    }),
];

loginValidator = [
  body("email", "Please include a valid email").isEmail(),
  body("password", "Password must be 6 or more characters")
    .notEmpty()
    .isLength({
      min: 6,
    }),
];

module.exports = {
  registerValidator,
  loginValidator,
};
