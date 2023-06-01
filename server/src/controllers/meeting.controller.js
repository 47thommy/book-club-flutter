const { StatusCodes } = require("http-status-codes");
const { validationResult } = require("express-validator");

const meetingService = require("../services/meeting.service");
const groupService = require("../services/group.service");

const createMeeting = async (req, res) => {
  // const result = validationResult(req);

  // if (!result.isEmpty()) {
  //     res.status(StatusCodes.BAD_REQUEST).json({ errors: result.array });
  //     return;
  // }

  try {
    const group = await groupService.getGroupById(req.body.groupId);

    if (!group) {
      return res.status(StatusCodes.NOT_FOUND).json();
    }

    const newMeeting = await meetingService.createMeeting(
      req.body.description,
      req.body.time,
      req.body.location,
      req.user,
      group
    );

    if (newMeeting) {
      return res.status(StatusCodes.CREATED).json(newMeeting);
    }
    res.status(StatusCodes.BAD_REQUEST).json();
  } catch {
    res.status(StatusCodes.BAD_REQUEST).json();
  }
};

const getMeeting = async (req, res) => {
  const meeting = await meetingService.getMeetingById(req.params.id);

  if (!meeting) {
    return res.status(StatusCodes.NOT_FOUND).json();
  }

  res.status(StatusCodes.OK).json(meeting);
};

const deleteMeeting = async (req, res) => {
  const meeting = await meetingService.getMeetingById(req.params.id);

  if (!meeting) {
    return res.status(StatusCodes.NOT_FOUND).json();
  }

  try {
    if (meeting.creator.id == req.user.id) {
      const deletedMeeting = await meetingService.deleteMeeting(
        req.params.id,
        req.user
      );

      if (deletedMeeting) {
        return res.status(StatusCodes.OK).json();
      }

      res.status(StatusCodes.NOT_FOUND).json();
    } else {
      res.status(StatusCodes.FORBIDDEN).json();
    }
  } catch {
    res.status(StatusCodes.BAD_REQUEST).json();
  }
};

const updateMeeting = async (req, res) => {
  const meeting = await meetingService.getMeetingById(req.params.id);

  if (!meeting) {
    return res.status(StatusCodes.NOT_FOUND).json();
  }

  const newMeeting = await meetingService.updateMeeting(
    req.params.id,
    req.body.description,
    req.body.time,
    req.body.location,
    req.user
  );
  res.status(StatusCodes.OK).json(newMeeting);
};

module.exports = {
  createMeeting,
  getMeeting,
  updateMeeting,
  deleteMeeting,
};
