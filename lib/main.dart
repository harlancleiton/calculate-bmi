import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      title: "Calculate BMI",
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const String _message = 'Informe seus dados';
  String _result = _message;
  String _info = '';
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();

  void _resetFields() {
    weightController.text = '';
    heightController.text = '';
    setState(() {
      _result = _message;
      _info = '';
    });
  }

  void _calculateBmi() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    double bmi = (weight / (height * height));
    setState(() {
      _result = 'Seu IMC é: ${bmi.toStringAsPrecision(3)}';
      if (bmi <= 16.9)
        _info = 'Muito abaixo do peso';
      else if (bmi > 16.9 && bmi <= 18.4)
        _info = 'Abaixo do peso';
      else if (bmi > 18.4 && bmi <= 24.9)
        _info = 'Peso normal';
      else if (bmi > 24.9 && bmi <= 29.9)
        _info = 'Acima do peso';
      else if (bmi > 29.9 && bmi <= 34.9)
        _info = 'Obesidade Grau I';
      else if (bmi > 34.9 && bmi <= 40)
        _info = 'Obesidade Grau II';
      else if (bmi > 40) _info = 'Obesidade Grau III';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculate BMI'),
          backgroundColor: Colors.deepPurple,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _resetFields();
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.person_outline,
                    size: 120.0,
                    color: Colors.deepPurple,
                  ),
                  TextFormField(
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Peso (kg)',
                        labelStyle: TextStyle(color: Colors.deepPurple)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.deepPurple, fontSize: 16.0),
                    validator: (value) {
                      if (value.isEmpty) return 'Insira seu peso';
                    },
                  ),
                  TextFormField(
                    controller: heightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Altura (cm)',
                        labelStyle: TextStyle(color: Colors.deepPurple)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.deepPurple, fontSize: 16.0),
                    validator: (value) {
                      if (value.isEmpty) return 'Insira sua altura';
                    },
                  ),
                  Container(
                    height: 42.0,
                    child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _calculateBmi();
                          } else {
                            setState(() {
                              _result = _message;
                              _info = '';
                            });
                          }
                        },
                        child: Text('Calcular',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0)),
                        color: Colors.deepPurple),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(_result,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.deepPurple, fontSize: 16.0)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(_info,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.deepPurple, fontSize: 16.0)),
                  )
                ],
              ),
            )));
  }
}
