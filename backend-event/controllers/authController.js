const db = require("../config/db");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");


// ======================
// REGISTER
// ======================
const register = async (req, res) => {

  try {

    const {
      name,
      email,
      password,
      phone,
      org
    } = req.body;

    // validasi
    if (!name || !email || !password) {
      return res.status(400).json({
        message: "Semua field wajib diisi"
      });
    }

    // cek email
    db.query(
      "SELECT * FROM users WHERE email = ?",
      [email],

      async (err, result) => {

        if (err) {
          return res.status(500).json(err);
        }

        // email sudah ada
        if (result.length > 0) {
          return res.status(400).json({
            message: "Email sudah digunakan"
          });
        }

        // hash password
        const hashedPassword =
          await bcrypt.hash(password, 10);

        // insert user
        db.query(
          `
          INSERT INTO users
          (
            name,
            email,
            password,
            role_id,
            phone,
            organization
          )
          VALUES (?, ?, ?, ?, ?, ?)
          `,
          [
            name,
            email,
            hashedPassword,
            2, // default role_id = 1 (user)
            phone || null,
            org || null
          ],

          (err, result) => {

            if (err) {
              return res.status(500).json(err);
            }

            res.status(201).json({
              message: "Register berhasil"
            });

          }
        );

      }
    );

  } catch (error) {

    res.status(500).json({
      error: error.message
    });

  }

};


// ======================
// LOGIN
// ======================
const login = (req, res) => {

  const { email, password } = req.body;

  db.query(
    "SELECT * FROM users WHERE email = ?",
    [email],

    async (err, result) => {

      if (err) {
        return res.status(500).json(err);
      }

      if (result.length === 0) {
        return res.status(401).json({
          message: "User tidak ditemukan"
        });
      }

      const user = result[0];

      // cek password
      const isMatch = await bcrypt.compare(
        password,
        user.password
      );

      if (!isMatch) {
        return res.status(401).json({
          message: "Password salah"
        });
      }

      // token
      const token = jwt.sign(
        {
          id: user.id,
          role_id: user.role_id
        },
        "secretkey",
        {
          expiresIn: "1d"
        }
      );

      res.json({
        message: "Login berhasil",
        token,

        user: {
          id: user.id,
          name: user.name,
          email: user.email,
          role_id: user.role_id
        }
      });

    }
  );

};


module.exports = {
  register,
  login
};