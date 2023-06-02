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

    imageUrl: {
      default: "",
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
      onDelete: "CASCADE",
      eager: true,
    },

    polls: {
      target: "Poll",
      type: "one-to-many",
      inverseSide: "group",
      cascade: true,
      onDelete: "CASCADE",
      eager: true,
    },

    books: {
      target: "Book",
      type: "one-to-many",
      inverseSide: "group",
      cascade: true,
    },

    meetings: {
      target: "Meeting",
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
