const { StatusCodes } = require("http-status-codes");
const { validationResult } = require("express-validator");
const {
  verifyCredentials,
  generateToken,
} = require("../services/auth.service");
const { getUserByEmail, createUser } = require("../services/user.service");

const register = async (req, res) => {
  const result = validationResult(req);

  if (!result.isEmpty()) {
    res.status(StatusCodes.BAD_REQUEST).json({ errors: result.array() });
    return;
  }

  try {
    const { email, password, first_name, middle_name, last_name } = req.body;

    if (await getUserByEmail(email)) {
      res
        .status(StatusCodes.CONFLICT)
        .json("User with provided email already exists.");
    } else {
      const newUser = createUser(
        email,
        password,
        first_name,
        middle_name,
        last_name
      );

      if (newUser) {
        res.status(StatusCodes.CREATED).json({ email });
        return;
      }
      res.status(StatusCodes.BAD_REQUEST).json();
    }
  } catch {
    res.status(StatusCodes.BAD_REQUEST).json();
  }
};

const login = async (req, res) => {
  const result = validationResult(req);

  if (!result.isEmpty()) {
    res.status(StatusCodes.BAD_REQUEST).json({ errors: result.array() });
    return;
  }

  const { email, password } = req.body;

  if (await verifyCredentials(email, password)) {
    const userToken = await generateToken(email);

    res.json({
      token: userToken,
    });
  } else {
    res.status(StatusCodes.UNAUTHORIZED).json("Invalid credentials");
  }
};

module.exports = {
  login,
  register,
};
