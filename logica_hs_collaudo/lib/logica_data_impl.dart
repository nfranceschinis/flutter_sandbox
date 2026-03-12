import 'package:modbus_client/modbus_client.dart';
import 'package:modbus_client_serial/modbus_client_serial.dart';

var offset = ModbusInt16Register(
  name: 'Offset',
  address: 1,
  type: ModbusElementType.holdingRegister,
  viewDecimalPlaces: 0,
);

var baudRate = ModbusInt16Register(
  name: 'Baud Rate',
  address: 2,
  type: ModbusElementType.holdingRegister,
  viewDecimalPlaces: 0,
);

var dataStream = ModbusInt16Register(
  name: 'Data Stream',
  address: 3,
  type: ModbusElementType.holdingRegister,
  viewDecimalPlaces: 0,
);

var reg1 = ModbusInt16Register(
  name: 'Reg1',
  address: 4,
  type: ModbusElementType.holdingRegister,
  viewDecimalPlaces: 0,
);

var reg2 = ModbusInt16Register(
  name: 'Reg2',
  address: 5,
  type: ModbusElementType.holdingRegister,
  viewDecimalPlaces: 0,
);

var reg3 = ModbusInt16Register(
  name: 'Reg3',
  address: 6,
  type: ModbusElementType.holdingRegister,
  viewDecimalPlaces: 0,
);

var digitalT = ModbusInt16Register(
  name: 'Digital Temperature',
  address: 7,
  type: ModbusElementType.inputRegister,
  viewDecimalPlaces: 1,
);

var digitalRH = ModbusInt16Register(
  name: 'Digital Relative Humidity',
  address: 8,
  type: ModbusElementType.inputRegister,
  viewDecimalPlaces: 1,
);

var uL1C = ModbusInt16Register(
  name: 'Compensated timber moisture 1',
  address: 20,
  type: ModbusElementType.inputRegister,
  viewDecimalPlaces: 1,
);

var uL2C = ModbusInt16Register(
  name: 'Compensated timber moisture 2',
  address: 21,
  type: ModbusElementType.inputRegister,
  viewDecimalPlaces: 1,
);

var uL3C = ModbusInt16Register(
  name: 'Compensated timber moisture 3',
  address: 22,
  type: ModbusElementType.inputRegister,
  viewDecimalPlaces: 1,
);

var uL4C = ModbusInt16Register(
  name: 'Compensated timber moisture 4',
  address: 23,
  type: ModbusElementType.inputRegister,
  viewDecimalPlaces: 1,
);

var reg4 = ModbusInt16Register(
  name: 'Reg4',
  address: 24,
  type: ModbusElementType.holdingRegister,
  viewDecimalPlaces: 0,
);

var t1 = ModbusInt16Register(
  name: 'NTC Temperature',
  address: 25,
  type: ModbusElementType.inputRegister,
  viewDecimalPlaces: 1,
);

var tcomp = ModbusInt16Register(
  name: 'Compensation temperature',
  address: 26,
  type: ModbusElementType.inputRegister,
  viewDecimalPlaces: 1,
);

var timberGroup = ModbusInt16Register(
  name: 'Timber Group',
  address: 105,
  type: ModbusElementType.holdingRegister,
  viewDecimalPlaces: 0,
);


var tradeMark = ModbusInt16Register(
  name: 'TradeMark',
  address: 220,
  type: ModbusElementType.inputRegister,
  viewDecimalPlaces: 0,
);

var type = ModbusInt16Register(
  name: 'Model',
  address: 221,
  type: ModbusElementType.inputRegister,
  viewDecimalPlaces: 0,
);

var protocol = ModbusInt16Register(
  name: 'Protocol revision',
  address: 222,
  type: ModbusElementType.inputRegister,
  viewDecimalPlaces: 0,
);

var firmware = ModbusInt16Register(
  name: 'Firmware revision',
  address: 223,
  type: ModbusElementType.inputRegister,
  viewDecimalPlaces: 0,
);