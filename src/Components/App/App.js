import React, { Component } from 'react';
import Home from '../../pages/Home/Home.js';
import Plotly from '../Plotly/Plotly.js';
import axios from 'axios';

class App extends Component {

  constructor(props){
    super(props);
    this.state = {
      rlangApi: []
    }
  }

  componentDidMount () {

    const delta = (response) => (
      this.setState({rlangApi: response.data.output})
    )

    axios.get(`http://127.0.0.1:8888/demo`)
    .then(function(response) {
      response && delta(response)
    })
    .catch((e) =>
    {
      console.error(e);
    })
  }

  render() {
    
    return (
      <div className="App">
        <Home />
        {this.state.rlangApi}
        <Plotly />
      </div>
    );
  }
}

export default App;
