const { StatusCodes } = require("http-status-codes");
const { validationResult } = require("express-validator");

const bookService = require("../services/book.service");
const readingListService = require("../services/readinglist.service");

const createBook = async (req, res) => {
    const result = validationResult(req);

    if (!result.isEmpty()) {
        res.status(StatusCodes.BAD_REQUEST).json({
            errors: result.array,
        });
        return;
    }

    try {
        
        const newBook = await bookService.createPoll(
            req.body.title,
            req.body.author,
            req.body.description,
            req.body.pageCount,
            req.body.genre,
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

    if(!book) {
        return res.status(StatusCodes.NOT_FOUND).json();
    }

    const newBook = await bookService.updateBook(
        req.params.id,
        req.body.title,
        req.body.author,
        req.body.description,
        req.body.pageCount,
        req.body.genre,
        req.body.readingList
    );

    res.status(StatusCodes.OK).json(newBook);

}


const deleteBook = async (req, res) => {
    const book = await bookService.getBookByID(req.params.id);

    if (!book)  {
        return res.status(StatusCodes.NOT_FOUND).json();
    }
    
    try {
        if (book.creator.id == req.user.id) {
            const deletedBook = await bookService.deleteBook(req.params.id, req.user);

            if (deletedBook) {
                return res.status(StatusCodes.OK).json();
            }
            res.status(StatusCodes.BAD_REQUEST).json();
        } else {
            res.status(StatusCodes.FORBIDDEN).json();
        }
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