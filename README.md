Module for using the BLE qmote buttons from Qblinks

```js
var Qmote = require('qmote');

Qmote.setName('Qmote 5C2D');

Qmote.discover(function(qmote) {
  console.log('Discovered!');
  qmote.connectAndSetup(function(error) {
    console.log('Connected!');
    qmote.notifyButton(function(data) {
      console.log(qmote.parseCode(data));
    });
  });
});
```
