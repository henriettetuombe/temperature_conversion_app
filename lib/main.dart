import 'package:flutter/material.dart';

void main() {
  runApp(TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TemperatureConverter(),
    );
  }
}

class TemperatureConverter extends StatefulWidget {
  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  final _temperatureController = TextEditingController();
  String _convertedTemperature = '';
  List<String> _conversionHistory = [];
  bool _isFtoC = true;

  void _convertTemperature() {
    double inputTemperature = double.tryParse(_temperatureController.text) ?? 0.0;
    double convertedTemperature;

    if (_isFtoC) {
      convertedTemperature = (inputTemperature - 32) * 5 / 9;
    } else {
      convertedTemperature = inputTemperature * 9 / 5 + 32;
    }

    setState(() {
      _convertedTemperature = convertedTemperature.toStringAsFixed(2);
      _conversionHistory.insert(
        0,
        '${_isFtoC ? 'F to C' : 'C to F'}: $inputTemperature => $_convertedTemperature',
      );
    });
  }

  @override
  void dispose() {
    _temperatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: RadioListTile<bool>(
                    title: Text('F to C'),
                    value: true,
                    groupValue: _isFtoC,
                    onChanged: (value) {
                      setState(() {
                        _isFtoC = value!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<bool>(
                    title: Text('C to F'),
                    value: false,
                    groupValue: _isFtoC,
                    onChanged: (value) {
                      setState(() {
                        _isFtoC = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            TextField(
              controller: _temperatureController,
              decoration: InputDecoration(
                labelText: 'Enter Temperature',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _convertTemperature,
              child: Text('Convert'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Converted Value: $_convertedTemperature',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _conversionHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_conversionHistory[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
