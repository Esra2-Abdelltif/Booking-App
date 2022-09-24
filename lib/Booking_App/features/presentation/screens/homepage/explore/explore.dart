//HotelHomeScreen
import 'package:booking_app/Booking_App/features/data/models/hotel_list.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/map/map_screen.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/custom_search.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/explorelistview.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_colors.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/common_card.dart';
import 'package:path/path.dart';

class Explore extends StatefulWidget{
  @override
  State<Explore> createState() => _Explore();
}
final searchController = TextEditingController();

class _Explore extends State<Explore>  with TickerProviderStateMixin{
    late final Animation<double> animation;
    late final AnimationController animationController;
    late final AnimationController _animationController;
   var hotellist = HotelListData.hotelList;
   ScrollController scrollcontriller = new ScrollController();
   int room = 1 ;
   int add = 2  ;
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.now().add (Duration(days: 5));
    bool isShowMap = false;
    final searchBarHeight = 158.0;
    final filterBarHeight = 52.0;

    @override
    void initState(){
      animationController =
          AnimationController(duration: Duration(milliseconds: 1000), vsync: this);
      _animationController =
          AnimationController(duration: Duration(milliseconds: 0), vsync: this);

      scrollcontriller
        ..addListener(() {
            if (scrollcontriller.offset <= 0) {
              // we static set the just below half scrolling values
              _animationController.animateTo(0.0);
            } else if (scrollcontriller.offset > 0.0 &&
                scrollcontriller.offset < searchBarHeight) {
              _animationController.animateTo(
                  (scrollcontriller.offset) / searchBarHeight);
            }  else {
              _animationController.animateTo(1.0);
            }
        });
    super.initState();
    }

    Future<bool> getdata()async {
      await  Future.delayed(Duration(milliseconds: 200));
      return true;
    }

    @override
    void dispose(){
      animationController.dispose();
      super.dispose();
    }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
           child: Column(
             children: [

                Container(
                margin: EdgeInsets.only(top: 20),
                 child :  _getAppbar(context),
                ),

               Container(
                 child: _getSearchBarUI(),
               ),

               Container(child: Padding(padding: EdgeInsets.only(left: 16,right: 16,bottom: 4),
               child: Row (children: [
               Padding(padding: EdgeInsets.all(9),
                   child: Text('530')),
                 Expanded(
                     child: Padding(
                       padding: EdgeInsets.only(left: 1),
                     child: Text('Hotel Found')),
                 ),
                 Material(
                   color: Colors.transparent,
                   child: InkWell(
                     borderRadius: BorderRadius.all(Radius.circular(4.0)),
                     onTap: (){
                     },
                     child: Padding(
                   padding: EdgeInsets.only(left: 1),
                     child:Row(children: [
                       Text('Filter'),

                       Padding(
                           padding: EdgeInsets.all(8),
                           child: Icon (Icons.sort)),
                     ],),
                   ),
                 )
                 ),
                   ]),
               ),),
             ],
           ),
          ),
         Expanded(
        // Stack(children: [
              child: ListView.builder(
                controller: scrollcontriller,
                  itemCount: 5,
                  padding: EdgeInsets.only(top:8),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context,index){
                  var count =5 ;
                  var amination = Tween(begin: 0.0,end: 1.0).animate(
                    CurvedAnimation(parent: animationController, curve: Interval((1/count)*index,1.0,
                    curve: Curves.fastOutSlowIn))
                   );
                 animationController.forward;
                // return Container(child: Text('text2'));
                  return ExploreListView(
                  callback: (){}, hotelData: hotellist[index],
                  animation: amination, animationController: animationController);

                   },
              ),
         ),
          //  AnimatedBuilder(animation: _1animationController,
           //  builder: ((context, child) {return Positioned(child: Container());

            // }
            // ),
              
           // )
            ///////////AminationBuilder //////////////
          ]
       //)
     )
   //],
  // ),
    );
  }
}
Widget _getAppbar (BuildContext context){
  return Padding (
    padding: EdgeInsets.only(top: 8,left: 8,right: 8),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.end  ,
    children: [
      Container(
        alignment:Alignment.centerLeft ,
        width: AppBar().preferredSize.height+40,
        height: AppBar().preferredSize.height,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius:  BorderRadius.all(Radius.circular(32.0)),
          onTap: (){
             // Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.arrow_back),
          ),
          ),
        ),
      ),

      Expanded(child: Center(child: Text('Explore' ),)),

      Container(
        width: AppBar().preferredSize.height+40,
        height: AppBar().preferredSize.height,
        child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end  ,

        children: [
          Material(
            color: Colors.transparent,
           child: InkWell(
              borderRadius:  BorderRadius.all(Radius.circular(32.0)),
              onTap:(){
              } ,
              child:Padding(padding: EdgeInsets.all(8.0),
               child: Icon(Icons.favorite_border),

              )
            ),
          ),

          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius:  BorderRadius.all(Radius.circular(32.0)),
              onTap:(){
                Navigator.pushNamed(context, MapScreen.routeName);
              } ,
          child:Padding(padding: EdgeInsets.all(8.0),
          child: Icon(Icons.map_outlined),
            ),
          ),)
        ],
      ),),


    ],
  ),

  );
}

Widget _getSearchBarUI(){

  return Padding(
    padding: const EdgeInsets.only(right: 24,left: 24,top: 16,bottom: 16),
    child: CommonCard(
      color: AppColors.white,
      radius: 36,
      child: CommonSearchBar(
        textEditingController: searchController,
        iconData: FontAwesomeIcons.search,
        TextFormFieldWidget: TextField(
          controller:  searchController,
          maxLines: 1,
          enabled: true,
          onChanged: (String txt) {},
         // cursorColor: Theme.of(context).primaryColor,
          decoration: new InputDecoration(
              contentPadding: EdgeInsets.all(0),
              errorText: null,
              border: InputBorder.none,
              hintText: "London...",
              hintStyle: TextStyle(fontSize: 24)
                  .copyWith(
                  color:Colors.grey,
                  fontSize: 18)),
        ),
        enabled: true,
        text: "London...",

      ),
    ),
  );


  /* return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
      child: Card(
      //   shadowColor: Theme.of(context).dividerColor,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
     // borderRadius: BorderRadius.circular(widget.radius),
      ),
      child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(38)),
          onTap: () {
         //   NavigationServices(context).gotoSearchScreen();
          },
          child: CommonSearchBar(
            iconData: Icons.search,
            enabled: false,
            //text: AppLocalizations(context).of("where_are_you_going"),
          ),
        ),
      ),
    );
*/

}




















