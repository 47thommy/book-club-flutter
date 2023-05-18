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
      eager: true,
    },

    members: {
      target: "Membership",
      type: "one-to-many",
      inverseSide: "group",
      cascade: true,
    },

    roles: {
      target: "Role",
      type: "one-to-many",
      inverseSide: "group",
      cascade: true,
      eager: true,
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
  },

  relations: {
    user: {
      target: "User",
      type: "many-to-one",
      joinColumn: true,
      eager: true,
    },

    group: {
      target: "Group",
      type: "many-to-one",
      joinColumn: true,
      eager: true,
    },

    role: {
      target: "Role",
      type: "many-to-one",
      joinColumn: true,
      eager: true,
    },
  },
});

module.exports = { Group, Membership };
