require("dotenv").config();
const express = require("express");
const database = require("./src/configs/db.config");

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

app.use("/auth", authRouter);

// ==================================================================
//                      Initialize Database
// ==================================================================
database
  .initialize()
  .then(() => {
    console.log("Database successfully initialized!");
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
