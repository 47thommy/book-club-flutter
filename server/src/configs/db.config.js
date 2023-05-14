const typeorm = require("typeorm");
const { User } = require("../models");

const database = new typeorm.DataSource({
  type: "sqlite",
  database: "bookclub.sqlite",
  entities: [User],
  synchronize: true,
});

module.exports = database;
