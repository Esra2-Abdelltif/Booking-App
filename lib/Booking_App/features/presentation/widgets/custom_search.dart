import 'package:booking_app/Booking_App/Core/utilites/app_colors.dart';
import 'package:flutter/material.dart';

class CommonSearchBar extends StatelessWidget {
  final String? text;
  final TextEditingController? textEditingController;
  final bool enabled, ishsow;
  final double height;
  final IconData? iconData;
  final bool? IsSearch;
  final Widget TextFormFieldWidget;

  const CommonSearchBar(
      {Key? key,
        this.text,
        this.enabled = false,
        this.height = 48,
        this.iconData,
        this.ishsow = true,
         this.IsSearch=false,
        this.textEditingController,
        required this.TextFormFieldWidget})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
      child: Container(
        height: height,
        child: Center(
          child: Row(
            children: <Widget>[
              ishsow == true
                  ? Icon(
                iconData,
                // FontAwesomeIcons.search,
                size: 18,
                color:AppColors.defultColor,
              )
                  : SizedBox(),
              ishsow == true
                  ? SizedBox(
                width: 8,
              )
                  : SizedBox(),
              Expanded(
                child:IsSearch == false
                ?TextField(
                  controller: textEditingController,
                  maxLines: 1,
                  enabled: enabled,
                  onChanged: (String txt) {},
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: new InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      errorText: null,
                      border: InputBorder.none,
                      hintText: text,
                      hintStyle: TextStyle(fontSize: 24)
                          .copyWith(
                          color:Colors.grey,
                          fontSize: 18)),
                ) :TextFormFieldWidget ,
              ),
            ],
          ),
        ),
      ),
    );
  }
}