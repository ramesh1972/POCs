import React, { useState, useEffect } from 'react';
import { UserReducer } from './store/users.reducers';
import { AddUser } from './store/user.actions';
import { GlobalStore } from 'redux-micro-frontend';

import('sharedMFE/commonStyles');

const styles = {
  inputStyle: {
    padding: '5px',
    marginRight: '10px',
    borderRadius: '5px',
    border: '1px solid #ccc',
    height: '30px',
  },
  buttonStyle: {
    padding: '10px',
    borderRadius: '5px',
    border: '1px solid #ccc',
    backgroundColor: 'lightaquamarine',
    height: '40px',
  },
  labelStyle: {
    fontSize: '20px',
    fontStyle: 'italic',
  },
  userStyle: {
    border: '1px solid #ccc',
    fontSize: '16px',
    padding: '2px',
    fontWeight: 'bold',
    backgroundColor: 'lightblue',
  },
  listStyle: {
    display: 'inline',
    padding: '0px',
    marginLeft: '20px',
    paddingBottom: '20px',
    listStyleType: 'square',
    lineHeight: '1.8'
  }
};

const UserManagement = () => {
  const [users, setUsers] = useState([]);
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');

  // initialize the store
  const globalStore = GlobalStore.Get();
  const store = globalStore.CreateStore("UserApp", UserReducer, []);

  console.log("Global store registered successfully");

  const stateChanged = (userState) => {
    console.log("stateChanged in user management", userState);
    setUsers(userState.users);
  }

  useEffect(() => {
    // Subscribe to global state changes
    globalStore.Subscribe("UserApp", stateChanged);

    // Get the initial state
    const initialState = globalStore.GetGlobalState();
    if (initialState && initialState.UserApp) {
      setUsers(initialState.UserApp.users);
    }
  }, [globalStore]);

  const handleAddUser = () => {
    const newUser = { id: users.length + 1, name, email };
    console.log("newUser ", newUser);

    globalStore.DispatchAction("UserApp", AddUser(name, email));

    setName('');
    setEmail('');
  };

  return (
    <div className='common-container'>
      <span className='common-style'>User Management MFE App</span>

      <div style={{ display: 'flex', flexDirection: 'column', rowGap: '10px', padding: '20px', minHeight: '180px' }}>
        <span style={styles.labelStyle}>Add Users</span>
        <div>
          <input style={styles.inputStyle}
            type="text"
            placeholder="Name"
            value={name}
            onChange={(e) => setName(e.target.value)}
          />
          <input style={styles.inputStyle}
            type="email"
            placeholder="Email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
          />
          <button onClick={handleAddUser} style={styles.buttonStyle}>Add User</button>
        </div>
        <ul style={styles.listStyle}>
          {users.map((user) => (
            <li key={user.id}><span style={styles.userStyle}>{user.name}</span> with email address <span style={styles.userStyle}>{user.email}</span> added</li>
          ))}
        </ul>
      </div>
    </div>
      );
};

      export default UserManagement;