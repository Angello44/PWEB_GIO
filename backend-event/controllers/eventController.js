const db = require("../config/db");

// ======================
// GET ALL EVENTS
// ======================
const getEvents = (req, res) => {
  db.query("SELECT * FROM events ORDER BY id DESC", (err, results) => {
    if (err) {
      return res.status(500).json(err);
    }

    res.json(results);
  });
};

// ======================
// GET EVENT BY ID
// ======================
const getEventById = (req, res) => {
  const id = req.params.id;

  db.query("SELECT * FROM events WHERE id = ?", [id], (err, results) => {
    if (err) {
      return res.status(500).json(err);
    }

    res.json(results[0]);
  });
};

// ======================
// CREATE EVENT
// ======================
const createEvent = (req, res) => {
  const {
    title,
    description,
    date,
    end_date,
    start_time,
    end_time,
    location,
    category,
    price,
  } = req.body;

  db.query(
    `INSERT INTO events
    (
      title,
      description,
      date,
      end_date,
      start_time,
      end_time,
      location,
      category,
      price,
      created_by
    )
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
    [
      title,
      description,
      date,
      end_date,
      start_time,
      end_time,
      location,
      category,
      price,
      req.user.id,
    ],
    (err, result) => {
      if (err) {
        console.log(err);

        return res.status(500).json({
          message: "Server error",
          error: err,
        });
      }

      res.json({
        message: "Event berhasil dibuat",
        event_id: result.insertId,
      });
    },
  );
};

// ======================
// UPDATE EVENT
// ======================
const updateEvent = (req, res) => {
  const id = req.params.id;

  const { title, description, date, location } = req.body;

  db.query(
    `UPDATE events
    SET title=?, description=?, date=?, location=?
    WHERE id=?`,
    [title, description, date, location, id],
    (err) => {
      if (err) {
        return res.status(500).json(err);
      }

      res.json({
        message: "Event berhasil diupdate",
      });
    },
  );
};

// ======================
// DELETE EVENT
// ======================
const deleteEvent = (req, res) => {
  const id = req.params.id;

  db.query("DELETE FROM events WHERE id=?", [id], (err) => {
    if (err) {
      return res.status(500).json(err);
    }

    res.json({
      message: "Event berhasil dihapus",
    });
  });
};

// ====================================
// UPLOAD GAMBAR EVENT
// ====================================
const uploadEventImage = (req, res) => {
  const id = req.params.id;
  if (!req.file)
    return res.status(400).json({ message: "File gambar wajib diupload" });

  const imgUrl = "/uploads/events/" + req.file.filename;

  db.query(
    "UPDATE events SET img_source = ? WHERE id = ?",
    [imgUrl, id],
    (err) => {
      if (err)
        return res
          .status(500)
          .json({ message: "Server error", error: err.message });
      res.json({ message: "Gambar berhasil diupload", img_url: imgUrl });
    },
  );
};

module.exports = {
  getEvents,
  getEventById,
  createEvent,
  updateEvent,
  deleteEvent,
  uploadEventImage,
};
