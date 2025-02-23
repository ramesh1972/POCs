document.addEventListener('DOMContentLoaded', () => {
  const projects = ['project1', 'project2']; // List of project files
  const projectList = document.getElementById('project-list');
  const output = document.getElementById('output');

  projects.forEach((project) => {
    const button = document.createElement('button');
    button.textContent = project;
    button.addEventListener('click', () => {
      fetch(`/execute/${project}`)
        .then((response) => response.text())
        .then((data) => {
          output.textContent = data;
        })
        .catch((error) => {
          output.textContent = `Error: ${error}`;
        });
    });
    projectList.appendChild(button);
  });
});
