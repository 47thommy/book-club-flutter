const { Group, Membership, User } = require("../models/");
const database = require("../configs/db.config");

const getGroupByName = async (name) => {
  if (!name) return null;

  const group = await database
    .getRepository(Group)
    .findOne({ where: { name }, relations: { members: true, creator: true } });

  return group;
};

const getGroupById = async (id) => {
  if (!id) return null;

  const group = await database
    .getRepository(Group)
    .findOne({ where: { id }, relations: { members: true, creator: true } });

  return group;
};

const createGroup = async (groupName, creator, description) => {
  const group = database.getRepository(Group).create({
    name: groupName,
    description,
  });

  group.creator = creator;

  const newGroup = await database.getRepository(Group).save(group);

  return newGroup;
};

const deleteGroup = async (id) => {
  const group = await getGroupById(id);

  if (!group) {
    throw new Error("Group not found");
  }

  await database.getRepository(Group).remove(group);

  return group;
};

module.exports = {
  getGroupById,
  getGroupByName,
  createGroup,
  deleteGroup,
};
