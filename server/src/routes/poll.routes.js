const express = require("express");
const { loginRequired } = require("../middlewares/auth");



const pollController = require("../controllers/poll.controller");

const router = express.Router();

router.post(
    "/",
    loginRequired,
    pollController.createPoll
);

router.get(
    "/:id",
    loginRequired,
    pollController.getPoll
);

router.delete(
    "/:id",
    loginRequired,
    pollController.deletePoll
);

module.exports = router;