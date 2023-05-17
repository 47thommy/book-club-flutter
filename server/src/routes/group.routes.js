const express = require("express");
const { loginRequired, isAuthorized } = require("../middlewares/auth");
const {
  deleteGroupValidation,
  createGroupValidation,
} = require("../middlewares/validation/group.validation");

const groupController = require("../controllers/group.controller");

const router = express.Router();

// router.get("/", loginRequired, groupController.getGroup);
router.post(
  "/",
  loginRequired,
  createGroupValidation,
  groupController.createGroup
);
// router.patch("/:id", loginRequired, groupController.updateGroup);
router.delete(
  "/:id",
  loginRequired,
  deleteGroupValidation,
  groupController.deleteGroup
);
router.post("/:groupId/join", loginRequired, groupController.joinGroup);
router.post("/:groupId/leave", loginRequired, groupController.leaveGroup);
router.delete(
  "/:groupId/members/:memberId",
  loginRequired,
  isAuthorized("creator"),
  groupController.removeMember
);

module.exports = router;
