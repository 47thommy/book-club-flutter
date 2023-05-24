const typeorm = require("typeorm");

const {
  User,
  Group,
  Membership,
  Poll,
  Vote,
  Role,
  Permission,
  Meeting,
} = require("../models");


const database = new typeorm.DataSource({
  type: "sqlite",
  database: "bookclub.sqlite",
  entities: [User, Group, Membership, Poll, Vote, Role, Permission, Meeting],
  synchronize: true,
});

module.exports = database;
