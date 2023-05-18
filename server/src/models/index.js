const User = require("./user.entity");
const { Group, Membership } = require("./group.entity");

const { Poll, Vote } = require("./poll.entity");
const { Role } = require("./authorization/role.entity");
const { Permission } = require("./authorization/permission.entity");

module.exports = {
  User,
  Group,
  Membership,
  Poll,
  Vote,
  Role,
  Permission,
};
