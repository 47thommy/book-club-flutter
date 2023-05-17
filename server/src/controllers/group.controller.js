const { StatusCodes } = require("http-status-codes");
const { validationResult } = require("express-validator");

const groupService = require("../services/group.service");
const { verifyToken } = require("../services/auth.service");

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
      req.body.description
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
    if (group.creator.id == req.user.id) {
      const deletedGroup = await groupService.deleteGroup(group.id);

      if (deletedGroup) {
        return res.status(StatusCodes.OK).json();
      }
      res.status(StatusCodes.BAD_REQUEST).json();
    } else {
      return res.status(StatusCodes.FORBIDDEN).json();
    }
  } catch (err) {
    res.status(StatusCodes.BAD_REQUEST).json();
  }
};

// join a group
const joinGroup = async (req, res) => {
  try {
    const { groupId } = req.params;
    const token = req.headers.token;
    const user = await verifyToken(token);

    req.user = user;
    const userId = user.id;
    console.log(userId);

    await groupService.joinGroup(groupId, userId);
    res.status(200).json({ message: "Welcome to the group!" });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
// leave a group
const leaveGroup = async (req, res) => {
  try {
    const { groupId } = req.params;
    const token = req.headers.token;
    const user = await verifyToken(token);

    req.user = user;
    const userId = user.id;

    await groupService.leaveGroup(groupId, userId);
    res.status(200).json({ message: "You have left the group!" });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// remove a member
const removeMember = async (req, res) => {
  const { groupId, memberId } = req.params;

  try {
    await groupService.removeMember(groupId, memberId);
    res.status(200).json({ message: "Member removed from the group" });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

module.exports = {
  createGroup,
  deleteGroup,
  joinGroup,
  leaveGroup,
  removeMember,
};
