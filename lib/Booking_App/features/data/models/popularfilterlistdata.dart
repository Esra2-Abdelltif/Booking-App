class PopularFilterListData {
  String titleTxt;
  bool isSelected;

  PopularFilterListData({
    this.titleTxt = '',
    this.isSelected = false,
  });

  static List<PopularFilterListData> popularFList = [
    PopularFilterListData(
      titleTxt: 'facilit5',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Wifi',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Wifi',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'A/C',
      isSelected: false,
    ),

  ];

  static List<PopularFilterListData> accomodationList = [
    PopularFilterListData(
      titleTxt: 'all_text',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'apartment',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Home_text',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'villa_data',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'hotel_data',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Resort_data',
      isSelected: false,
    ),
  ];
}