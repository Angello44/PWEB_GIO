const db = require("../config/db");

// ====================================
// SUBMIT RATING (user yang sudah terdaftar & hadir)
// ====================================
exports.submitFeedback = (req, res) => {
  const user_id = req.user.id;
  const { event_id, rating, comment } = req.body;

  if (!event_id || !rating) {
    return res.status(400).json({ message: "event_id dan rating wajib diisi" });
  }
  if (rating < 1 || rating > 5) {
    return res.status(400).json({ message: "Rating harus antara 1-5" });
  }

  // Cek user sudah terdaftar di event ini
  db.query(
    "SELECT id, status FROM participants WHERE user_id = ? AND event_id = ?",
    [user_id, event_id],
    (err, parts) => {
      if (err) return res.status(500).json({ message: "Server error" });
      if (!parts.length) {
        return res
          .status(403)
          .json({ message: "Kamu belum terdaftar di event ini" });
      }

      const participant_id = parts[0].id;

      // Cek sudah pernah beri rating
      db.query(
        "SELECT id FROM feedback WHERE participant_id = ? AND event_id = ?",
        [participant_id, event_id],
        (err, existing) => {
          if (err) return res.status(500).json({ message: "Server error" });
          if (existing.length > 0) {
            return res
              .status(400)
              .json({
                message: "Kamu sudah memberikan penilaian untuk event ini",
              });
          }

          db.query(
            "INSERT INTO feedback (participant_id, event_id, rating, comment) VALUES (?, ?, ?, ?)",
            [participant_id, event_id, rating, comment || null],
            (err, result) => {
              if (err)
                return res
                  .status(500)
                  .json({ message: "Server error", error: err.message });
              res.status(201).json({
                message: "Penilaian berhasil dikirim",
                feedback_id: result.insertId,
              });
            },
          );
        },
      );
    },
  );
};

// ====================================
// GET SEMUA FEEDBACK (admin)
// ====================================
exports.getAllFeedback = (req, res) => {
  const { event_id } = req.query;

  let sql = `
    SELECT f.id, f.rating, f.comment, f.created_at,
           u.name AS user_name, u.email,
           e.id AS event_id, e.title AS event_name
    FROM feedback f
    JOIN participants p ON f.participant_id = p.id
    JOIN users u ON p.user_id = u.id
    JOIN events e ON f.event_id = e.id
  `;
  const params = [];

  if (event_id) {
    sql += " WHERE f.event_id = ?";
    params.push(event_id);
  }

  sql += " ORDER BY f.created_at DESC";

  db.query(sql, params, (err, rows) => {
    if (err) return res.status(500).json({ message: "Server error" });
    res.json(rows);
  });
};

// ====================================
// GET FEEDBACK SUMMARY PER EVENT (publik)
// ====================================
exports.getFeedbackSummary = (req, res) => {
  db.query(
    `SELECT f.event_id, e.title AS event_name,
            COUNT(f.id) AS total_reviews,
            ROUND(AVG(f.rating), 1) AS avg_rating
     FROM feedback f
     JOIN events e ON f.event_id = e.id
     GROUP BY f.event_id, e.title
     ORDER BY avg_rating DESC`,
    (err, rows) => {
      if (err) return res.status(500).json({ message: "Server error" });
      res.json(rows);
    },
  );
};

// ====================================
// GET FEEDBACK BY EVENT (publik)
// ====================================
exports.getFeedbackByEvent = (req, res) => {
  const { event_id } = req.params;

  db.query(
    `SELECT f.id, f.rating, f.comment, f.created_at,
            u.name AS user_name
     FROM feedback f
     JOIN participants p ON f.participant_id = p.id
     JOIN users u ON p.user_id = u.id
     WHERE f.event_id = ?
     ORDER BY f.created_at DESC`,
    [event_id],
    (err, rows) => {
      if (err) return res.status(500).json({ message: "Server error" });
      res.json(rows);
    },
  );
};
