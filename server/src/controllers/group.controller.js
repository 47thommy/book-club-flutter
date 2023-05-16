const { StatusCodes } = require("http-status-codes");
const { validationResult } = require("express-validator");

const groupService = require("../services/group.service");

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

module.exports = { createGroup, deleteGroup };
