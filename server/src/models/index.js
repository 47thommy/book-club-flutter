const User = require("./user.entity");
const { Group, Membership } = require("./group.entity");

const { Poll, Vote } = require("./poll.entity");
const { Role } = require("./authorization/role.entity");
const { Permission } = require("./authorization/permission.entity");
const { Meeting } = require("./meeting.entity");
const { Book } = require("./book.entity");
const { ReadingList } = require("./readinglist.entity");

module.exports = {
  User,
  Group,
  Membership,
  Poll,
  Vote,
  Role,
  Permission,
  Meeting,
  Book,
  ReadingList,
};
