const { Meeting } = require("../models/");
const database = require("../configs/db.config");
const { Permissions } = require("./permissions.service");
const permissionService = require("./permissions.service");

const getMeetingById = async (id) => {
  if (!id) return null;

  const meeting = await database
    .getRepository(Meeting)
    .findOne({ where: { id }, relations: { group: true, creator: true } });

  if (!meeting) return null;

  return meeting;
};

const createMeeting = async (
  description,
  time,
  location,
  date,
  creator,
  group
) => {
  await permissionService.isAuthorized(creator, group, [
    Permissions.CREATE_MEETING,
  ]);

  const meeting = database.getRepository(Meeting).create({
    description: description,
    time: time,
    location: location,
    date: date,
  });

  meeting.creator = creator;
  meeting.group = group;

  const newMeeting = await database.getRepository(Meeting).save(meeting);

  return newMeeting;
};

const updateMeeting = async (id, description, time, date, location, user) => {
  const meeting = await getMeetingById(id);

  if (!meeting) {
    throw new Error("Meeting Not Found");
  }

  await permissionService.isAuthorized(user, meeting.group, [
    Permissions.MODIFY_MEETING,
  ]);

  meeting.description = description;
  meeting.time = time;
  meeting.date = date;
  meeting.location = location;

  console.log(meeting);

  return await database.getRepository(Meeting).save(meeting);
};

const deleteMeeting = async (id, user) => {
  await permissionService.isAuthorized(creator, group, [
    Permissions.MODIFY_MEETING,
  ]);

  const meeting = await getMeetingById(id);

  if (!meeting) {
    throw new Error("Meeting Not Found");
  }

  await database.getRepository(Meeting).remove(meeting);
  return meeting;
};

module.exports = {
  getMeetingById,
  createMeeting,
  updateMeeting,
  deleteMeeting,
};
