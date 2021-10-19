import 'package:flutter/material.dart';
import 'package:mushni_chankseliani_assign_2/logic/metrics_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _enteredAmount = 0;
  String? _fromMetric;
  String? _toMetric;
  double _convertedAmount = 0;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();

  final List<String> _metrics = ['cm', 'm', 'km'];

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Listener(
      onPointerDown: (_) => _focusNode.unfocus(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            'Metrics Converter',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: deviceSize.height,
              decoration: const ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.lightBlue, Colors.purple],
                ),
                shape: ContinuousRectangleBorder(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 90),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Number:',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      SizedBox(
                        height: 60,
                        width: 120,
                        child: Center(
                          child: TextField(
                            focusNode: _focusNode,
                            controller: _textEditingController,
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.white,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(35),
                              ),
                            ),
                            onChanged: (text) {
                              setState(() {
                                var amount = double.tryParse(text);
                                if (amount != null) {
                                  _enteredAmount = amount;
                                } else {
                                  _enteredAmount = 0;
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: deviceSize.width - 100,
                        height: deviceSize.height / 2.2,
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              spreadRadius: 1,
                              blurRadius: 15,
                              offset:
                                  Offset(0, 0), // changes position of shadow
                            ),
                          ],
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [Colors.deepPurple, Colors.lightBlue],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 80,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'From:',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    width: 120,
                                    height: 50,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        selectedItemBuilder: (_) => _metrics
                                            .map((e) => Center(child: Text(e)))
                                            .toList(),
                                        iconEnabledColor: Colors.white,
                                        value: _fromMetric,
                                        borderRadius: BorderRadius.circular(35),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 18),
                                        items: _metrics
                                            .map(
                                              (currency) =>
                                                  DropdownMenuItem<String>(
                                                value: currency,
                                                child: Text(
                                                  currency,
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (dynamic value) {
                                          setState(() {
                                            _fromMetric = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: IconButton(
                                      icon: const Icon(
                                          Icons.compare_arrows_sharp),
                                      color: Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          if (_toMetric == null ||
                                              _fromMetric == null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Please Fill Metric Params!'),
                                              ),
                                            );
                                          } else {
                                            String? saveFromMetric =
                                                _fromMetric;
                                            _fromMetric = _toMetric;
                                            _toMetric = saveFromMetric;
                                            if (_enteredAmount > 0) {
                                              _convertedAmount =
                                                  CurrencyHelper().convertTo(
                                                _enteredAmount,
                                                _fromMetric,
                                                _toMetric,
                                              )!;
                                            }
                                          }
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'To:',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    width: 120,
                                    height: 50,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        selectedItemBuilder: (_) => _metrics
                                            .map((e) => Center(child: Text(e)))
                                            .toList(),
                                        iconEnabledColor: Colors.white,
                                        value: _toMetric,
                                        borderRadius: BorderRadius.circular(35),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 18),
                                        items: _metrics
                                            .map(
                                              (currency) =>
                                                  DropdownMenuItem<String>(
                                                value: currency,
                                                child: Text(
                                                  currency,
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (dynamic value) {
                                          setState(() {
                                            _toMetric = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Result:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 50,
                        decoration: BoxDecoration(
                          // border: Border.all(
                          //   color: Colors.blueAccent,
                          // ),
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Center(
                          child: Text(
                            _convertedAmount > 0
                                ? _convertedAmount.toString()
                                : 'None',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.cyan, Colors.blue, Colors.cyan],
                        ),
                      ),
                      height: 60,
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        onPressed: () {
                          if (_toMetric == null ||
                              _fromMetric == null ||
                              _enteredAmount <= 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please Fill All Params!'),
                              ),
                            );
                          } else {
                            setState(() {
                              _convertedAmount = CurrencyHelper().convertTo(
                                _enteredAmount,
                                _fromMetric,
                                _toMetric,
                              )!;
                            });
                          }
                        },
                        icon: const Icon(Icons.change_circle),
                        label: const Text(
                          'Convert',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.cyan, Colors.blue, Colors.cyan],
                        ),
                      ),
                      height: 60,
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        onPressed: () {
                          setState(() {
                            _focusNode.unfocus();
                            _textEditingController.clear();
                            _enteredAmount = 0;
                            _fromMetric = null;
                            _toMetric = null;
                            _convertedAmount = 0;
                          });
                        },
                        // normaluri icon ver vipove :/
                        icon: const Icon(Icons.clean_hands_rounded),
                        label: const Text(
                          'Reset',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
