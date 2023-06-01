const express = require("express");
const { loginRequired } = require("../middlewares/auth");

const bookController = require("../controllers/book.controller");

const router = express.Router();

router.post("/:groupId", loginRequired, bookController.createBook);

router.get("/:id", loginRequired, bookController.getBook);

router.patch("/:id", loginRequired, bookController.updateBook);

router.delete("/:id", loginRequired, bookController.deleteBook);

module.exports = router;
