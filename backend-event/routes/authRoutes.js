const express = require("express");
const router = express.Router();

const {
  register,
  login
} = require("../controllers/authController");


// REGISTER
router.post("/register", register);

// LOGIN
router.post("/login", login);


// TEST
router.get("/test", (req, res) => {
  res.send("Auth route aktif");
});


module.exports = router;