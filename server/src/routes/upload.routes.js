const express = require("express");
const { upload } = require("../services/upload.service");
const { uploadImage } = require("../controllers/upload.controller");

const router = express.Router();

router.post("/", upload.single("image"), uploadImage);
// router.get("/", upload.single("image"), uploadImage);

module.exports = router;
