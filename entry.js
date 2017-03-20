const ripple  = require('./lib/js/src/main');

const store = ripple.store;
const dispatch  = ripple.dispatch;
const jsonify = ripple.jsonify;

const store2 = dispatch(store, ripple.inc)

console.log(jsonify(store2));
