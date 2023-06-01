const { ReadingList } = require("../models/");
const database = require("../configs/db.config");



const getReadingListById = async (id) => {
    if (!id) return null;

    const readingList = await database
        .getRepository(ReadingList)
        .findOne({ where: { id }, relations: { book: true, group: true, creator: true } });

    if (!readingList) return null;

    return readingList;
};

const createReadingList = async (group, book, creator) => {
    const readingList = database.getRepository(ReadingList).create(({
        // group: group,
        // book: book,
        // creator: creator,
    }));

    readingList.group = group;
    readingList.book = book;

    const newReadingList = await database.getRepository(ReadingList).save(readingList);
    return newReadingList;

};

const updateReadingList = async (id, book) => {
    const readingList = await getReadingListById(id);

    if (!readingList) {
        throw new Error("ReadingList Not Found");
    }

    readingList.book = book;

    await database.getRepository(ReadingList).save(readingList);

    return book;

};


const deleteReadingList = async (id, user) => {
    const readingList = await getReadingListById(id);

    if (!readingList) {
        throw new Error("ReadingList Not Found");
    }

    await database.getRepository(ReadingList).remove(readingList);

    return readingList;
}


module.exports = {
    getReadingListById,
    createReadingList,
    updateReadingList,
    deleteReadingList,
};
