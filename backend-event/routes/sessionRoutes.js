const express = require("express");

const router = express.Router();

const {
  getSessionsByEvent,
  createSession,
  updateSession,
  deleteSession,
} = require("../controllers/sessionController");

const { protect, authorize } = require("../middleware/authMiddleware");

// GET SESSION BY EVENT (publik, tidak perlu login)
router.get("/event/:eventId", getSessionsByEvent);

// CREATE SESSION
router.post("/", protect, authorize(1), createSession);

// UPDATE SESSION
router.put("/:id", protect, authorize(1), updateSession);

// DELETE SESSION
router.delete("/:id", protect, authorize(1), deleteSession);

module.exports = router;
