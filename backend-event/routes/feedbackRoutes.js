const express = require("express");
const router = express.Router();

const {
  submitFeedback,
  getAllFeedback,
  getFeedbackSummary,
  getFeedbackByEvent,
} = require("../controllers/feedbackController");

const { protect, authorize } = require("../middleware/authMiddleware");

// User: submit rating (harus login & terdaftar di event)
router.post("/", protect, submitFeedback);

// Publik: summary semua event
router.get("/summary", getFeedbackSummary);

// Publik: semua feedback per event
router.get("/event/:event_id", getFeedbackByEvent);

// Admin: semua feedback (bisa filter by event_id query param)
router.get("/", protect, authorize(1), getAllFeedback);

module.exports = router;
