const { StatusCodes } = require("http-status-codes");
const { validationResult } = require("express-validator");

const bookService = require("../services/book.service");
const groupService = require("../services/group.service");


const createBook = async (req, res) => {
    const result = validationResult(req);

    if (!result.isEmpty()) {
        res.status(StatusCodes.BAD_REQUEST).json({
            errors: result.array,
        });
        return;
    }

    try {

        const group = await groupService.getGroupById(req.body.groupId);
        if (!group) {
            return res.status(StatusCodes.NOT_FOUND).json();
        }

        const newBook = await bookService.createBook(
            req.body.title,
            req.body.author,
            req.body.description,
            req.body.pageCount,
            req.body.genre,
            group
        );

        if (newBook) {
            return res.status(StatusCodes.CREATED).json(newBook);
        }
        res.status(StatusCodes.BAD_REQUEST).json();
    } catch {
        res.status(StatusCodes.BAD_REQUEST).json();
    }
};


const getBook = async (req, res) => {
    const book = await bookService.getBookByID(req.params.id);

    if (!book) {
        return res.status(StatusCodes.NOT_FOUND).json();
    }

    res.status(StatusCodes.OK).json(book);
};

const updateBook = async (req, res) => {

    const book = await bookService.getBookByID(req.params.id);
    if (!book) {
        return res.status(StatusCodes.NOT_FOUND).json();
    }

    const newBook = await bookService.updateBook(
        req.params.id,
        req.body.title,
        req.body.author,
        req.body.description,
        req.body.pageCount,
        req.body.genre,
    );

    res.status(StatusCodes.OK).json(newBook);

}


const deleteBook = async (req, res) => {
    const book = await bookService.getBookByID(req.params.id);

    if (!book) {
        return res.status(StatusCodes.NOT_FOUND).json();
    }

    try {
        const deletedBook = await bookService.deleteBook(req.params.id);

        if (deletedBook) {
            return res.status(StatusCodes.OK).json();
        }
        res.status(StatusCodes.BAD_REQUEST).json();

    } catch {
        res.status(StatusCodes.BAD_REQUEST).json();
    }
};


module.exports = {
    createBook,
    getBook,
    updateBook,
    deleteBook,
};