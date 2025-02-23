let selectedScript = "";

function loadScripts() {
  fetch('http://localhost:3000/projects')
    .then(response => response.json())
    .then(scripts => {
      const scriptList = document.getElementById('script-list');
      scriptList.innerHTML = "";
      scripts.forEach(script => {
        const li = document.createElement('li');
        li.textContent = script;
        li.onclick = () => selectScript(script);
        scriptList.appendChild(li);
      });
    })
    .catch(error => console.error('Error loading scripts:', error));
}

function selectScript(script) {
  selectedScript = script;
  document.getElementById('run-btn').style.display = 'block';
}

function executeScript() {
  if (!selectedScript) return;

  document.getElementById('output').textContent = "Executing...";
  fetch(`http://localhost:3000/execute/${selectedScript}`)
    .then(response => response.json())
    .then(data => {
      document.getElementById('output').textContent = data.output || data.error;
    })
    .catch(error => console.error('Error executing script:', error));
}
