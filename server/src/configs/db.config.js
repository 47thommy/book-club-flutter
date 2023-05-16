const typeorm = require("typeorm");
const { User, Group, Membership } = require("../models");

const database = new typeorm.DataSource({
  type: "sqlite",
  database: "bookclub.sqlite",
  entities: [User, Group, Membership],
  synchronize: true,
});

module.exports = database;
