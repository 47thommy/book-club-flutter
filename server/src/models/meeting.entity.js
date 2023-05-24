const MeetingSchema = require("typeorm").EntitySchema;

const Meeting = new MeetingSchema({
    name: "Meeting",

    columns: {
        id: {
            primary: true,
            type: "int",
            generated: true,
        },

        description: {
            type: "varchar",
        },

        time: {
            type: "varchar",
        },

        location: {
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

        group: {
            target: "Group",
            type: "many-to-one",
            inverseSide: "meeting",
            eager: true,
            onDelete: "CASCADE"
        }
    }
})

module.exports = { Meeting };