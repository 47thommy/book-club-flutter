const express = require("express");
const controller = require("../controllers/auth.controller");
const {
  registerValidator,
  loginValidator,
} = require("../middlewares/validation/auth.validation");

const router = express.Router();

router.post("/register", registerValidator, controller.register);
router.post("/login", loginValidator, controller.login);

module.exports = router;
