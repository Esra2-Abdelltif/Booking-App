
import 'package:flutter/material.dart';

class RanegsliderView extends StatefulWidget {
 final Function(RangeValues) onChangeRangeValues;
 final RangeValues values;

   RanegsliderView({Key? key,required this.onChangeRangeValues, required this.values}) : super(key: key);

  @override
  State<RanegsliderView> createState() => _RanegsliderViewState();
}

class _RanegsliderViewState extends State<RanegsliderView> {
  late RangeValues _values;

  @override
  void initState() {
    _values = widget.values;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Stack(children: [
          Row(children: [
            Expanded(child: SizedBox(),flex: _values.start.round(),),
            Container(
              width:55,
              child: Text("\$${_values.start.round()}",textAlign: TextAlign.center),
            ),
            Expanded(child: SizedBox(),flex: 1000-_values.start.round(),)
          ],),
          Row(children: [
            Expanded(child: SizedBox(),flex: _values.end.round(),),
            Container(
              width:55,
              child: Text("\$${_values.end.round()}",textAlign: TextAlign.center),
            ),
            Expanded(child: SizedBox(),flex: 1000- _values.end.round(),),

          ],)
          
        ],),
        SliderTheme(data: SliderThemeData(),
            child: RangeSlider(values: _values,
                min: 10.0,
                max: 1000.0,
                activeColor: Colors.teal,
                inactiveColor: Colors.grey ,
                divisions: 1000,
                onChanged: (RangeValues v){
              try{
                setState(() {
                  _values= v;
                });
                widget.onChangeRangeValues(_values);

              }
                 catch (e){

              }

            }))

      ]),
    );
  }
}
