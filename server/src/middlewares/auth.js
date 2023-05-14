const { StatusCodes } = require("http-status-codes");
const { verifyToken } = require("../services/auth.service");

const loginRequired = async (req, res, next) => {
  const token = req.headers.token;

  if (!token) {
    return res
      .status(StatusCodes.FORBIDDEN)
      .json("Authentication token is required!");
  }

  try {
    const user = await verifyToken(token);

    req.user = user;
  } catch (err) {
    return res.status(StatusCodes.UNAUTHORIZED).send("Invalid Token");
  }

  return next();
};

module.exports = {
  loginRequired,
};
