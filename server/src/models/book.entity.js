const BookSchema = require("typeorm").EntitySchema;

const Book = new BookSchema({
  name: "Book",

  columns: {
    id: {
      primary: true,
      type: "int",
      generated: true,
    },

    title: {
      type: "varchar",
    },

    author: {
      type: "varchar",
    },

    description: {
      type: "varchar",
    },

    pageCount: {
      type: "int",
    },

    genre: {
      type: "varchar",
    },
  },

  relations: {
    group: {
      target: "Group",
      type: "many-to-one",
      joinColumn: true,
      eager: true,
    },
  },
});

module.exports = { Book };
