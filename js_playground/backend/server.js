import { exec } from 'child_process';
import express from 'express';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import axios from 'axios';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();
const PORT = 3000;

const GITHUB_REPO = 'ramesh1972/POCs';
const GITHUB_PATH = 'ai-ml-genai-pocs/sample-prompts-js';
const GITHUB_API = `https://api.github.com/repos/${GITHUB_REPO}/contents/${GITHUB_PATH}`;
const LOCAL_DIR = "D:\\src\\github-ramesh\\POCs"
const PROJECT_DIR = path.join(LOCAL_DIR, GITHUB_PATH);

// Enable CORS
app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
  next();
});

// 📝 **1️⃣ Endpoint: List All Projects**
app.get('/projects', async (req, res) => {
  try {
    const response = await axios.get(GITHUB_API);
    const projects = response.data
      .filter(file => file.type === 'dir') // Only list directories (each project)
      .map(file => file.name);

    res.json(projects);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch project list from GitHub' });
  }
});

// 📥 **2️⃣ Download the GitHub Repo**
function downloadRepo(callback) {
  if (fs.existsSync(LOCAL_DIR)) {
    console.log('Repository exists. Pulling latest changes...');
    exec(`cd ${LOCAL_DIR} && git pull`, callback);
  } else {
    console.log(`Cloning repository... git clone https://github.com/${GITHUB_REPO}.git ${LOCAL_DIR}`);
    exec(`git clone https://github.com/${GITHUB_REPO}.git ${LOCAL_DIR}`, callback);
  }
}

// 🚀 **3️⃣ Run Selected Project**
app.get('/execute/', (req, res) => {
  const projectName = req.params.project;
  const filePath = req.query.file;
  const projectPath = path.join(LOCAL_DIR, GITHUB_PATH, filePath);

  console.log(`Executing project in folder: ${PROJECT_DIR}`);
  console.log(`Executing project: ${filePath}`);

  if (!fs.existsSync(projectPath)) {
    return res.status(404).json({ error: 'Project not found' });
  }

  // Install, build, and execute
  const command = `cd ${PROJECT_DIR} && npm install && node ${filePath}`;

  exec(command, (error, stdout, stderr) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: stderr });
    }
  });

  // exce the file
  const execCmd = `cd ${PROJECT_DIR} && node ${filePath}`;
  console.log(`Executing command: ${execCmd}`);

  exec(execCmd, (error, stdout, stderr) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: stderr });
    } else {
      console.log("output", stdout);
      res.send({ output: stdout });
    }
  });
});

downloadRepo(() => {
  console.log('Server started');
});

// Start Server
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});