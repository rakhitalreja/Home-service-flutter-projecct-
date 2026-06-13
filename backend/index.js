const express = require('express');
const app = express();

app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
  res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization');
  if (req.method === 'OPTIONS') {
    return res.sendStatus(200);
  }
  next();
});

app.use(express.json());

const servicesRouter = require('./routes/services');
const bookingsRouter = require('./routes/bookings');
const authRouter = require('./routes/auth');

app.use('/api/services', servicesRouter);
app.use('/api/bookings', bookingsRouter);
app.use('/api/auth', authRouter);

const PORT = 3000;
app.listen(PORT, () => {
  console.log('Server running on port ' + PORT);
});
