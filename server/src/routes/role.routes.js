const express = require("express");
const { loginRequired } = require("../middlewares/auth");
const roleController = require("../controllers/role.controller");

const {
  createRoleValidator,
} = require("../middlewares/validation/role.validation");

const router = express.Router();

router.get("/:groupId/role/", loginRequired, roleController.getGroupRoles);

router.get("/:groupId/role/:roleId", loginRequired, roleController.getRole);

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
);

router.delete(
  "/:groupId/role/:roleId",
  loginRequired,
  roleController.deleteRole
);

router.post(
  "/:groupId/assign",
  loginRequired,
  createRoleValidator,
  roleController.assignRole
);

module.exports = router;
