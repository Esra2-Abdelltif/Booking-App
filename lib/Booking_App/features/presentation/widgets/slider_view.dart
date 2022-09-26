
import 'package:flutter/material.dart';

class SliderView extends StatefulWidget {
  final double disValue;
  final Function(double) onchangedisvalue;

  const SliderView({Key? key, required this.disValue, required this.onchangedisvalue}) : super(key: key);

  @override
  State<SliderView> createState() => _SliderViewState();
}

class _SliderViewState extends State<SliderView> {
  double disvalue = 50.0;
  @override
  void initState() {
    disvalue = widget.disValue;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
      children: [ Row(children: [
        Expanded(child: SizedBox(),flex: disvalue.round(),),
        Container(
          width: 170,
          child: Row(children: [
            Text('Less than',textAlign: TextAlign.start,),
            Padding(padding: EdgeInsets.only(left: 4,right: 4),
            child: Text('${(disvalue/10).toStringAsFixed(1)}',textAlign: TextAlign.center),
            ),
            Text('km',textAlign: TextAlign.center),
          ]),
        ),
        Expanded(flex: 100- disvalue.round(),
          child: SizedBox(),)
      ],),
        Slider(onChanged: (value){
          setState(() {
            disvalue=value;
          });
          try{
            widget.onchangedisvalue(disvalue);
          }
              catch (e){}
        },
        min: 0.0,
          max: 100.0,
          activeColor: Colors.teal,
          inactiveColor: Colors.grey,
          value: disvalue,
        ),
      ],
      ),
    );
  }
}

