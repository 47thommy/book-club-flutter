const { StatusCodes } = require("http-status-codes");
const { validationResult } = require("express-validator");

const readingListService = require("../services/readinglist.service");
const bookService = require("../services/book.service");
const groupService = require("../services/group.service");

const createReadingList = async (req, res) => {
    const result = validationResult(req);

    if (!result.isEmpty()) {
        res.status(StatusCodes.BAD_REQUEST).json({
            errors: result.array,
        });
        return;
    }

    try {
        const book = await bookService.getBookByID(req.body.bookId);
        const group = await groupService.getGroupById(req.body.groupId);

        if (!book || !group) {
            return res.status(StatusCodes.NOT_FOUND).json();
        }

        const newReadingList = await readingListService.createReadingList(book, group, req.user);

        if (newReadingList) {
            return res.status(StatusCodes.CREATED).json(newReadingList);
        }
        res.status(StatusCodes.BAD_REQUEST).json();
    } catch {
        res.status(StatusCodes.BAD_REQUEST).json();
    }
};


const getReadingList = async (req, res) => {
    const readingList = await readingListService.getReadingListById(req.params.id);

    if (!readingList) {
        return res.status(StatusCodes.NOT_FOUND).json();
    }

    res.status(StatusCodes.OK).json(readingList);
};

const updateReadingList = async (req, res) => {
    const readingList = await readingListService.getReadingListById(req.params.id);

    if (!readingList) {
        return res.status(StatusCodes.NOT_FOUND).json();
    }

    const book = await bookService.getBookByID(req.body.bookId);

    const newReadingList = await readingListService.updateReadingList(req.params.id, book);

    res.status(StatusCodes.OK).json(newReadingList);

}


const deleteReadingList = async (req, res) => {
    const readingList = await readingListService.getReadingListById(req.params.id);

    if (!readingList) {
        return res.status(StatusCodes.NOT_FOUND).json();
    }

    try {
        if (readingList.creator.id == req.user.id) {
            const deletedReadingList = await readingListService.deleteReadingList(req.params.id, req.user);

            if (deletedReadingList) {
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
    createReadingList,
    getReadingList,
    updateReadingList,
    deleteReadingList,
};