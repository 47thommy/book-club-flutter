const userService = require("../services/user.service");

const updateUser = async (req, res) => {
  const id = req.params.id;
  const { email, password, first_name, middle_name, last_name } = req.body;

  try {
    const updatedUser = await userService.updateUser(
      id,
      email,
      password,
      first_name,
      middle_name,
      last_name
    );
    res.status(200).json({ success: true, user: updatedUser });
  } catch (error) {
    res.status(500).json({ success: false, message: "Server Error" });
  }
};

const deleteUser = async (req, res) => {
  const { id } = req.params;

  try {
    const user = await userService.deleteUser(id);
    res.json({ user });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Server error" });
  }
};

module.exports = { updateUser, deleteUser };
