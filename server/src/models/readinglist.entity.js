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
       createdGroups: {
            target: "Group",
            type: "one-to-one",
            inverseSide: "group"

       },

       books: {
        target: "Book",
        type: "one-to-many",
        inverseSide: "book",
       },
    },
});