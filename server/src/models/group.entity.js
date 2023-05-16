const GroupSchema = require("typeorm").EntitySchema;
const MembershipSchema = require("typeorm").EntitySchema;

const Group = new GroupSchema({
  name: "Group",

  columns: {
    id: {
      primary: true,
      type: "int",
      generated: true,
    },

    name: {
      type: "varchar",
    },

    description: {
      type: "varchar",
    },
  },

  relations: {
    creator: {
      target: "User",
      type: "many-to-one",
      joinColumn: true,
    },

    members: {
      target: "Membership",
      type: "one-to-many",
      inverseSide: "group",
      cascade: true,
    },
  },
});

const Membership = new MembershipSchema({
  name: "Membership",

  columns: {
    id: {
      primary: true,
      type: "int",
      generated: true,
    },

    role: {
      type: "varchar",
    },
  },

  relations: {
    user: {
      target: "User",
      type: "many-to-one",
      joinColumn: true,
    },

    group: {
      target: "Group",
      type: "many-to-one",
      joinColumn: true,
    },
  },
});

module.exports = { Group, Membership };
