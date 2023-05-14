const UserSchema = require("typeorm").EntitySchema;

const User = new UserSchema({
  name: "User",
  columns: {
    id: {
      primary: true,
      type: "int",
      generated: true,
    },

    email: {
      type: "varchar",
    },

    password: {
      type: "varchar",
    },
    first_name: {
      type: "varchar",
    },
    middle_name: {
      type: "varchar",
    },
    last_name: {
      type: "varchar",
    },
  },
});

module.exports = User;
