const express = require("express");
const { loginRequired } = require("../middlewares/auth");
const {
  deleteGroupValidation,
  createGroupValidation,
  membershipValidation,
} = require("../middlewares/validation/group.validation");

const groupController = require("../controllers/group.controller");

const router = express.Router();

// get groups
router.get("/", loginRequired, groupController.getGroup);

// create group
router.post(
  "/",
  loginRequired,
  createGroupValidation,
  groupController.createGroup
);

// router.patch("/:id", loginRequired, groupController.updateGroup);
// delete group
router.delete(
  "/:id",
  loginRequired,
  deleteGroupValidation,
  groupController.deleteGroup
);

// add member
router.post(
  "/:groupId",
  loginRequired,
  membershipValidation,
  groupController.addMember
);

module.exports = router;
