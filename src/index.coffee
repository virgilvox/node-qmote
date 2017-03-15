noble = require 'noble'
qmoteName = 'Qmote 5C2D'
serviceUuids = ['e80088024143545351626c696e6b73ec']
characteristicUuids = ['e8009a034143545351626c696e6b73ec']

noble.on 'stateChange', (state) ->
  if state == 'poweredOn'
    noble.startScanning()
  else
    noble.stopScanning()

noble.on 'discover', (peripheral) ->
  { id, address, advertisement } = peripheral
  { localName, serviceData } = advertisement
  if( localName == qmoteName )
    noble.stopScanning()
    peripheral.connect (error) ->
      console.error error if error?
      peripheral.discoverServices serviceUuids, (error, services) ->
        console.error error if error?
        service = services[0]
        service.discoverCharacteristics characteristicUuids, (error, characteristics) ->
          characteristic = characteristics[0]

          characteristic.subscribe (error) ->
            console.error if error?
            console.log 'Subscribed!'

          characteristic.on 'data', (data, isNotification) ->
            console.log 'new data:', data.readUInt8(0)
