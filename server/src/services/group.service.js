const { Group, Membership, User } = require("../models/");
const database = require("../configs/db.config");
const { getUserById } = require("./user.service");

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

  const membership = database.getRepository(Membership).create({
    user: creator,
    group: group,
    role: "creator",
  });

  await database.getRepository(Membership).save(membership);

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

//join a group
const joinGroup = async (groupId, userId) => {
  try {
    const group = await getGroupById(groupId);
    if (!group) {
      throw new Error("Group not found");
    }
    const user = await getUserById(userId);

    const existingMembership = await database
      .getRepository(Membership)
      .findOne({
        where: {
          user: user,
          group: group,
        },
      });

    if (existingMembership) {
      throw new Error("User is already a member of the group");
    }
    const membership = database.getRepository(Membership).create({
      user: user,
      group: group,
      role: "member",
    });

    await database.getRepository(Membership).save(membership);
  } catch (error) {
    throw new Error(error.message);
  }
};

//leave a group
const leaveGroup = async (groupId, userId) => {
  try {
    const group = await getGroupById(groupId);

    if (!group) {
      throw new Error("Group not found");
    }
    const user = await getUserById(userId);
    const existingMembership = await database
      .getRepository(Membership)
      .findOne({
        where: {
          user: user,
          group: group,
        },
      });

    if (!existingMembership) {
      throw new Error("Member not found");
    }

    await database.getRepository(Membership).remove(existingMembership);
  } catch (error) {
    throw new Error(error.message);
  }
};
// remove a member
const removeMember = async (groupId, memberId) => {
  try {
    const group = await getGroupById(groupId);
    if (!group) {
      throw new Error("Group not found");
    }

    const membership = await database.getRepository(Membership).findOne({
      where: {
        id: memberId,
        group: group,
      },
    });
    console.log(membership, "membership");

    if (!membership) {
      throw new Error("Member not found in the group");
    }
    console.log(membership);
    if (membership.role === "creator") {
      throw new Error("Creator cannot be removed from the group");
    }
    await database.getRepository(Membership).remove(membership);
  } catch (error) {
    throw new Error(error.message);
  }
};
module.exports = {
  getGroupById,
  getGroupByName,
  createGroup,
  deleteGroup,
  joinGroup,
  leaveGroup,
  removeMember,
};
