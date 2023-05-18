const express = require("express");
const { loginRequired } = require("../middlewares/auth");
const roleController = require("../controllers/role.controller");

const {
  createRoleValidator,
} = require("../middlewares/validation/role.validation");

const router = express.Router();

router.post(
  "/:groupId/role",
  loginRequired,
  createRoleValidator,
  roleController.createRole
);

module.exports = router;
