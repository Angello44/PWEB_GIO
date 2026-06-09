const db = require("../config/db");

exports.getDashboard = (req, res) => {
  const query = `
    SELECT 
      events.title AS event_name,
      COUNT(sessions.id) AS total_sessions
    FROM events
    LEFT JOIN sessions ON events.id = sessions.event_id
    GROUP BY events.id
  `;

  db.query(query, (err, result) => {
    if (err) {
      console.log("DB ERROR:", err);
      return res.status(500).json(err);
    }

    res.json(result);
  });
};