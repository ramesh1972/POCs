import React from 'react';
import './DemoNotes.css';

const DemoNotes = () => {
  console.log("Shared MFE URL:", process.env.SHARED_MFE_URL);
  const baseURL = process.env.SHARED_MFE_URL || 'http://localhost:8083';

  return (
    <div className="common-container" style={{border: '3px dashed blue'}}>
      <div className="common-header">
        Host MFE Application's DemoNotes Component
      </div>
    <div class="section">
      <p class="title">1) Demo of MFE host application & contained MFE applications</p>
      <ul class="list">
        <li>HOST_URL: <a href="http://mfe-poc.rameshv.me:8085/" target="_blank">http://mfe-poc.rameshv.me:8085/</a></li>
        <li>SHARED_MFE_URL: <a href="http://mfe-poc.rameshv.me:8083/" target="_blank">http://mfe-poc.rameshv.me:8083/</a></li>
        <li>DASHBOARD_URL: <a href="http://mfe-poc.rameshv.me:8089/" target="_blank">http://mfe-poc.rameshv.me:8089/</a></li>
        <li>USER_MANAGEMENT_URL: <a href="http://mfe-poc.rameshv.me:8087/" target="_blank">http://mfe-poc.rameshv.me:8087/</a></li>
        <li>FOOTER_URL: <a href="http://mfe-poc.rameshv.me:8081/" target="_blank">http://mfe-poc.rameshv.me:8081/</a></li>
        <li>HEADER_URL: <a href="http://mfe-poc.rameshv.me:8082/" target="_blank">http://mfe-poc.rameshv.me:8082/</a></li>
      </ul>

      <p class="title">2) Demo of a Shared MFE application that contains</p>
      <ul class="list">
        <li>shared components (like <span class="highlight">AboutComponent</span>)</li>
        <li>shared styles (like the <span class="highlight">yellow title headers</span> in each MFE)</li>
        <li>shared assets (like images)</li>
        <li>shared JavaScript functions (like <span class="highlight">dateUtils.js</span>, <span class="highlight">pathUtils.js</span>)</li>
      </ul>

      <p class="title">3) Demo of Loading a Svelte MFE application within the React Host MFE application</p>

      <p class="title">4) Demo of Static & Lazy Loading of MFEs</p>

      <p class="title">5) Demo of Lazy Loading a Specific Component (e.g., <span class="highlight">AboutComponent</span>) from another MFE application (e.g., Shared MFE application)</p>

      <p class="title">6) Demo of a Global store using "<span class="highlight">redux-micro-frontend</span>" npm package from Microsoft. This enables sharing of:</p>
      <ul class="list">
        <li>a global store hosted in Host MFE and shared across all other MFEs</li>
        <li>local store, local to a particular MFE application and accessed as partner stores in other MFE applications</li>
        <li>real-time store state changes. Reactive stores. e.g., when a user is added in <span class="highlight">UserManagement</span> component in <span class="highlight">UserManagement MFE application</span>, the <span class="highlight">DashBoard MFE Component</span> in the host MFE application automatically receives updates to users</li>
        <li>demo of accessing store data on load of a component in SPA scenarios of component mounting/unmounting by listening to the whole store object for changes</li>
      </ul>
      <p class="title">7) Deployment notes</p>
      <ul class="list">
        <li>All the 6 MFE applicaitons are deployed in their own <span class="highlight">docker container</span> created by <a href="http://github.com/ramesh1972/examples/blob/master/micro-front-end/react_micro_frontend_demo/docker-compose.yml">deploy-compose.yml</a> on an ngnix web server hosted within the container itself</li>
        <li><span class="highlight">A single deploy script</span> <a href="http://github.com/ramesh1972/examples/blob/master/micro-front-end/react_micro_frontend_demo/deploy-local.bat">deploy-local.bat</a> to used deploy locally for dev</li>
        <li><span class="highlight">a shell script</span> found in <a href="http://github.com/ramesh1972/examples/blob/master/micro-front-end/react_micro_frontend_demo/deploy">deploy/</a> is used to deploy for production via CI/CD</li>
        <li><span class="highlight">Project GitHub:</span> <a href="http://github.com/ramesh1972/examples/tree/master/micro-front-end/react_micro_frontend_demo">http://github.com/ramesh1972/examples/tree/master/micro-front-end/react_micro_frontend_demo</a></li>
      </ul>
    </div>
    </div>
  );
};

export default DemoNotes;
