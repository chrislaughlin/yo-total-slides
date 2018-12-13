import React from 'react';
import logo from '../../assets/zac__shoulders.jpg';
import './Home.css';

const Home = () => (
  <div>
    <header className="App-header">
      <img src={logo} className="App-logo" alt="logo" />
      <h1 className="App-title">Saved by the Bell Curve</h1>
    </header>
    <p className="App-intro">
      Screech is awesome
    </p>
  </div>
)

export default Home;
