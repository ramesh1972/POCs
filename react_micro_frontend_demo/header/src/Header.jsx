import React from 'react';
import { useEffect } from 'react';
import { GlobalStore } from 'redux-micro-frontend';
import('sharedMFE/commonStyles');

const Header = () => {
  return (
    <div className='common-container' style={{ backgroundColor: '#ddd' }}>
      <div className='common-style'>Header MFE App</div>
      <div style={{ fontSize: '16px', fontWeight: 'normal', padding: '8px' }}>
        Welcome to the POC app for showcasing Micro Frontend Architecture. This app is the Header MFE App hosted on its own and is being consumed by the Host MFE App (parent container).
        The demo showcases 1 host mfe, 1 header mfe, 2 sub mfes and 1 shared mfe all in react and 1 footer mfc in svelte framework.
        Use the legend give below to understand the UI elements.
      </div>
      <div style={{ display: 'flex', flexDirection: 'row', columnGap: '20px', padding: '10px', justifyContent: 'center', justifyItems: 'space-between' }}>

        <div style={{ fontSize: '24px', fontWeight: 'bold', fontVariant: 'all-small-caps' }}>
          App Legend
        </div>
      </div>
      <div style={{ display: 'flex', flexDirection: 'row', columnGap: '20px', padding: '10px', justifyContent: 'center', justifyItems: 'space-between' }}>
        <div style={{ display: 'flex', flexDirection: 'row', columnGap: '10px' }}>
          <div className='common-container' style={{ width: '60px', height: '15px', backgroundColor: 'aqua' }}></div>Host MFE Application
        </div>

        <div style={{ display: 'flex', flexDirection: 'row', columnGap: '10px' }}>
          <div className='common-container' style={{ width: '60px', height: '15px' }}></div>MFE Application
        </div>

        <div style={{ display: 'flex', flexDirection: 'row', columnGap: '10px' }}>
          <div className='common-container' style={{ width: '60px', height: '15px', border: '3px dashed blue' }}></div>MFE Application's Component
        </div>
      </div>
      <div style={{ display: 'flex', flexDirection: 'row', columnGap: '20px', padding: '10px', justifyContent: 'center', justifyItems: 'space-between' }}>
        <div className='common-style' style={{ width: '30px', height: '15px', marginTop: '-4px' }}></div>Header Style for MFE App from Shared MFE App
        <div className='common-style' style={{ width: '30px', height: '15px', marginTop: '-4px', backgroundColor: 'blue' }}></div>Header Style for MFE App Component from local or remote MFE
      </div>
    </div>
  );
};

export default Header;