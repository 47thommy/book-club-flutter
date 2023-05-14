const database = require("../configs/db.config");
const { User } = require("../models/");
const bcrypt = require("bcryptjs");

const getUserByEmail = async (email) => {
  return await database.getRepository(User).findOneBy({ email });
};

const getUserById = async (id) => {
  const user = await database.getRepository(User).findOneBy({ id });

  return user;
};

const createUser = async (email, password) => {
  const passwordHash = bcrypt.hashSync(password);
  const newUser = database.getRepository(User).create({
    email,
    password: passwordHash,
  });

  const user = await database.getRepository(User).save(newUser);

  return user;
};

module.exports = {
  getUserByEmail,
  getUserById,
  createUser,
};
