class FilterModel {
  FilterModel({required this.name, required this.value}) : isSelected = false;

  String name;
  String value;
  bool isSelected;

  static List<FilterModel> starCategory = [
    FilterModel(name: '5 Star', value: '5'),
    FilterModel(name: '4 Star', value: '4'),
    FilterModel(name: '3 Star', value: '3'),
    FilterModel(name: '2 Star', value: '2'),
    FilterModel(name: '1 Star', value: '1'),
  ];

  static List<FilterModel> propertyType = [
    FilterModel(name: 'Hotel', value: 'Hotel'),
    FilterModel(name: 'Resort', value: 'Resort'),
    FilterModel(name: 'Apartment', value: 'Apartment'),
    FilterModel(name: 'Homestay', value: 'Homestay'),
    FilterModel(name: 'Villa', value: 'Villa'),
  ];

  static List<FilterModel> budget = [
    FilterModel(name: '1000', value: '1000'),
    FilterModel(name: '5000', value: '5000'),
    FilterModel(name: '10000', value: '10000'),
    FilterModel(name: '25000', value: '25000'),
    FilterModel(name: '50000', value: '50000'),
  ];

  static List<FilterModel> userRating = [
    FilterModel(name: '4.5+', value: '4.5'),
    FilterModel(name: '4+', value: '4'),
    FilterModel(name: '3+', value: '3'),
    FilterModel(name: '2+', value: '2'),
    FilterModel(name: '1+', value: '1'),
  ];
}
