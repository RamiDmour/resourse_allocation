import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:resourse_allocation/screens/calculations_page.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController _amountYearsController = TextEditingController();

  @override
  void dispose() {
    _amountYearsController.dispose();
    super.dispose();
  }

  void _submit() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CalculationsPage(
                years: int.parse(_amountYearsController.text))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              'Программа оптимального планирования распределения ресурсов')),
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(48.0),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      'Оптимальное распределение ресурсов',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 36),
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Center(
                    child: TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                      controller: _amountYearsController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: 'Количество лет',
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.blueAccent)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: MaterialButton(
                    height: 54,
                    minWidth: double.infinity,
                    color: Colors.green,
                    child: Text(
                      'Запустить',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => _submit(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
