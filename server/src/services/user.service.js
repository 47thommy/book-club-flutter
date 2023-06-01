const { User, Group, Membership } = require("../models/");
const database = require("../configs/db.config");
const bcrypt = require("bcryptjs");
const { getGroupById } = require("./group.service");

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

const getUserByUsername = async (username, includePassword = false) => {
  if (!username) return null;

  // since select is false password hash will not be included here
  const user = await database.getRepository(User).findOne({
    where: { username },
    relations: { memberships: true, createdGroups: true },
  });

  // include password here if required
  if (user && includePassword) {
    user.password = (
      await database
        .getRepository(User)
        .createQueryBuilder("user")
        .select("user.username")
        .addSelect("user.password")
        .where("user.username = :username", { username })
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

  for (var membership of user.memberships) {
    membership.group = await getGroupById(membership.group.id);
  }

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
  last_name,
  username,
  bio
) => {
  const passwordHash = bcrypt.hashSync(password);
  console.log("newUser");
  const newUser = database.getRepository(User).create({
    email,
    password: passwordHash,
    first_name,
    middle_name,
    last_name,
    username,
    bio,
  });

  console.log(newUser);
  const user = await database.getRepository(User).save(newUser);
  return user;
};

const updateUser = async (
  id,
  password,
  first_name,
  middle_name,
  last_name,
  username,
  bio,
  imageUrl
) => {
  const user = await getUserById(id);
  if (!user) throw { error: "User not found" };
  // check if the user deleted his/her account

  if (username) {
    const existingUser = await getUserByUsername(username);
    if (existingUser && existingUser.id != id)
      throw { error: "Username is already taken" };
    user.username = username;
  }

  if (password) {
    const passwordHash = bcrypt.hashSync(password);
    user.password = passwordHash;
  }

  if (first_name) user.first_name = first_name;
  if (middle_name) user.middle_name = middle_name;
  if (last_name) user.last_name = last_name;
  if (username) user.username = username;
  if (bio) user.bio = bio;
  if (imageUrl) user.imageUrl = imageUrl;

  const updatedUser = await database.getRepository(User).save(user);

  return await getUserById(updatedUser.id);
};

const deleteUser = async (id) => {
  const user = await getUserById(id);

  if (!user) {
    throw { error: "User not found" };
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
  getUserByUsername,
  getUserById,
  createUser,
  updateUser,
  deleteUser,
};
