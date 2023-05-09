const express = require("express");
const router = express.Router();
const db = require("./dbConnection");
const { signupValidation, loginValidation } = require("./validation");

const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
router.post("/register", signupValidation, (req, res, next) => {
  db.query(
    `SELECT * FROM users WHERE LOWER(email) = LOWER(${db.escape(
      req.body.email
    )});`,
    (err, result) => {
      if (result.length) {
        return res.status(409).send({
          msg: "This user is already in use!",
        });
      } else {
        bcrypt.hash(req.body.password, 10, (err, hash) => {
          if (err) {
            return res.status(500).send({
              msg: err,
            });
          } else {
            db.query(
              `INSERT INTO users (name, email, password) VALUES ('${
                req.body.name
              }', ${db.escape(req.body.email)}, ${db.escape(hash)})`,
              (err, result) => {
                if (err) {
                  return res.status(400).send({
                    msg: err,
                  });
                }
                return res.status(201).send({
                  msg: "User registered successfully!",
                });
              }
            );
          }
        });
      }
    }
  );
});
router.post("/login", loginValidation, (req, res, next) => {
  db.query(
    `SELECT * FROM users WHERE email = ${db.escape(req.body.email)};`,
    (err, result) => {
      if (err) {
        return res.status(400).send({
          msg: err,
        });
      }
      if (!result.length) {
        return res.status(401).send({
          msg: "Email or password is incorrect!",
        });
      }
      bcrypt.compare(
        req.body.password,
        result[0]["password"],
        (bErr, bResult) => {
          // wrong password
          if (bErr) {
            return res.status(401).send({
              msg: "Email or password is incorrect!",
            });
          }
          if (bResult) {
            const token = jwt.sign(
              { id: result[0].id },
              "the-super-strong-secrect",
              { expiresIn: "1h" }
            );
            db.query(
              `UPDATE users SET last_login = now() WHERE id = '${result[0].id}'`
            );
            return res.status(200).send({
              msg: " User logged in successfully!",
              token,
              user: result[0],
            });
          }
          return res.status(401).send({
            msg: "Username or password is incorrect!",
          });
        }
      );
    }
  );
});
router.get("/get-user", signupValidation, (req, res, next) => {
  if (
    !req.headers.authorization ||
    !req.headers.authorization.startsWith("Bearer") ||
    !req.headers.authorization.split(" ")[1]
  ) {
    return res.status(422).json({
      message: "Please provide the token",
    });
  }
  const theToken = req.headers.authorization.split(" ")[1];
  const decoded = jwt.verify(theToken, "the-super-strong-secrect");
  db.query(
    "SELECT * FROM users where id=?",
    decoded.id,
    function (error, results, fields) {
      if (error) throw error;
      return res.send({
        error: false,
        data: results[0],
        message: "Fetch Successfully.",
      });
    }
  );
});

router.delete("/delete-user", (req, res, next) => {
  const token = req.headers.authorization.split(" ")[1];

  try {
    const decoded = jwt.verify(token, "the-super-strong-secrect");
    const userId = decoded.id;

    db.query(`DELETE FROM users WHERE id = ${db.escape(userId)};`, (err) => {
      if (err) {
        return res.status(400).send({
          msg: err,
        });
      }

      return res.status(200).send({
        msg: "User deleted successfully!",
      });
    });
  } catch (err) {
    return res.status(401).send({
      msg: "Invalid token",
    });
  }
});

router.put("/update-user", (req, res, next) => {
  if (
    !req.headers.authorization ||
    !req.headers.authorization.startsWith("Bearer") ||
    !req.headers.authorization.split(" ")[1]
  ) {
    return res.status(422).json({
      message: "Please provide the token",
    });
  }

  const theToken = req.headers.authorization.split(" ")[1];
  const decoded = jwt.verify(theToken, "the-super-strong-secrect");

  db.query(
    "SELECT * FROM users where id=?",
    decoded.id,
    function (error, results) {
      if (error) throw error;

      if (results.length === 0) {
        return res.status(404).json({
          message: "User not found",
        });
      }

      db.query(
        `UPDATE users SET name = ${db.escape(
          req.body.name
        )}, email = ${db.escape(req.body.email)} WHERE id = ${decoded.id}`,
        function (error, results) {
          if (error) throw error;

          db.query(
            "SELECT * FROM users where id=?",
            decoded.id,
            function (error) {
              if (error) throw error;

              return res.send({
                error: false,
                data: results[0],
                message: "User updated successfully",
              });
            }
          );
        }
      );
    }
  );
});

module.exports = router;
