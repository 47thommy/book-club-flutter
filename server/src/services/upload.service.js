const multer = require("multer");
const uuid = require("uuid");

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "uploads");
  },
  filename: function (req, file, cb) {
    cb(null, `${uuid.v4()}_${file.originalname}`);
  },
});

const upload = multer({ storage: storage });

module.exports = { storage, upload };
