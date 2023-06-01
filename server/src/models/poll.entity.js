const PollSchema = require("typeorm").EntitySchema;
const VoteSchema = require("typeorm").EntitySchema;

const Poll = new PollSchema({
  name: "Poll",

  columns: {
    id: {
      primary: true,
      type: "int",
      generated: true,
    },

    question: {
      type: "varchar",
    },

    options: {
      type: "varchar",
      // array: true,
    },
  },

  relations: {
    creator: {
      target: "User",
      type: "many-to-one",
      joinColumn: true,
      eager: true,
    },

    votes: {
      target: "Vote",
      type: "one-to-many",
      inverseSide: "poll",
    },

    group: {
      target: "Group",
      type: "many-to-one",
      joinColumn: true,
    },
  },
});

const Vote = new VoteSchema({
  name: "Vote",

  columns: {
    id: {
      primary: true,
      type: "int",
      generated: true,
    },

    choice: {
      type: "varchar",
    },
  },

  relations: {
    poll: {
      target: "Poll",
      type: "many-to-one",
      joinColumn: true,
      eager: true,
    },

    voter: {
      target: "User",
      type: "many-to-one",
      joinColumn: true,
      eager: true,
      onDelete: "CASCADE",
    },
  },
});

module.exports = { Poll, Vote };
