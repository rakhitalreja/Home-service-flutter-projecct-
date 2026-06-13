const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const UserModel = require('../model/userModel');
const { SECRET_KEY } = require('../middleware/auth');
const AuthController = {
  register: (req, res) => {
    const { name, email, password } = req.body;
    UserModel.findByEmail(email, (err, results) => {
      if (err) return res.status(500).json({ error: err.message });
      if (results.length > 0) return res.status(400).json({ message: 'Email already exists!' });
      const hashedPassword = bcrypt.hashSync(password, 8);
      UserModel.create({ name, email, password: hashedPassword }, (err, result) => {
        if (err) return res.status(500).json({ error: err.message });
        const token = jwt.sign({ id: result.insertId }, SECRET_KEY, { expiresIn: '24h' });
        res.json({ message: 'User registered successfully!', token: token, user: { id: result.insertId, name, email } });
      });
    });
  },
  login: (req, res) => {
    const { email, password } = req.body;
    UserModel.findByEmail(email, (err, results) => {
      if (err) return res.status(500).json({ error: err.message });
      if (results.length === 0) return res.status(404).json({ message: 'User not found!' });
      const user = results[0];
      const passwordValid = bcrypt.compareSync(password, user.password);
      if (!passwordValid) return res.status(401).json({ message: 'Invalid password!' });
      const token = jwt.sign({ id: user.id }, SECRET_KEY, { expiresIn: '24h' });
      res.json({ message: 'Login successful!', token: token, user: { id: user.id, name: user.name, email: user.email } });
    });
  },
  getProfile: (req, res) => {
    UserModel.getById(req.userId, (err, results) => {
      if (err) return res.status(500).json({ error: err.message });
      res.json(results[0]);
    });
  },
  getAllUsers: (req, res) => {
    UserModel.getAll((err, results) => {
      if (err) return res.status(500).json({ error: err.message });
      res.json(results);
    });
  },
  updateUser: (req, res) => {
    UserModel.update(req.params.id, req.body, (err) => {
      if (err) return res.status(500).json({ error: err.message });
      res.json({ message: 'User updated!' });
    });
  },
  deleteUser: (req, res) => {
    UserModel.delete(req.params.id, (err) => {
      if (err) return res.status(500).json({ error: err.message });
      res.json({ message: 'User deleted!' });
    });
  },
};
module.exports = AuthController;
