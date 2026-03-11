import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

void main() => runApp(CollaudoLg60());

class CollaudoLg60 extends StatefulWidget {
  @override
  _Collaudo_lg60AppState createState() => _Collaudo_lg60AppState();
}

class _Collaudo_lg60AppState extends State<CollaudoLg60> {
  var availablePorts = [];
  List<String> ports = [];
  String? selectedValue;
  SerialPort? serialPort;

  @override
  void initState() {
    super.initState();
    initPorts();
  }

  void initPorts() {
    setState(() => availablePorts = SerialPort.availablePorts);
    ports = SerialPort.availablePorts;
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

    /*serialPort!.config = SerialPortConfig()
              ..baudRate = 19200
              ..stopBits = 1
              ..parity = SerialPortParity.odd;*/
  }

  void disconnectPort() {
    serialPort!.flush();
    serialPort!.close();
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    return ports.map((String port) {
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
              DropdownButton <String>(
                value: selectedValue,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue!;
                  });
                },
                items: dropdownItems,
              ),
              const SizedBox(width: 30),
              ElevatedButton(
                onPressed: initPorts, 
                child: Icon(Icons.refresh)
              ),
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