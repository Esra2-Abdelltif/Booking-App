import 'package:booking_app/Booking_App/Core/utilites/app_colors.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_constance.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/account/login/login_screen_.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/hotel_details/hotel_details_screen.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/search_screen/search_screen.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 60),
        child: Column(
          children: [
            InkWell(
              onTap: (){
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Log out ? ',style: TextStyle(color: Colors.white, fontSize: 18)),
                        content: const Text('Do You sure to log out ?',  style: TextStyle(color: Colors.white, fontSize: 18)),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel',  style: TextStyle(color: Colors.white, fontSize: 18)),
                          ),
                          TextButton(
                            onPressed: () {
                              LogOut(context: context,router: LoginScreen());

                            },
                            child: const Text('Log out',  style: TextStyle(color:Colors.white, fontSize: 18)),
                          ),
                        ],
                        elevation: 24,
                        backgroundColor: AppColors.defultColor,
                        // shape: CircleBorder(),
                      );
                    }
                );
              },
              child: Container(
                  height: 60,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
                    // color: Colors.grey[100],
                    border: Border.all(
                      width: 1,
                      color: Colors.grey.shade100,
                    ),),
                  child: Row(children: [
                    SizedBox(width: 10),
                    Icon(Icons.logout ,color: AppColors.defultColor,size: 40),
                    SizedBox(width: 15),
                    Text('Log Out',
                      style: Theme.of(context).textTheme.bodyText2,),
                    Spacer(),
                    Icon(
                      Icons.navigate_next,
                      color: AppColors.defultColor ,
                      size: 30,
                    ),
                  ],)
              ),
            ),
            SizedBox(height: 20,),
            InkWell(onTap:(){
            } ,child: Text("Details")),
            SizedBox(height: 20,),
            InkWell(onTap:(){
              AppConstance.navigateTo(context: context,router: SearchScreen());
            } ,child: Text("search")),
            MaterialButton(
              onPressed: () {
                // AppBloc.get(context).userLogin();
              },
              child: const Text('Login'),
            ),
            MaterialButton(
              onPressed: () {
                AppBloc.get(context).userProfile();
              },
              child: const Text('Get Profile'),
            ),
            MaterialButton(
              onPressed: () {
                AppBloc.get(context).getHotels();
              },
              child: const Text('Get Hotels'),
            ),
            MaterialButton(
              onPressed: () {
                //AppBloc.get(context).getHotels();
              },
              child: const Text('Get Hotels'),
            ),
            MaterialButton(
              onPressed: () {
                //AppBloc.get(context).getHotels();
              },
              child: const Text('test'),
            ),
          ],
        ),
      ),

    );
  }
}
