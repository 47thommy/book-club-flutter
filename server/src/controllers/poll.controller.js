const { StatusCodes } = require("http-status-codes");
const { validationResult } = require("express-validator");

const pollService = require("../services/poll.service");

const createPoll = async (req, res) => {
  const result = validationResult(req);

  if (!result.isEmpty()) {
    res.status(StatusCodes.BAD_REQUEST).json({
      errors: result.array,
    });
    return;
  }

  try {
    const newPoll = await pollService.createPoll(
      req.body.name,
      req.user,
      req.body.question,
      req.body.options
    );

    if (newPoll) {
      return res.status(StatusCodes.CREATED).json(newPoll);
    }

    res.status(StatusCodes.BAD_REQUEST).json();
  } catch {
    res.status(StatusCodes.BAD_REQUEST).json();
  }
};

const getPoll = async (req, res) => {
  const poll = await pollService.getPollById(req.params.id);

  if (!poll) {
    return res.status(StatusCodes.NOT_FOUND).json();
  }
  res.status(StatusCodes.OK).json(poll);
};

const deletePoll = async (req, res) => {
  const poll = await pollService.getPollById(req.params.id);

  if (!poll) {
    return res.status(StatusCodes.NOT_FOUND).json();
  }

  try {
    if (poll.creator.id == req.user.id) {
      const deletedPoll = await pollService.deletePoll(req.params.id, req.user);

      if (deletedPoll) {
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

const createVote = async (req, res) => {
  // const result = validationResult(req);

  // if (!result.isEmpty()) {
  //     res.status(StatusCodes.BAD_REQUEST).json({
  //         errors: result.array
  //     });
  //     return;
  // }

  try {
    const poll = await pollService.getPollById(req.body.pollId);

    if (!poll) {
      return res.status(StatusCodes.NOT_FOUND).json();
    }

    const newVote = await pollService.createVote(
      poll,
      req.body.choice,
      req.user
    );

    console.log(newVote, 44);

    if (newVote) {
      return res.status(StatusCodes.CREATED).json(newVote);
    }

    res.status(StatusCodes.BAD_REQUEST).json();
  } catch (err) {
    console.log(err);
    res.status(StatusCodes.BAD_REQUEST).json();
  }
};

const getVote = async (req, res) => {
  const vote = await pollService.getVoteById(req.params.id);

  if (!vote) {
    return res.status(StatusCodes.NOT_FOUND).json();
  }
  res.status(StatusCodes.OK).json(vote);
};

const updateVote = async (req, res) => {
  const vote = await pollService.getVoteById(req.params.id);

  if (!vote) {
    return res.status(StatusCodes.NOT_FOUND).json();
  }

  const newVote = await pollService.updateVote(req.params.id);
  res.status(StatusCodes.OK).json(newVote);
};

const deleteVote = async (req, res) => {
  const vote = await pollService.getVoteById(req.params.id);

  if (!vote) {
    return res.status(StatusCodes.NOT_FOUND).json();
  }

  try {
    if (vote.voter.id == req.user.id) {
      const deletedVote = await pollService.deleteVote(req.params.id, req.user);

      if (deletedVote) {
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
  createPoll,
  getPoll,
  deletePoll,
  createVote,
  getVote,
  updateVote,
  deleteVote,
};
