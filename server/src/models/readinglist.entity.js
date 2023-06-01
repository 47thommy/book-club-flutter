const ReadingListSchema = require("typeorm").EntitySchema;

const ReadingList = new ReadingListSchema({
  name: "ReadingList",

  columns: {
    id: {
      primary: true,
      type: "int",
      generated: true,
    },
  },

  relations: {
    group: {
      target: "Group",
      type: "one-to-one",
      inverseSide: "group",
    },

    book: {
      target: "Book",
      type: "one-to-many",
      inverseSide: "book",
    },

    creator: {
      target: "User",
      type: "many-to-one",
      inverseSide: true,
    },
  },
});

module.exports = { ReadingList };
