const { StatusCodes } = require("http-status-codes");
const { validationResult } = require("express-validator");

const groupService = require("../services/group.service");

const getGroup = async (req, res) => {
  // get user by id
  if (req.query.id) {
    const group = await groupService.getGroupById(req.query.id);

    if (group) {
      return res.json(group);
    } else {
      return res.status(StatusCodes.NOT_FOUND).json();
    }
  } else if (req.query.name) {
    const group = await groupService.getGroupsByName(req.query.name);

    if (group) {
      return res.json(group);
    } else {
      return res.status(StatusCodes.NOT_FOUND).json();
    }
  } else {
    return res.json(await groupService.getAllGroups());
  }
};

const createGroup = async (req, res) => {
  const result = validationResult(req);

  if (!result.isEmpty()) {
    res.status(StatusCodes.BAD_REQUEST).json({ errors: result.array() });
    return;
  }

  try {
    const newGroup = await groupService.createGroup(
      req.body.name,
      req.user,
      req.body.description,
      req.body.imageUrl
    );

    if (newGroup) {
      return res.status(StatusCodes.CREATED).json(newGroup);
    }

    res.status(StatusCodes.BAD_REQUEST).json();
  } catch (err) {
    res.status(StatusCodes.BAD_REQUEST).json();
  }
};

const deleteGroup = async (req, res) => {
  const group = await groupService.getGroupById(req.params.id);

  if (!group) {
    return res.status(StatusCodes.NOT_FOUND).json();
  }

  try {
    const deletedGroup = await groupService.deleteGroup(group.id, req.user);

    if (deletedGroup) {
      return res.status(StatusCodes.OK).json();
    }
  } catch (err) {
    if (err.message == "Unauthorized") {
      return res
        .status(StatusCodes.FORBIDDEN)
        .json("Insufficient priviledge to perform action.");
    }
  }
  return res.status(StatusCodes.BAD_REQUEST).json();
};

const addMember = async (req, res) => {
  const result = validationResult(req);

  if (!result.isEmpty()) {
    res.status(StatusCodes.BAD_REQUEST).json({ errors: result.array() });
    return;
  }

  const groupId = req.params.groupId;
  const memberId = req.body.memberId;
  const roleId = req.body.roleId;

  try {
    await groupService.addMember(memberId, roleId, groupId, req.user);
    res.json();
  } catch (err) {
    switch (err.message) {
      case "Unauthorized":
        return res
          .status(StatusCodes.FORBIDDEN)
          .json("Insufficient priviledges to perform action.");
      case "Not found":
        return res
          .status(StatusCodes.NOT_FOUND)
          .json("Role, group or user not found.");
      case "Conflict":
        return res
          .status(StatusCodes.CONFLICT)
          .json("User is already a member.");
      default:
        return res.status(StatusCodes.BAD_REQUEST).json();
    }
  }
};

// join a group
const joinGroup = async (req, res) => {
  try {
    const { groupId } = req.params;

    const userId = req.user.id;

    await groupService.joinGroup(groupId, userId);

    res.json({ message: "Welcome to the group!" });
  } catch (error) {
    res
      .status(StatusCodes.INTERNAL_SERVER_ERROR)
      .json({ error: error.message });
  }
};
// leave a group
const leaveGroup = async (req, res) => {
  try {
    await groupService.leaveGroup(req.params.groupId, req.user.id);
    res.status(200).json({ message: "You have left the group!" });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// remove a member
const removeMember = async (req, res) => {
  const { groupId, memberId } = req.params;

  try {
    if (await groupService.isMember(groupId, memberId)) {
      await groupService.removeMember(memberId, groupId, req.user);
      return res.status(200).json({ message: "Member removed from the group" });
    } else {
      return res.status(StatusCodes.NOT_FOUND).json();
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

module.exports = {
  createGroup,
  deleteGroup,
  getGroup,
  addMember,
  joinGroup,
  leaveGroup,
  removeMember,
};
