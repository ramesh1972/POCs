import React from 'react';
import { Suspense } from 'react';
import { BrowserRouter as Router, Route, Routes, Link, NavLink } from 'react-router-dom';

import './App.css';

import UserTile from './components/UserTile';
import Migrate from './components/Migrate';
import DemoNotes from './components/DemoNotes';
import Footer from "./components/Footer";

const AboutComponent = React.lazy(() => import('sharedMFE/AboutComponent'));
const Dashboard = React.lazy(() => import('dashboard/Dashboard'));
const UserManagement = React.lazy(() => import('userManagement/UserManagement'));
const Header = React.lazy(() => import('header/Header'));

import('sharedMFE/commonStyles');

const App = () => (
  <div className='common-container' style={{ backgroundColor: 'aqua' }}>
    <div className='common-style'>Host MFE App</div>
    <Suspense fallback={<div>Loading Header...</div>} >
      <div>
        <Header />
      </div>
    </Suspense>
    <div className="container"> 
      <Router>
        <Suspense fallback={<div>Loading...</div>}>
          <nav>
            <ul className="nav">
              <li>
                <NavLink to="/" end className={({ isActive }) => (isActive ? 'active' : 'inactive')}>
                  Home
                </NavLink>
              </li>
              <li>
                <NavLink to="/dash" end className={({ isActive }) => (isActive ? 'active' : 'inactive')}>
                  Dashboard
                </NavLink>
              </li>
              <li>
                <NavLink to="/demo" className={({ isActive }) => (isActive ? 'active' : 'inactive')}>
                  Demo Notes
                </NavLink>
              </li>

              <li>
                <NavLink to="/migrate" className={({ isActive }) => (isActive ? 'active' : 'inactive')}>
                  Migrating to MFE Arch
                </NavLink>
              </li>
              <li>
                <NavLink to="/about" className={({ isActive }) => (isActive ? 'active' : 'inactive')}>
                  About MFE Arch
                </NavLink>
              </li>

            </ul>
          </nav>
          <Routes>
            <Route
              exact
              path="/"
              element={
                <div style={{ display: 'flex', flexDirection: 'column', padding: '2px', gap: '20px' }}>
                  <UserTile />
                  <div style={{ display: 'flex', flexDirection: 'row', columnGap: '20px', justifyContent: 'space-around' }}>
                    <div style={{ width: '50%' }}>
                      <Dashboard />
                    </div>
                    <div style={{ width: '50%' }}>
                      <UserManagement />
                    </div>
                  </div>
                </div>
              }
            />
            <Route
              path="/dash"
              element={<Dashboard />}
            />
            
            <Route
              path="/demo"
              element={<DemoNotes />}
            />
            <Route
              path="/about"
              element={<AboutComponent />}
            />
            <Route
              path="/migrate"
              element={<Migrate />}
            />
          </Routes>

        </Suspense>
      </Router>
    </div>
    <div style={{ marginTop: '10px' }}>
      <Footer />
    </div>
  </div>
);

export default App;