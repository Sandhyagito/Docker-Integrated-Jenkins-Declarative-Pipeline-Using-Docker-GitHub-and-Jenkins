const express = require('express');
const app = express();
const port = 3000;

// Basic route
app.get('/', (req, res) => {
  res.send('Hello, Jenkins and Docker!');
});

// Start the server
app.listen(port, () => {
  console.log(`App running on http://localhost:${port}`);
});

