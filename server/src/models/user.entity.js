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

    username: {
      type: "varchar",
    },

    bio: {
      type: "varchar",
      default: "",
    },

    imageUrl: {
      default: "",
      type: "varchar",
    },

    password: {
      type: "varchar",
      select: false,
    },

    first_name: {
      type: "varchar",
    },

    last_name: {
      type: "varchar",
    },
  },

  relations: {
    createdGroups: {
      target: "Group",
      type: "one-to-many",
      inverseSide: "creator",
    },

    memberships: {
      target: "Membership",
      type: "one-to-many",
      inverseSide: "user",
      cascade: true,
    },
  },
});

module.exports = User;
