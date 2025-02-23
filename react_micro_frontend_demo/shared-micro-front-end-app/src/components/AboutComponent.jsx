import React from 'react';
import './AboutComponent.css';
import '../styles/commonStyles.css';

const AboutComponent = () => {
  console.log("url for me ", process.env.SHARED_MFE_URL);
  const baseURL = process.env.SHARED_MFE_URL || 'http://localhost:8083';


  return (
    <div className="common-container">
      <div className='common-style'>Shared MFE's Application (Partial Load with About Component)</div>
      <div className="image-component" style={{ margin: '10px'}}>
        <div className='common-style' style={{ width: 'fit-content', backgroundColor: 'blue', color: 'white', marginBottom: '20px' }}>Shared MFE's About Component</div>
        <h2>ABOUT Micro Frontends</h2>
        <p>
          The term "micro frontend" was first introduced by ThoughtWorks on their Technology Radar in late 2016, essentially applying the concept of microservices to the frontend development space; making them the credited originators of the concept.
        </p>
        <h3>
          Key points about micro frontends:
        </h3>
        <ul>
          <li>Origin: ThoughtWorks Technology Radar</li>
          <li>Year introduced: 2016</li>
          <li>Concept: Breaking down a large frontend application into smaller, independent, and independently deployable units, similar to how microservices work on the backend.</li>
        </ul>
        <h3>Micro Frontend Architecture</h3>``
        <img
          src={`${baseURL}/assets/images/image.png`}
          alt="Shared Micro Frontend"
        />
      </div>
    </div>
  );
};

export default AboutComponent;