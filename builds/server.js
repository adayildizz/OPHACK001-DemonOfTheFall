const express = require("express");
const path = require("path");

const app = express();
const port = 3000;

// Set the headers
app.use((req, res, next) => {
  res.setHeader("Cross-Origin-Opener-Policy", "same-origin");
  res.setHeader("Cross-Origin-Embedder-Policy", "require-corp");
  next();
});

// Serve the exported Godot files (from the same directory where server.js is located)
app.use(express.static(__dirname));

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
