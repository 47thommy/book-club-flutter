const express = require("express");
const { loginRequired } = require("../middlewares/auth");



const voteController = require("../controllers/poll.controller");

const router = express.Router();

router.post(
    "/",
    loginRequired,
    voteController.createVote
);

router.get(
    "/:id",
    loginRequired,
    voteController.getVote
);

router.delete(
    "/:id",
    loginRequired,
    voteController.deleteVote
);

router.patch(
    '/:id',
    loginRequired,
    voteController.updateVote
)

module.exports = router;