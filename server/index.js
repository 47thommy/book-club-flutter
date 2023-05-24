require("dotenv").config();
const express = require("express");
const database = require("./src/configs/db.config");
const permissions = require("./src/services/permissions.service");

const app = express();

const PORT = process.env.PORT || 3000;

// ==================================================================
//                           Middlewares
// ==================================================================

// for debugging
app.use((req, res, next) => {
  console.log(req.method, req.path);
  next();
});

app.use(express.urlencoded({ extended: false }));
app.use(express.json());
app.use("/uploads", express.static(__dirname + "/uploads"));

// ==================================================================
//                              Routes
// ==================================================================
const uploadRoute = require("./src/routes/upload.routes");
const authRouter = require("./src/routes/auth.routes");
const userRouter = require("./src/routes/user.routes");
const groupRouter = require("./src/routes/group.routes");
const roleRouter = require("./src/routes/role.routes");
const pollRouter = require("./src/routes/poll.routes");
const voteRouter = require("./src/routes/vote.routes");
const meetingRouter = require("./src/routes/meeting.routes");

app.use("/uploads", uploadRoute);
app.use("/auth", authRouter);
app.use("/user", userRouter);
app.use("/group", groupRouter);
app.use("/group", roleRouter);
app.use("/poll", pollRouter);
app.use("/vote", voteRouter);
app.use("/meeting", meetingRouter);

// ==================================================================
//                      Initialize Database
// ==================================================================
database
  .initialize()
  .then(() => {
    permissions
      .initializePermissions()
      .then(console.log("Database successfully initialized!"));
  })
  .catch((err) => {
    console.log("Error during database initialization:", err);
  });

// ==================================================================
//                          Start server
// ==================================================================
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
