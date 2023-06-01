const express = require("express");
const userController = require("../controllers/user.controller");
const { loginRequired } = require("../middlewares/auth");
const {
  updateValidation,
} = require("../middlewares/validation/user.validation");

const router = express.Router();

router.get("/", loginRequired, userController.getUser);
router.patch("/", loginRequired, updateValidation, userController.updateUser);
router.delete("/", loginRequired, userController.deleteUser);

module.exports = router;
