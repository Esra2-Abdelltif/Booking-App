import 'package:flutter/material.dart';


class CommonAppbarView extends StatelessWidget {
  final double? topPadding;
  final Widget? backWidget;
  final String titleText;
  final VoidCallback? onBackClick;
  final IconData? iconData;
  final GestureTapCallback? onTap;

  const CommonAppbarView({
    Key? key,
    this.topPadding,
    this.onBackClick,
    this.titleText = '',
    this.backWidget,
    this.iconData,this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paddingTop = topPadding ?? MediaQuery.of(context).padding.top;
    return Padding(
      padding: EdgeInsets.only(top: paddingTop),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: AppBar().preferredSize.height,
            child: Padding(
              padding: EdgeInsets.only(top: 8, left: 8, right: 8),
              child: Container(
                width: AppBar().preferredSize.height - 8,
                height: AppBar().preferredSize.height - 8,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.all(
                      Radius.circular(32.0),
                    ),
                    onTap: onBackClick,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: backWidget ??
                          Icon(
                            iconData,
                           // color: AppTheme.primaryTextColor,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 24, right: 24),
            child: InkWell(
              onTap: onTap ,
              child: Text(titleText, style: TextStyle(
                fontSize: 24,

              )),
            ),
          ),
        ],
      ),
    );
  }
}