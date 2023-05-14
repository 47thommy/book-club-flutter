const express = require("express");
const router = express.Router();
const controller = require("../controllers/auth.controller");
const {
  registerValidator,
} = require("../middlewares/validation/auth.validation");

router.post("/register", registerValidator, controller.register);
router.post("/login", controller.login);

module.exports = router;
