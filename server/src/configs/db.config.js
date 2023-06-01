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
  Book,
  // ReadingList,
} = require("../models");

const database = new typeorm.DataSource({
  type: "sqlite",
  database: "bookclub.sqlite",
  entities: [
    User,
    Group,
    Membership,
    Poll,
    Vote,
    Role,
    Permission,
    Meeting,
    Book,
  ],
  synchronize: true,
});

module.exports = database;
