const express = require('express');
const router = express.Router();
const db = require('./db');
const { verifyJWT } = require('./auth');

// Get item
router.get('/items', verifyJWT('admin', 'company', 'technician', 'customer'), (req, res) => {
  db.query('SELECT * FROM Item', (err, results) => {
    if (err) return res.json({ success: false });
    res.json({ success: true, data: results });
  });
});

// Add item
router.post('/items', verifyJWT('admin', 'company'), (req, res) => {
  const { item_name, price } = req.body;
  db.query('INSERT INTO Item (item_name, price) VALUES (?, ?)', [item_name, price], (err, results) => {
    if (err) return res.json({ success: false, message: 'Add failed.' });
    res.json({ success: true });
  });
});

// Delete item
router.delete('/items/:id', verifyJWT('admin', 'company'), (req, res) => {
  const itemId = req.params.id;
  // Best effort: remove technician skill references first (safe to delete)
  db.query('DELETE FROM Skill WHERE item_id = ?', [itemId], (skillErr) => {
    // Ignore errors here; proceed to delete item and handle constraints properly
    db.query('DELETE FROM Item WHERE item_id = ?', [itemId], (err, results) => {
      if (err) {
        // MySQL FK constraint error code 1451 / ER_ROW_IS_REFERENCED_2
        if (err.code === 'ER_ROW_IS_REFERENCED_2' || err.errno === 1451) {
          return res.status(409).json({ success: false, message: 'Item is in use (e.g., on bills) and cannot be deleted.' });
        }
        console.error('Delete item error:', err);
        return res.status(500).json({ success: false, message: 'Delete failed.' });
      }
      if (results.affectedRows === 0) {
        return res.status(404).json({ success: false, message: 'Item not found.' });
      }
      return res.json({ success: true });
    });
  });
});

// Edit item
router.put('/items/:id', verifyJWT('admin', 'company'), (req, res) => {
  const { item_name, price } = req.body;
  db.query('UPDATE Item SET item_name=?, price=? WHERE item_id=?', [item_name, price, req.params.id], (err, results) => {
    if (err) return res.json({ success: false, message: 'Update failed.' });
    res.json({ success: true });
  });
});

module.exports = router;