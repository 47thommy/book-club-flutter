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
            array: true,
        },
    },

    relations: {
        creator: {
            target: "User",
            type: "many-to-one",
            joinColumn: true,
        },

        votes: {
            target: "Vote",
            type: "one-to-many",
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
        },

        voter: {
            target: "User",
            type: "one-to-one",
            joinColumn: true,
        },
    },
});


module.exports = { Poll, Vote };