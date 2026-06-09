const express = require("express");

const router = express.Router();

const {
  getEvents,
  getEventById,
  createEvent,
  updateEvent,
  deleteEvent,
  uploadEventImage,
} = require("../controllers/eventController");

const { protect, authorize } = require("../middleware/authMiddleware");

const upload = require("../middleware/upload");

// GET ALL EVENTS
router.get("/", getEvents);

// GET SINGLE EVENT
router.get("/:id", getEventById);

// CREATE EVENT
router.post("/", protect, authorize(1), createEvent);

// UPDATE EVENT
router.put("/:id", protect, authorize(1), updateEvent);

// UPLOAD GAMBAR EVENT
router.post(
  "/:id/image",
  protect,
  authorize(1),
  upload.single("image"),
  uploadEventImage,
);

// DELETE EVENT
router.delete("/:id", protect, authorize(1), deleteEvent);

module.exports = router;
