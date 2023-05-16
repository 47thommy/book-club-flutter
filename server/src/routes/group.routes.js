const express = require("express");
const { loginRequired } = require("../middlewares/auth");
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

module.exports = router;
