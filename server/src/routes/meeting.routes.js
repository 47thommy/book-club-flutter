const express = require("express");
const { loginRequired } = require("../middlewares/auth");

const meetingController = require("../controllers/meeting.controller");

const router = express.Router();

router.post("/:groupId", loginRequired, meetingController.createMeeting);

router.get("/:id", loginRequired, meetingController.getMeeting);

router.patch("/:id", loginRequired, meetingController.updateMeeting);

router.delete("/:id", loginRequired, meetingController.deleteMeeting);

module.exports = router;
