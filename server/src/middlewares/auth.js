const { StatusCodes } = require("http-status-codes");
const { verifyToken } = require("../services/auth.service");
const database = require("../configs/db.config");
const { Group, Membership, User } = require("../models/");
const { getGroupById } = require("../services/group.service");
const loginRequired = async (req, res, next) => {
  const token = req.headers.token;

  if (!token) {
    return res
      .status(StatusCodes.FORBIDDEN)
      .json("Authentication token is required!");
  }

  try {
    const user = await verifyToken(token);

    req.user = user;
  } catch (err) {
    return res.status(StatusCodes.UNAUTHORIZED).send("Invalid Token");
  }

  return next();
};

const isAuthorized = (role) => async (req, res, next) => {
  const { groupId } = req.params;
  const group = getGroupById(groupId);
  if (!group) {
    return res.status(StatusCodes.NOT_FOUND).json({ error: "Group not found" });
  }
  console.log(groupId, "groupId");
  const token = req.headers.token;

  const user = await verifyToken(token);
  console.log(user);
  try {
    const existingMembership = await database
      .getRepository(Membership)
      .findOne({
        where: {
          user: user,
          group: group,
          role: role,
        },
      });
    console.log(existingMembership, "existingMembership");
    if (!existingMembership || existingMembership.role !== role) {
      return res
        .status(StatusCodes.FORBIDDEN)
        .json({ error: "You don't have the required role" });
    }

    next();
  } catch (error) {
    res
      .status(StatusCodes.INTERNAL_SERVER_ERROR)
      .json({ error: error.message });
  }
};

module.exports = {
  loginRequired,
  isAuthorized,
};
