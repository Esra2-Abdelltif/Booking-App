
import 'package:booking_app/Booking_App/features/presentation/widgets/custom_appBar_view.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/ranegsliderview.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/slider_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:booking_app/Booking_App/features/data/models/popularfilterlistdata.dart';


class FilterScreeen extends StatefulWidget {

  RangeValues _values = RangeValues(100, 600);
  List<PopularFilterListData>popularFilterData = PopularFilterListData.popularFList;
  List<PopularFilterListData>accomodationListData = PopularFilterListData.accomodationList;

   FilterScreeen({Key? key,}):super(key: key);

   @override
  State<FilterScreeen> createState() => _FilterScreeenState();
}
double disValue = 50.0;

class _FilterScreeenState extends State<FilterScreeen> {


  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Appthem.scaffoldBackgroundColor,
      child: Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonAppbarView(
                iconData: Icons.close,
                onBackClick: () {
                  Navigator.pop(context);
                },
                titleText: ('Filter'),
              ),
              Expanded(child: SingleChildScrollView(
                child: Padding(padding: EdgeInsets.only(left: 16, right: 16),
                    child: Column(children: [
                      pricebar(),
                      Divider(height: 1,),
                      popular_filter(),
                      Divider(height: 1,),
                      distanceviewUi(),
                      Divider(height: 1,),
                      allaccommodation(),



                    ],)),
              )),

            ]),
      ),

    );
  }

  Widget pricebar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.all(16),
          child: Text('Price (for 1 night)',
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.grey,
            ),

          ),),
        RanegsliderView(
          values: FilterScreeen()._values,
          onChangeRangeValues: (values) {
            FilterScreeen()._values = values;
          },
        ),
        SizedBox(height: 8,),


      ],);
  }

  Widget popular_filter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 8),
          child: Text('Popular filter',
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.teal,

            ),

          ),),

        Padding(padding: EdgeInsets.only(right: 16, left: 16),
            child: Column(
              children:
              getlist(),
            )
        ),
        SizedBox(height: 8,)

      ],);
  }

  List<Widget> getlist() {
    List<Widget>nolist = [];
    var count = 0;
    final colmncount = 2;

    for (var i = 0; i <
        FilterScreeen().popularFilterData.length / colmncount; i++) {
      List<Widget> listui = [];
      for (var j = 0; j < colmncount; j++) {
        try {
          final data = FilterScreeen().popularFilterData[count];
          listui.add(
              Expanded(child: Row(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      onTap: () {
                          setState(() {
                        data.isSelected = !data.isSelected;
                          });
                      },
                      child: Padding(
                          padding: EdgeInsets.only(top: 8, left: 8, bottom: 8),
                          child: Row(
                            children: [
                              Icon(data.isSelected ? Icons.check_box : Icons
                                  .check_box_outline_blank,
                                color: data.isSelected ? Colors.teal : Colors
                                    .grey,),
                              SizedBox(width: 4,),
                              FittedBox(
                                fit: BoxFit.cover,
                                child: Text(data.titleTxt),
                              ),
                            ],
                          )
                      ),
                    ),
                  )
                ],
              ))
          );
          count += 1;
        }
        catch (e) {}
      }
      nolist.add(Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: listui,));
    }
    return nolist;
  }

  Widget distanceviewUi (){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
    Padding(padding: EdgeInsets.only(left: 16, right: 16,bottom: 8,top: 16,),
    child:Text('Distance From City',style: TextStyle(color: Colors.grey),
    ),),
        SliderView(
          onchangedisvalue: (value){
            disValue = value;
        },
         disValue: disValue,
        )
    ],);
  }

  Widget allaccommodation(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.all(16.0),
        child:Text('Type Of accommodation',textAlign: TextAlign.left,) ,
        ),
        Padding(padding: EdgeInsets.only(left:16.0,right: 16.0),
          child:Column(
          children: getaccommodationui(),
          ) ,
        ),
        SizedBox(height: 8,),

      ],
    );
  }

  List<Widget> getaccommodationui(){
    List<Widget> nolist = [];
    for (var i = 0; i <
        FilterScreeen().accomodationListData.length ; i++) {
      final data = FilterScreeen().accomodationListData[i];
      nolist.add(
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              onTap: () {
                setState(() {
                  checkapppostion(i);
                });
              },
              child: Padding(
                  padding: EdgeInsets.all( 8),
                  child: Row(
                    children: [
                   Expanded(child: Text(data.titleTxt)),
                      CupertinoSwitch(
                        value: data.isSelected,
                        activeColor: data.isSelected ? Colors.teal : Colors.grey,
                        onChanged: (value){
                          setState(() {
                            checkapppostion(i);
                          });
                        },
                      ),
                    ],
                  )
              ),

/*
              child: Padding(
                  padding: EdgeInsets.only(top: 8, left: 8, bottom: 8),
                  child: Row(
                    children: [
                      Icon(data.isSelected ? Icons.check_box : Icons
                          .check_box_outline_blank,
                        color: data.isSelected ? Colors.teal : Colors
                            .grey,),
                      SizedBox(width: 4,),
                      FittedBox(
                        fit: BoxFit.cover,
                        child: Text(data.titleTxt),
                      ),
                    ],
                  )
              ),
           */
            ),
          )
      );
      if (i == 0) {
        nolist.add(Divider(height: 1,));
      }
    }
      return nolist;

    }
   void checkapppostion(int index){
    if (index ==0){
      if (FilterScreeen().accomodationListData[0].isSelected){
        FilterScreeen().accomodationListData.forEach((element) {
          element.isSelected= true;
        });
      } else {
        FilterScreeen().accomodationListData.forEach((element) {
          element.isSelected= true;

        });
      }
    } else {
      FilterScreeen().accomodationListData[index].isSelected = !FilterScreeen().accomodationListData[index].isSelected;
      var count =  0;
      for (var i = 0; i <
          FilterScreeen().accomodationListData.length ; i++) {
        if (i !=0) {
          var data =  FilterScreeen().accomodationListData[i];
          if (data.isSelected){
            count+=1;
          }
        }
      }
      if (count == FilterScreeen().accomodationListData.length-1)
        {
          FilterScreeen().accomodationListData[0].isSelected=true;
        }
      else
        {
          FilterScreeen().accomodationListData[0].isSelected=false;

        }


      }

   }
}






