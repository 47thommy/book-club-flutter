const jwt = require("jsonwebtoken");
const bcrypt = require("bcryptjs");
const database = require("../configs/db.config");
const { User } = require("../models/");
const { getUserByEmail, getUserById } = require("./user.service");

const generateToken = async (email) => {
  const user = await getUserByEmail(email);

  if (!user) return;

  const token = jwt.sign(
    {
      id: user.id,
      email: user.email,
    },
    process.env.SECRET,
    {
      expiresIn: process.env.JWT_AGE,
    }
  );
  return token;
};

const verifyCredentials = async (email, password) => {
  const user = await getUserByEmail(email);

  if (user == null) return false;
  return bcrypt.compareSync(password, user.password);
};

const verifyToken = async (token) => {
  const decoded = jwt.verify(token, process.env.SECRET);

  const user = await getUserById(decoded.id);

  if (!user) throw Error();

  return user;
};

module.exports = {
  generateToken,
  verifyToken,
  verifyCredentials,
};
