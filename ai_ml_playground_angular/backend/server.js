const express = require('express');
const { exec } = require('child_process');
const path = require('path');
const app = express();
const PORT = 3000;

// Serve frontend files
app.use(express.static(path.join(__dirname, '../frontend')));

// API endpoint to execute a project script
app.get('/execute/:project', (req, res) => {
  const project = req.params.project;
  const projectPath = path.join(__dirname, 'projects', `${project}.js`);

  exec(`node ${projectPath}`, (error, stdout, stderr) => {
    if (error) {
      res.status(500).send(`Error: ${stderr}`);
    } else {
      res.send(stdout);
    }
  });
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
