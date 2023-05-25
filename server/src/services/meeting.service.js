const { Meeting } = require("../models/");
const database = require("../configs/db.config");


const getMeetingById = async (id) => {
    if (!id) return null;

    const meeting = await database
        .getRepository(Meeting)
        .findOne({ where: { id } });

    if (!meeting) return null;

    return meeting;
};


const createMeeting = async (description, time, location, creator, group) => {

    const meeting = database.getRepository(Meeting).create({
        description: description,
        time: time,
        location: location,
    });
    
    meeting.creator = creator;
    meeting.group = group;

    const newMeeting = await database.getRepository(Meeting).save(meeting);
        
    return newMeeting;
};


const updateMeeting = async (id, description, time, location, user) => {
    const meeting = await getMeetingById(id);

    if (!meeting) {
        throw new Error("Meeting Not Found");
    }

    meeting.description = description;
    meeting.time = time;
    meeting.location = location;

    await database.getRepository(Meeting).save(meeting);

    return meeting;

}


const deleteMeeting = async (id, user) => {
    const meeting = await getMeetingById(id);

    if (!meeting) {
        throw new Error("Meeting Not Found");
    };

    await database.getRepository(Meeting).remove(meeting);
    return meeting;

};



module.exports = {
    getMeetingById,
    createMeeting,
    updateMeeting,
    deleteMeeting,
};