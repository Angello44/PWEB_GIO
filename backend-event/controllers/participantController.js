const db = require("../config/db");
const crypto = require("crypto");

// ====================================
// REGISTER PESERTA
// ====================================
exports.registerParticipant = (req, res) => {
  const { event_id } = req.body;
  const user_id = req.user.id;

  if (!event_id) {
    return res.status(400).json({ message: "event_id wajib diisi" });
  }

  // 1. Cek event ada
  db.query("SELECT id FROM events WHERE id = ?", [event_id], (err, events) => {
    if (err)
      return res
        .status(500)
        .json({ message: "Server error", error: err.message });
    if (!events.length)
      return res.status(404).json({ message: "Event tidak ditemukan" });

    // 2. Cek sudah terdaftar
    db.query(
      "SELECT id FROM participants WHERE user_id = ? AND event_id = ?",
      [user_id, event_id],
      (err, existing) => {
        if (err)
          return res
            .status(500)
            .json({ message: "Server error", error: err.message });
        if (existing.length > 0) {
          return res
            .status(400)
            .json({ message: "Kamu sudah terdaftar di event ini" });
        }

        // 3. Generate booking code & insert
        const booking_code =
          "BK-" + crypto.randomBytes(4).toString("hex").toUpperCase();

        db.query(
          "INSERT INTO participants (user_id, event_id, status, booking_code) VALUES (?, ?, 'registered', ?)",
          [user_id, event_id, booking_code],
          (err, result) => {
            if (err)
              return res
                .status(500)
                .json({ message: "Server error", error: err.message });

            res.status(201).json({
              message: "Pendaftaran berhasil",
              participant_id: result.insertId,
              booking_code,
              event_id,
              user_id,
            });
          },
        );
      },
    );
  });
};

// ====================================
// CEK STATUS PENDAFTARAN USER
// ====================================
exports.checkRegistration = (req, res) => {
  const user_id = req.user.id;
  const { event_id } = req.params;

  db.query(
    `SELECT p.id, p.status, p.booking_code, p.registered_at,
            e.title AS event_name, e.date, e.location
     FROM participants p
     JOIN events e ON p.event_id = e.id
     WHERE p.user_id = ? AND p.event_id = ?`,
    [user_id, event_id],
    (err, rows) => {
      if (err) return res.status(500).json({ message: "Server error" });
      if (!rows.length) return res.json({ registered: false });
      res.json({ registered: true, data: rows[0] });
    },
  );
};

// ====================================
// GET SEMUA TIKET MILIK USER
// ====================================
exports.getMyTickets = (req, res) => {
  const user_id = req.user.id;

  db.query(
    `SELECT p.id, p.status, p.booking_code, p.registered_at,
            e.id AS event_id, e.title AS event_name,
            e.date, e.location, e.category, e.price
     FROM participants p
     JOIN events e ON p.event_id = e.id
     WHERE p.user_id = ?
     ORDER BY p.registered_at DESC`,
    [user_id],
    (err, rows) => {
      if (err) return res.status(500).json({ message: "Server error" });
      res.json(rows);
    },
  );
};

// ====================================
// GET PESERTA (admin)
// ====================================
exports.getParticipants = (req, res) => {
  db.query(
    `SELECT p.id, p.status, p.booking_code, p.registered_at,
            u.name, u.email, u.phone,
            e.id AS event_id, e.title AS event_name
     FROM participants p
     JOIN users u ON p.user_id = u.id
     JOIN events e ON p.event_id = e.id
     ORDER BY p.registered_at DESC`,
    (err, rows) => {
      if (err) return res.status(500).json({ message: "Server error" });
      res.json(rows);
    },
  );
};

// ====================================
// DELETE PESERTA (admin)
// ====================================
exports.deleteParticipant = (req, res) => {
  const { id } = req.params;

  db.query("DELETE FROM participants WHERE id = ?", [id], (err, result) => {
    if (err)
      return res
        .status(500)
        .json({ message: "Server error", error: err.message });
    if (result.affectedRows === 0)
      return res.status(404).json({ message: "Peserta tidak ditemukan" });
    res.json({ message: "Peserta berhasil dihapus" });
  });
};

// ====================================
// UPDATE STATUS KEHADIRAN (admin)
// ====================================
exports.updateStatus = (req, res) => {
  const { id } = req.params;
  const { status } = req.body;

  const allowed = ["registered", "attended", "cancelled"];
  if (!allowed.includes(status)) {
    return res.status(400).json({ message: "Status tidak valid" });
  }

  db.query(
    "UPDATE participants SET status = ? WHERE id = ?",
    [status, id],
    (err, result) => {
      if (err)
        return res
          .status(500)
          .json({ message: "Server error", error: err.message });
      if (result.affectedRows === 0)
        return res.status(404).json({ message: "Peserta tidak ditemukan" });
      res.json({ message: "Status berhasil diupdate", status });
    },
  );
};
