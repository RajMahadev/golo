import 'package:Golo/src/entity/PlaceAmenity.dart';
import 'package:Golo/src/entity/PlaceCategory.dart';
import 'package:Golo/src/entity/PlaceType.dart';
import 'package:Golo/src/providers/request_services/Api+city.dart';
import 'package:Golo/src/providers/request_services/PlaceProvider.dart';
import 'package:Golo/src/providers/request_services/query/PageQuery.dart';
import 'package:den_lineicons/den_lineicons.dart';
import 'package:flutter/material.dart';
import 'package:Golo/modules/setting/colors.dart';
import 'package:Golo/modules/state/AppState.dart';
import 'package:Golo/src/views/all_city/cities.dart';
import 'package:Golo/src/views/home/home.dart';

class DashboardTabs extends StatefulWidget {
  @override
  _DashboardTabsState createState() => _DashboardTabsState();
}

class _DashboardTabsState extends State<DashboardTabs> {
  int? _currentTab;
  List<StatefulWidget>? _screens;

  @override
  void initState() {
    loadData();
    super.initState();
    _currentTab = 0;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentTab,
        children: _buildScreens()!,
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          openTab(index);
        },
        currentIndex: _currentTab!,
        items: <BottomNavigationBarItem>[
          _buildTabIcon(0),
          _buildTabIcon(1),
          // _buildTabIcon(2),
          // _buildTabIcon(3)
        ],
      ),
    );
    // return CupertinoTabScaffold(
    //   tabBar: _buildTabbars(),
    //   tabBuilder: (BuildContext context, int index) {
    //       return CupertinoTabView(
    //         builder: (BuildContext context) {
    //           return _buildPageForTabIndex(context, index);
    //         },
    //       );
    //     },
    // );
  }

  // COMPONENTS

  BottomNavigationBarItem _buildTabIcon(index) {
    var icon;
    var title;
    switch (index) {
      case 0:
        icon = DenLineIcons.home;
        break;
      case 1:
        icon = DenLineIcons.city;
        break;
      // case 2: icon = DenLineIcons.bookmark; break;
      // case 3: icon = DenLineIcons.user; break;
      default:
        icon = DenLineIcons.home;
        break;
    }
    var _normalIcon =
        Container(child: Icon(icon, size: 24, color: GoloColors.secondary2));
    var _activeIcon =
        Container(child: Icon(icon, size: 24, color: GoloColors.primary));
    return BottomNavigationBarItem(
        label: '', icon: _normalIcon, activeIcon: _activeIcon);
  }

  List<StatefulWidget>? _buildScreens() {
    _screens = <StatefulWidget>[
      Home(homeOpenAllCities: () {
        openTab(1);// BottomNavigationBarItem
      }),
      Cities(
        cities: AppState().cities,
      ),
      // ComingSoonPage(),
      // ComingSoonPage()
    ];
    return _screens;
  }

  // ### ACTIONS
  void openTab(int index) {
    setState(() {
      _currentTab = index;
    });
  }

  // ### Fetch Data
  void loadData() async {
    await Future.wait([
      //   fetchCities(),
      //   fetchPosts(),
      fetchCategories(),
      fetchAmenities(),
      fetchPlaceTypes()
    ]).then((value) {}, onError: (e) {
      print("DashBoard:::loadData $e");
    });
  }

  Future fetchCategories() async {
    return ApiCity.fetchCategories().then((response) {
      AppState().categories =
          List<PlaceCategory>.generate(response.json!.length, (i) {
        return PlaceCategory.fromJson(response.json![i]);
      });
      print("fetchCategories ${AppState().categories}");
    }, onError: (e) {
      print("fetchCategories $e");
      throw ("fetchCategories $e");
    });
  }

  Future fetchAmenities() async {
    return ApiCity.fetchAmenities().then((response) {
      AppState().amenities = List<PlaceAmenity>.generate(response.json!.length,
          (i) => PlaceAmenity.fromJson(response.json![i]));
      print("fetchAmenities ${AppState().amenities}");
    }, onError: (e) {
      print("fetchAmenities $e");
      throw ("fetchAmenities $e");
    });
  }

  Future fetchPlaceTypes() async {
    return PlaceProvider.getPlaceTypes(query: PageQuery(50, 1)).then(
        (response) {
      AppState().placeTypes =
          List<PlaceType>.generate(response.json!.length, (i) {
        return PlaceType.fromJson(response.json![i]);
      });
      print("fetchPlaceTypes  ${AppState().placeTypes}");
    }, onError: (e) {
      print("fetchPlaceTypes $e");
      throw ("fetchPlaceTypes $e");
    });
  }
}
