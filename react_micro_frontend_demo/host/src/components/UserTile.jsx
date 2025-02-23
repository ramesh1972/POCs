import React from 'react';
import { GlobalStore } from 'redux-micro-frontend';

import './UserTile.css';

const UserTile = () => {

  const [userCount, setUserCount] = React.useState(0);

  const globalStore = GlobalStore.Get(false);
  const stateChanged = (userState) => {
    console.log("users in host", userState.UserApp);
    setUserCount(userState.UserApp.users ? userState.UserApp.users.length : 0);
  }
  
  globalStore.SubscribeToGlobalState("UserApp", stateChanged);

  return (
    <div className="user-tile-container">
      <div className='common-style' style={{ width: 'fit-content', backgroundColor: 'blue', color: 'white', marginBottom: '20px' }}>Host MFE Application's User Count Component</div>
      <span>Add Users in the User Management MFE Application Component and you will see the user count below increase</span>
      <h2>User Count: {userCount}</h2>
    </div>
  );
};

export default UserTile;
