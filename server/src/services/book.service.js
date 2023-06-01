const { Book } = require("../models/");
const database = require("../configs/db.config");

const getBookByID = async (id) => {
    if (!id) return null;

    const book = await database
        .getRepository(Book)
        .findOne({ where: { id } });

    if (!book) return null;

    return book;
};

const createBook = async (title, author, description, pageCount, genre) => {
    const book = database.getRepository(Book).create(({
        title: title,
        author: author,
        description: description,
        pageCount: pageCount,
        genre: genre,
    }));


    const newBook = await database.getRepository(book);
    return newBook;

};

const updateBook = async (bookId, title, author, description, pageCount, genre) => {
    const book = await getBookByID(bookId);

    if (!book) {
        throw new Error("Book Not Found");
    }

    book.title = title;
    book.author = author;
    book.description = description
    book.pageCount = pageCount;
    book.genre = genre;


    await database.getRepository(Book).save(book)

    return book;

};


const deleteBook = async (id, user) => {
    const book = await getBookByID(id);

    if (!book) {
        throw new Error("Book Not Found");
    }

    await database.getRepository(Book).remove(book);

    return book;
}


module.exports = {
    getBookByID,
    createBook,
    updateBook,
    deleteBook,
};
