NobleDevice = require('noble-device')
QMOTE_SERVICE_UUID = 'e80088024143545351626c696e6b73ec'
QMOTE_NOTIFY_CHAR = 'e8009a034143545351626c696e6b73ec'

Qmote = (peripheral) ->
  NobleDevice.call this, peripheral

Qmote.setName = (name) =>
  @name = name

Qmote.is = (peripheral) =>
  deviceName = peripheral.advertisement.localName
  return deviceName == @name if @name?
  return true

Qmote.prototype.notifyButton = (onRead) ->
  this.notifyCharacteristic QMOTE_SERVICE_UUID, QMOTE_NOTIFY_CHAR, true, onRead

Qmote.prototype.parseCode = (data) ->
  code = data.readUInt8(0)
  return 'doubleClick' if code == 2
  return 'click' if code == 1
  return 'release' if code == 0

NobleDevice.Util.inherits Qmote, NobleDevice
NobleDevice.Util.mixin Qmote, NobleDevice.BatteryService
NobleDevice.Util.mixin Qmote, NobleDevice.DeviceInformationService
module.exports = Qmote
