const express = require("express");
const { loginRequired } = require("../middlewares/auth");
const roleController = require("../controllers/role.controller");

const {
  createRoleValidator,
} = require("../middlewares/validation/role.validation");

const router = express.Router();

router.get(
  "/:groupId/role/:roleId",
  loginRequired,
  roleController.getRole
);

router.post(
  "/:groupId/role",
  loginRequired,
  createRoleValidator,
  roleController.createRole
);

router.patch(
  "/:groupId/role/:roleId",
  loginRequired,
  roleController.updateRole
)

router.delete(
  "/:groupId/role/:roleId",
  loginRequired,
  roleController.deleteRole
)

module.exports = router;
