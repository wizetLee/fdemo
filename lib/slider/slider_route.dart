import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SliderRoute extends StatefulWidget {
  const SliderRoute({Key? key}) : super(key: key);

  @override
  State<SliderRoute> createState() => _SliderRouteState();
}

class _SliderRouteState extends State<SliderRoute> {
  double _sliderValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      color: Colors.white,
      child: Column(children: [
          Container(height: 100,),
        Row(
          children: <Widget>[
            Text('Slider', style: TextStyle(decoration: TextDecoration.none, fontSize: 16),),
            Expanded(
              child: Slider(
                value: _sliderValue,
                onChanged: (data) {
                  print('change:$data');
                  setState(() {
                    this._sliderValue = data;
                  });
                },
                onChangeStart: (data) {
                  print('start:$data');
                },
                onChangeEnd: (data) {
                  print('end:$data');
                },
                min: 0.0,
                max: 10.0,
                divisions: 40,
                label: _sliderValue.toStringAsFixed(2),
                activeColor: Colors.green,
                inactiveColor: Colors.grey,
                semanticFormatterCallback: (double newValue) {
                  return '${newValue.round()} dollars}';
                },
              ),
            )
          ],
        )
      ],),
    ));
  }
}
