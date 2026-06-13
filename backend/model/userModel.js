const db = require('../db');
const UserModel = {
  findByEmail: (email, callback) => {
    db.query('SELECT * FROM users WHERE email = ?', [email], callback);
  },
  create: (data, callback) => {
    const { name, email, password } = data;
    db.query('INSERT INTO users (name, email, password) VALUES (?, ?, ?)', [name, email, password], callback);
  },
  getAll: (callback) => {
    db.query('SELECT id, name, email, created_at FROM users', callback);
  },
  getById: (id, callback) => {
    db.query('SELECT id, name, email, created_at FROM users WHERE id = ?', [id], callback);
  },
  update: (id, data, callback) => {
    const { name, email } = data;
    db.query('UPDATE users SET name=?, email=? WHERE id=?', [name, email, id], callback);
  },
  delete: (id, callback) => {
    db.query('DELETE FROM users WHERE id = ?', [id], callback);
  },
};
module.exports = UserModel;
