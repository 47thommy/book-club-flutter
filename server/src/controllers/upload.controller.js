const { StatusCodes } = require("http-status-codes");

const uploadImage = async (req, res) => {
  console.log(req.files);
  console.log(req.file);
  console.log(req.file.path);
  res.send(req.files);
};

module.exports = {
  uploadImage,
};
