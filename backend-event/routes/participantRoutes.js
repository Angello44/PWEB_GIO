const express = require("express");
const router = express.Router();

const {
  registerParticipant,
  checkRegistration,
  getMyTickets,
  getParticipants,
  deleteParticipant,
  updateStatus,
} = require("../controllers/participantController");

const { protect, authorize } = require("../middleware/authMiddleware");

// Daftar event (butuh login)
router.post("/register", protect, registerParticipant);

// Cek status pendaftaran untuk 1 event (butuh login)
router.get("/check/:event_id", protect, checkRegistration);

// Lihat semua tiket milik user yang login
router.get("/my-tickets", protect, getMyTickets);

// Admin: lihat semua peserta
router.get("/", protect, authorize(1), getParticipants);

// Admin: update status kehadiran
router.patch("/:id/status", protect, authorize(1), updateStatus);

// Admin: hapus peserta
router.delete("/:id", protect, authorize(1), deleteParticipant);

module.exports = router;
