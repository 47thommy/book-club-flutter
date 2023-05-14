const { User } = require("../models/");
const database = require("../configs/db.config");

const bcrypt = require("bcryptjs");
const loginRequired = require("../middlewares/auth");

const getUserByEmail = async (email) => {
  const user = await database.getRepository(User).findOneBy({ email });
  return user;
};

const getUserById = async (id) => {
  const user = await database.getRepository(User).findOneBy({ id });

  return user;
};

const createUser = async (
  email,
  password,
  first_name,
  middle_name,
  last_name
) => {
  const passwordHash = bcrypt.hashSync(password);
  const newUser = database.getRepository(User).create({
    email,
    password: passwordHash,
    first_name,
    middle_name,
    last_name,
  });

  const user = await database.getRepository(User).save(newUser);

  return user;
};

loginRequired;

const updateUser = async (
  id,
  email,
  password,
  first_name,
  middle_name,
  last_name
) => {
  const user = await getUserById(id);
  if (!user) throw new Error("User not found");

  if (email) {
    const existingUser = await getUserByEmail(email);
    if (existingUser && existingUser._id != id)
      throw new Error("Email is already taken");
    user.email = email;
  }

  if (password) {
    const passwordHash = bcrypt.hashSync(password);
    user.password = passwordHash;
  }

  if (first_name) user.first_name = first_name;
  if (middle_name) user.middle_name = middle_name;
  if (last_name) user.last_name = last_name;

  await database.getRepository(User).save(user);

  return user;
};
const deleteUser = async (id) => {
  const user = await getUserById(id);

  if (!user) {
    throw new Error("User not found");
  }

  await database.getRepository(User).remove(user);

  return user;
};

module.exports = {
  getUserByEmail,
  getUserById,
  createUser,
  updateUser,
  deleteUser,
};
