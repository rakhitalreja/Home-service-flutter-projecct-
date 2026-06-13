const jwt = require('jsonwebtoken');
const SECRET_KEY = 'homeserve_secret_key_2024';
const verifyToken = (req, res, next) => {
  const token = req.headers['authorization'];
  if (!token) return res.status(403).json({ message: 'No token provided!' });
  try {
    const decoded = jwt.verify(token, SECRET_KEY);
    req.userId = decoded.id;
    next();
  } catch (err) {
    return res.status(401).json({ message: 'Invalid token!' });
  }
};
module.exports = { verifyToken, SECRET_KEY };
