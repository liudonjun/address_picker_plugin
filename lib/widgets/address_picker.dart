import 'dart:convert';
import 'package:address_picker_plugin/models/area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class AddressPickerWidget extends StatefulWidget {
  const AddressPickerWidget({Key? key}) : super(key: key);

  @override
  State<AddressPickerWidget> createState() => _AddressPickerWidgetState();

  static Future<Map<String, String>?> showAddressPicker(
      BuildContext context) async {
    return await showModalBottomSheet<Map<String, String>>(
      context: context,
      backgroundColor: const Color.fromARGB(0, 3, 1, 1),
      builder: (BuildContext context) {
        return const AddressPickerWidget();
      },
    );
  }
}

class _AddressPickerWidgetState extends State<AddressPickerWidget> {
  List<Province> provinces = [];
  List<City> cities = [];
  List<Area> areas = [];
  int selectedProvinceIndex = 0;
  int selectedCityIndex = 0;
  int selectedAreaIndex = 0;

  ValueNotifier<int> cityNotifier = ValueNotifier<int>(0);
  ValueNotifier<int> areaNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    final String response =
    await rootBundle.loadString('packages/address_picker_plugin/lib/assets/address.json');
    final data = await json.decode(response) as List;
    setState(() {
      provinces = data.map((json) => Province.fromJson(json)).toList();
      if (provinces.isNotEmpty) {
        selectedProvinceIndex = 0;
        cities = provinces[selectedProvinceIndex].cities;
        if (cities.isNotEmpty) {
          selectedCityIndex = 0;
          areas = cities[selectedCityIndex].district;
          if (areas.isNotEmpty) {
            selectedAreaIndex = 0;
          }
        }
      }
    });
  }

  void updateCityAndArea(int provinceIndex, int cityIndex) {
    selectedProvinceIndex = provinceIndex;
    selectedCityIndex = cityIndex;
    selectedAreaIndex = 0;
    cities = provinces[selectedProvinceIndex].cities;
    areas = cities.isNotEmpty ? cities[selectedCityIndex].district : [];
    cityNotifier.value++;
    areaNotifier.value++;
  }

  void updateCity(int index, int areaIndex) {
    selectedCityIndex = index;
    selectedAreaIndex = areaIndex;
    areas = cities.isNotEmpty ? cities[selectedCityIndex].district : [];
    areaNotifier.value++;
  }

  void updateArea(int index) {
    selectedAreaIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        height: 300,
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              height: 40,
              padding: EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  SizedBox(
                    width: 24,
                  ),
                  Text('选择地区',
                      style: TextStyle(
                          fontSize: 17, color: Color.fromRGBO(0, 0, 0, 1)))
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: CupertinoPicker(
                      key: ValueKey<int>(selectedProvinceIndex),
                      itemExtent: 60.0,
                      backgroundColor: Colors.white,
                      scrollController: FixedExtentScrollController(
                        initialItem: selectedProvinceIndex,
                      ),
                      selectionOverlay: Container(
                        decoration: BoxDecoration(
                            border: Border.symmetric(
                                horizontal: BorderSide(
                                    width: .5,
                                    color: Color.fromRGBO(238, 238, 238, 1)))),
                      ),
                      onSelectedItemChanged: (int index) {
                        updateCityAndArea(index, 0);
                      },
                      children: List.generate(provinces.length, (index) {
                        return Center(
                          child: Text(
                            provinces[index].province,
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                      }),
                    ),
                  ),
                  Expanded(
                    child: ValueListenableBuilder<int>(
                      valueListenable: cityNotifier,
                      builder: (context, value, child) {
                        return CupertinoPicker(
                          key: ValueKey<int>(selectedCityIndex),
                          backgroundColor: Colors.white,
                          itemExtent: 60.0,
                          selectionOverlay: Container(
                            decoration: BoxDecoration(
                                border: Border.symmetric(
                                    horizontal: BorderSide(
                                        width: .5,
                                        color:
                                        Color.fromRGBO(238, 238, 238, 1)))),
                          ),
                          scrollController: FixedExtentScrollController(
                            initialItem: selectedCityIndex,
                          ),
                          onSelectedItemChanged: (int index) {
                            updateCity(index, 0);
                          },
                          children: List.generate(cities.length, (index) {
                            return Center(
                              child: Text(
                                cities[index].city,
                                style: TextStyle(fontSize: 15),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: ValueListenableBuilder<int>(
                      valueListenable: areaNotifier,
                      builder: (context, value, child) {
                        return CupertinoPicker(
                          key: ValueKey<int>(selectedAreaIndex),
                          backgroundColor: Colors.white,
                          itemExtent: 60.0,
                          selectionOverlay: Container(
                            decoration: BoxDecoration(
                                border: Border.symmetric(
                                    horizontal: BorderSide(
                                        width: .5,
                                        color:
                                        Color.fromRGBO(238, 238, 238, 1)))),
                          ),
                          scrollController: FixedExtentScrollController(
                            initialItem: selectedAreaIndex,
                          ),
                          onSelectedItemChanged: (int index) {
                            updateArea(index);
                          },
                          children: List.generate(areas.length, (index) {
                            return Center(
                              child: Text(
                                areas[index].area,
                                style: TextStyle(fontSize: 15),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0), // 设置圆角
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(247, 247, 247, 1)), // 设置背景颜色
                    ),
                    child: SizedBox(
                      width: 88,
                      height: 38,
                      child: Center(
                        child: Text(
                          '取消',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Color.fromRGBO(20, 119, 255, 1)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      Map<String, String> address = {
                        "province": provinces[selectedProvinceIndex].province,
                        "city": cities[selectedCityIndex].city,
                        "area": areas[selectedAreaIndex].area,
                      };

                      Navigator.of(context).pop(address);
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0), // 设置圆角
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(20, 119, 255, 1)), // 设置背景颜色
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        TextStyle(
                            fontSize: 16.0, color: Colors.white), // 设置文字大小
                      ),
                    ),
                    child: SizedBox(
                        width: 88,
                        height: 38,
                        child: Center(
                          child: Text(
                            '确定',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
