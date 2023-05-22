const BookSchema = require("typeorm").EntitySchema;

const Book = new BookSchema({
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

        pagecount: {
            type: "int",
        },

        genre: {
            type: "varchar",
        },
    },

    relations: {
        readingList :{
            target: "ReadingList",
            type: "many-to-one",
            joinColumn: true,
            eager: true,
        },
    },


})