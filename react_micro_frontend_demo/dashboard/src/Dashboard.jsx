import React from 'react';
import { useEffect } from 'react';
import { GlobalStore } from 'redux-micro-frontend';

import('sharedMFE/commonStyles');

const Dashboard = () => {
  const [users, setUsers] = React.useState([]);

  const globalStore = GlobalStore.Get(false);

  const stateChanged = (userState) => {
    console.log("stateChanged in dashboard", userState.UserApp);
    setUsers(userState.UserApp.users ? userState.UserApp.users : []);
  }

  useEffect(() => {
    // Subscribe to global state changes
    globalStore.SubscribeToGlobalState("UserApp", stateChanged);

    // Get the initial state
    const initialState = globalStore.GetGlobalState();
    if (initialState && initialState.UserApp) {
      setUsers(initialState.UserApp.users);
    }
  }, [globalStore]);

  return (
    <div className='common-container'>
      <span className='common-style'>Dashboard MFE App</span>
      
      <div style={{ display: 'flex', flexDirection: 'column', rowGap: '10px', padding: '20px', minHeight: '180px', backgroundColor: 'white', marginTop: '2px' }}>
        <span>Add Users in the User Management MFE Application Component and you will see the users listed here</span>
        <table style={{ width: '100%', borderCollapse: 'collapse'}} border={1}>
          <thead style={{ backgroundColor: 'darkgrey' }}>
            <tr>
              <th style={{ border: '1px solid black', padding: '8px' }}>Name</th>
              <th style={{ border: '1px solid black', padding: '8px' }}>Email</th>
            </tr>
          </thead>
          <tbody>
            {users.map((user) => (
              <tr key={user.id}>
                <td style={{ border: '1px solid black', padding: '8px' }}>{user.name}</td>
                <td style={{ border: '1px solid black', padding: '8px' }}>{user.email}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default Dashboard;