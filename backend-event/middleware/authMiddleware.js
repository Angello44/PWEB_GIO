const jwt = require("jsonwebtoken");

exports.protect = (req, res, next) => {
  let token;

  // 🔥 DEBUG
  console.log("HEADER:", req.headers.authorization);

  if (
    req.headers.authorization &&
    req.headers.authorization.startsWith("Bearer")
  ) {
    token = req.headers.authorization.split(" ")[1];

    try {
      const decoded = jwt.verify(token, "secretkey"); // ⚠️ HARUS SAMA

      console.log("DECODED:", decoded);

      req.user = decoded;

      next();
    } catch (err) {
      console.log("JWT ERROR:", err);
      return res.status(401).json({
        message: "Token tidak valid",
      });
    }
  } else {
    return res.status(401).json({
      message: "Tidak ada token",
    });
  }
};

// ======================
// AUTHORIZE ROLE
// ======================
exports.authorize = (...roles) => {

  return (req, res, next) => {

    if (!roles.includes(req.user.role_id)) {

      return res.status(403).json({
        message: "Forbidden"
      });

    }

    next();

  };

};