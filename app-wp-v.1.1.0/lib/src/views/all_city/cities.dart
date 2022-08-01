import 'package:Golo/modules/services/platform/Platform.dart';
import 'package:Golo/modules/state/AppState.dart';
import 'package:Golo/src/providers/request_services/Api+city.dart';
import 'package:Golo/src/widget/grid_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:Golo/localization/Localized.dart';
import 'package:Golo/localization/LocalizedKey.dart';
import 'package:Golo/modules/setting/colors.dart';
import 'package:Golo/modules/setting/fonts.dart';
import 'package:Golo/src/blocs/navigation/NavigationBloc.dart';
import 'package:Golo/src/entity/City.dart';
import 'package:Golo/src/views/home/controls/city_cell.dart';
import 'package:rxdart/rxdart.dart';

class Cities extends StatefulWidget {
  final List<City>? cities;

  Cities({this.cities});

  @override
  _CitiesState createState() {
    return _CitiesState();
  }
}

class _CitiesState extends State<Cities> {
  final BehaviorSubject<List<City>?> listCities = BehaviorSubject();

  Future<List<City>> fetchCities() async {
    return ApiCity.fetchCities().then((response) {
      AppState().cities = List<City>.generate(response.json!.length, (i) {
        return City.fromJson(response.json![i],Platform().shared.type);
      });
      print("fetchCities ${AppState().cities}");
      return AppState().cities;
    }, onError: (e) {
      print("fetchCities $e");
      throw ("fetchCities $e");
    });
  }

  @override
  void dispose() {
    listCities.close();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.cities == null ||
        (widget.cities != null && widget.cities!.isEmpty)) {
      fetchCities().then((value) => listCities.add(value));
    } else {
      listCities.add(widget.cities);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: EdgeInsets.only(top: 40, left: 25, right: 25, bottom: 10),
          child: Column(
            children: <Widget>[
              Text(
                Localized.of(context)!.trans(LocalizedKey.allCities) ?? "",
                style: TextStyle(
                    fontFamily: GoloFont,
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    color: GoloColors.secondary1,
                    letterSpacing: 0),
              ),
              Flexible(
                flex: 1,
                child: Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: _buildCityGridView()),
              )
            ],
          )),
    );
  }

  // ### City list
  Widget _buildCityGridView() => StreamBuilder<List<City>?>(
      stream: listCities,
      initialData: [],
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return new GridView.count(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              crossAxisCount: 2,
              childAspectRatio: 0.715,
              children: List.generate(snapshot.data!.length, (index) {
                return _buildCityCell(snapshot.data![index]);
              }));
        }
        return Text("Shimer");
      });

  Widget _buildCityCell(City city) => Container(
      child: Container(
          margin: EdgeInsets.only(right: 8, bottom: 8),
          height: 350,
          child: GestureDetector(
            child: CityCell.city_cell(city: city),
            onTap: () {
              HomeNav(context).openCity(city);
            },
          )));
}
