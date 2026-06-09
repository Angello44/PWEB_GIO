const db = require("../config/db");

// ======================
// GET SESSIONS BY EVENT
// ======================
const getSessionsByEvent = (req, res) => {
  const eventId = req.params.eventId;

  db.query(
    "SELECT * FROM sessions WHERE event_id = ? ORDER BY id ASC",
    [eventId],
    (err, results) => {
      if (err) {
        console.log("GET SESSION ERROR:", err);

        return res.status(500).json({
          error: err.sqlMessage || err.message,
        });
      }

      res.json(results);
    },
  );
};

// ======================
// CREATE SESSION
// ======================
const createSession = (req, res) => {
  const { event_id, title, session_date, session_time, speaker, capacity } =
    req.body;

  db.query(
    `INSERT INTO sessions
    (event_id, title, session_date, session_time, speaker, capacity)
    VALUES (?, ?, ?, ?, ?, ?)`,
    [event_id, title, session_date, session_time, speaker, capacity],
    (err, result) => {
      if (err) {
        console.log("CREATE SESSION ERROR:", err);

        return res.status(500).json({
          error: err.sqlMessage || err.message,
        });
      }

      res.json({
        message: "Sesi berhasil dibuat",
        session_id: result.insertId,
      });
    },
  );
};

// ======================
// UPDATE SESSION
// ======================
const updateSession = (req, res) => {
  const id = req.params.id;

  const { title, session_date, session_time, speaker, capacity } = req.body;

  db.query(
    `UPDATE sessions
    SET
      title=?,
      session_date=?,
      session_time=?,
      speaker=?,
      capacity=?
    WHERE id=?`,
    [title, session_date, session_time, speaker, capacity, id],
    (err) => {
      if (err) {
        console.log(err);

        return res.status(500).json(err);
      }

      res.json({
        message: "Sesi berhasil diupdate",
      });
    },
  );
};

// ======================
// DELETE SESSION
// ======================
const deleteSession = (req, res) => {
  const id = req.params.id;

  db.query("DELETE FROM sessions WHERE id=?", [id], (err) => {
    if (err) {
      console.log("DELETE SESSION ERROR:", err);

      return res.status(500).json({
        error: err.sqlMessage || err.message,
      });
    }

    res.json({
      message: "Sesi berhasil dihapus",
    });
  });
};

module.exports = {
  getSessionsByEvent,
  createSession,
  updateSession,
  deleteSession,
};
