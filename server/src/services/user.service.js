const { User, Group, Membership } = require("../models/");
const database = require("../configs/db.config");
const bcrypt = require("bcryptjs");

const getUserByEmail = async (email, includePassword = false) => {
  if (!email) return null;

  // since select is false password hash will not be included here
  const user = await database.getRepository(User).findOne({
    where: { email },
    relations: { memberships: true, createdGroups: true },
  });

  // include password here if required
  if (user && includePassword) {
    user.password = (
      await database
        .getRepository(User)
        .createQueryBuilder("user")
        .select("user.email")
        .addSelect("user.password")
        .where("user.email = :email", { email })
        .getOne()
    ).password;
  }

  return user;
};

const getUserById = async (id, includePassword = false) => {
  if (!id) return null;

  // since select is false password hash will not be included here
  const user = await database.getRepository(User).findOne({
    where: { id },
    relations: { memberships: true, createdGroups: true },
  });

  // include password here if required
  if (user && includePassword) {
    user.password = (
      await database
        .getRepository(User)
        .createQueryBuilder("user")
        .select("user.id")
        .addSelect("user.password")
        .where("user.id = :id", { id })
        .getOne()
    ).password;
  }

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
  // check if the user deleted his/her account

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

  if (user.createdGroups.length > 0) {
    await Promise.all(
      user.createdGroups.map(async (group) => {
        await database.getRepository(Group).remove(group);
      })
    );
  }
  if (user.memberships.length > 0) {
    await Promise.all(
      user.memberships.map(async (membership) => {
        await database.getRepository(Membership).remove(membership);
      })
    );
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
