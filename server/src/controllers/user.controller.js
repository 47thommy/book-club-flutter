const { StatusCodes } = require("http-status-codes");
const userService = require("../services/user.service");
const { validationResult } = require("express-validator");

const getUser = async (req, res) => {
  const result = validationResult(req);

  if (!result.isEmpty()) {
    res.status(StatusCodes.BAD_REQUEST).json({ errors: result.array() });
    return;
  }

  // get user by id
  if (req.query.id) {
    const user = await userService.getUserById(req.query.id);

    if (user) {      
      return res.json(user);
    } else {
      return res.status(StatusCodes.NOT_FOUND).json();
    }
  } else if (req.query.email) {
    const user = await userService.getUserByEmail(req.query.email);

    if (user) {      
      return res.json(user);
    } else {
      return res.status(StatusCodes.NOT_FOUND).json();
    }
  }

  res.status(StatusCodes.BAD_REQUEST).json();
};

const updateUser = async (req, res) => {
  const result = validationResult(req);

  if (!result.isEmpty()) {
    res.status(StatusCodes.BAD_REQUEST).json({ errors: result.array() });
    return;
  }

  const id = req.params.id;
  const { email, password, first_name, middle_name, last_name } = req.body;

  // verify if update requesting user is authenticated
  if (req.user.id != id) return res.status(StatusCodes.FORBIDDEN).json();

  try {
    const updatedUser = await userService.updateUser(
      id,
      email,
      password,
      first_name,
      middle_name,
      last_name
    );    

    res.status(StatusCodes.OK).json({ success: true, user: updatedUser });
  } catch (error) {
    res
      .status(StatusCodes.INTERNAL_SERVER_ERROR)
      .json({ success: false, message: "Server Error" });
  }
};

const deleteUser = async (req, res) => {
  const { id } = req.params;

  // verify if delete requesting user is authenticated
  if (req.user.id != id) return res.status(StatusCodes.FORBIDDEN).json();

  try {
    const user = await userService.deleteUser(id);

    if (user) return res.json();
  } catch (error) {
    res
      .status(StatusCodes.INTERNAL_SERVER_ERROR)
      .json({ error: "Server error" });
  }
};

module.exports = { updateUser, deleteUser, getUser };
