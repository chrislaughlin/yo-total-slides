import R from 'r-script';
import test from './test.R'

// example.js
const runRScript = () => {
  const out = R(test)
  .data("hello world", 20)
  .callSync();
  
console.log(out);

}

export default runRScript;
