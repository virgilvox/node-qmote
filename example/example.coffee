Qmote = require '../src/qmote.coffee'

Qmote.setName 'Qmote 5C2D'
Qmote.discover (qmote) ->
  console.log 'Discovered!'
  qmote.connectAndSetup (error) ->
    console.log 'Connected!'
    qmote.notifyButton (data) ->
      console.log qmote.parseCode(data)
