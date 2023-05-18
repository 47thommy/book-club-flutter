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

app.use(express.json());

// ==================================================================
//                              Routes
// ==================================================================
const authRouter = require("./src/routes/auth.routes");
const userRouter = require("./src/routes/user.routes");
const groupRouter = require("./src/routes/group.routes");

const roleRouter = require("./src/routes/role.routes");

const pollRouter = require("./src/routes/poll.routes");
const voteRouter = require("./src/routes/vote.routes");

app.use("/auth", authRouter);
app.use("/user", userRouter);
app.use("/group", groupRouter);
app.use("/group", roleRouter);
app.use("/poll", pollRouter);
app.use("/vote", voteRouter);

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

module.exports = database;
