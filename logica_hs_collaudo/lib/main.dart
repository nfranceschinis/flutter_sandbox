import 'dart:async';
import 'package:logging/logging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:modbus_client/modbus_client.dart';
import 'package:modbus_client_serial/modbus_client_serial.dart';

import 'logica_data_impl.dart';


void main() async {
  ModbusAppLogger(Level.FINE);

  runApp(CollaudoLg60());
}

class CollaudoLg60 extends StatefulWidget {
  @override
  _Collaudo_lg60AppState createState() => _Collaudo_lg60AppState();
}

class _Collaudo_lg60AppState extends State<CollaudoLg60> {
  final ports = ValueNotifier<List<String>>([]);
  String? selectedValue;
  SerialPort? serialPort;
  /* Serial related impl */
  @override
  void initState() {
    super.initState();
    initPorts();
    Timer.periodic(const Duration(seconds: 1), (_) => initPorts());
  } 

  void initPorts() {
    ports.value = SerialPort.availablePorts;
  }

  void connectButton() {
    if(!isOpen) {
      connectPort();
    } else {
      disconnectPort();
    }
    getPortStatus();
  }

  void connectPort() {
    serialPort = SerialPort(selectedValue!);
    serialPort!.openReadWrite();
  }

  void disconnectPort() {
    serialPort!.flush();
    serialPort!.close();
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    return ports.value.map((String port) {
      return DropdownMenuItem<String>(
        value: port,
        child: Row(
          children: [
            Icon(Icons.usb_rounded),
            Text('   $port'),
          ],
        ),
      );
    }).toList();
  }

  bool get isOpen => serialPort?.isOpen ?? false;

  void getPortStatus() {
    setState(() {
      isOpen;
    });
  }


  /* Modbus related impl */

  var ModbusClient = ModbusClientSerialRtu(
    portName: '',
    unitId: 1,
    baudRate: SerialBaudRate.b19200,
    dataBits: SerialDataBits.bits8,
    parity: SerialParity.odd,
    stopBits: SerialStopBits.one,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          //title: const Text('Logica H&S LG60 tester'),
          title: const Text('Serial test'),
          backgroundColor: Colors.amber,
        ),
        body: Scrollbar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Comunicazione seriale:', style: TextStyle(fontStyle: FontStyle.italic)),
              const SizedBox(width: 30),
              ValueListenableBuilder(valueListenable: ports, builder: (value, context, _) => DropdownButton <String>(
                value: selectedValue,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue!;
                  });
                },
                items: dropdownItems,
              )),
              const SizedBox(width: 30),
              ElevatedButton(
                onPressed: connectButton, 
                child: isOpen ? Text('Disconnect') : Text('Connect')
              ),
              SizedBox(width: 30),
              IconButton(
                color: isOpen ? Colors.green : Colors.red,
                onPressed: () {}, 
                icon: Icon(Icons.filter_drama),

              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardListTile extends StatelessWidget {
  final String name;
  final String? value;

  CardListTile(this.name, this.value);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(value ?? 'N/A'),
        subtitle: Text(name),
      ),
    );
  }
}