const { Poll, Vote } = require("../models/");
const database = require("../configs/db.config");


const getPollById = async (id) => {
    if (!id) return null;

    const poll = await database
        .getRepository(Poll)
        .findOne({ where: { id } });

    if (!poll) return null;

    poll.options = JSON.parse(poll.options);
    return poll;
};

const createPoll = async (pollName, creator, question, options) => {
    const poll = database.getRepository(Poll).create({
        name: pollName,
        question: question,
        options: JSON.stringify(options),
    });

    poll.creator = creator;

    const newPoll = await database.getRepository(Poll).save(poll);

    return newPoll;
}

const deletePoll = async (id, user) => {
    const poll = await getPollById(id);

    if (!poll) {
        throw new Error("Poll Not Found");
    };

    await database.getRepository(Poll).remove(poll);
    return poll;
};




const getVoteById = async (id) => {
    if (!id) return null;

    const vote = await database
        .getRepository(Vote)
        .findOne({ where: { id }, relations: { voter: true, poll: true, } })

    return vote;
};

const createVote = async (poll, choice, voter) => {
    const vote = database.getRepository(Vote).create({
        choice: choice,
    })
    
    vote.poll = poll;
    vote.voter = voter;
    
    console.log(vote, 66)
    const newVote = await database.getRepository(Vote).save(vote);
    console.log(newVote, 123)

    return newVote;
};

const updateVote = async (voteId, choice, user) => {
    const vote = getVote(voteId);

    if (!vote) {
        throw new Error("Vote Not Found");
    }

    await database.getRepository(Vote).update(voteId, { choice });

    return vote;
}

const deleteVote = async (id, user) => {
    const vote = await getVoteById(id);
    
    if (!vote) {
        
        throw new Error("Vote Not Found")
    }

    await database.getRepository(Vote).remove(vote);

    return vote;
};


module.exports = {
    getPollById,
    createPoll,
    deletePoll,
    getVoteById,
    createVote,
    updateVote,
    deleteVote,
};
