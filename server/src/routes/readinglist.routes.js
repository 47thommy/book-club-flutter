const express = require("express");
const { loginRequired } = require("../middlewares/auth");


const readingListController = require("../controllers/readinglist.controller");

const router = express.Router();

router.post(
    "/",
    loginRequired,
    readingListController.createReadingList
);

router.get(
    "/:id",
    loginRequired,
    readingListController.getReadingList
);

router.patch(
    "/:id",
    loginRequired,
    readingListController.updateReadingList
);

router.delete(
    "/:id",
    loginRequired,
    readingListController.deleteReadingList
);

module.exports = router;