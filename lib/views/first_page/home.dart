import 'package:flutter/widgets.dart';
import 'package:flutterdemo/utils/shared_preference.dart';
import 'package:flutterdemo/model/widget.dart';
import 'package:flutterdemo/model/search_history.dart';
import 'package:flutter/material.dart';
import 'package:flutterdemo/resources/shared_preferences_keys.dart';
import 'package:flutterdemo/routers/application.dart';
import 'package:flutterdemo/utils/provider.dart';
import 'package:flutterdemo/components/search_input.dart';
import 'package:flutterdemo/resources/widget_name_to_icon.dart';
import 'package:flutterdemo/widgets/index.dart';

class AppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }

}

class _MyHomePageState extends State<AppPage>
    with SingleTickerProviderStateMixin {

  SpUtil sp;
  WidgetControlModel widgetControlModel = new WidgetControlModel();
  SearchHistoryList searchHistoryList;
  TabController controller;
  bool isSearch = false;
  String data = "无";
  String data2ThirdPage = "这是传给ThirdPage的值";
  String appBarTitle = tabData[0]["text"];
  static List tabData = [
    {"text": "动态", "icon": new Icon(Icons.language)},
    {"text": "组件", "icon": new Icon(Icons.extension)},
    {"text": "组件收藏", "icon": new Icon(Icons.favorite)},
    {"text": "关于", "icon": new Icon(Icons.import_contacts)}
  ];
  List<Widget> myTabs = [];

  @override
  void initState() {
    super.initState();
    initSearchHistory();
    controller = new TabController(length: 4, vsync: this, initialIndex: 0);
    for (int i = 0; i < tabData.length; i++) {
      myTabs.add(new Tab(text: tabData[i]["text"], icon: tabData[i]["icon"]));
    }
    controller.addListener(() {
      if (controller.indexIsChanging) {
        _onTabChange();
      }
    });
    Application.controller = controller;
  }

  initSearchHistory() async {
    sp = await SpUtil.getInstance();
    String json = sp.getString(SharedPreferencesKeys.searchHistory);
    print("json$json");
    searchHistoryList = SearchHistoryList.fromJSON(json);
  }

  @override
  Widget build(BuildContext context) {
    var db = Provider.db;
    return new Scaffold(
      appBar: new AppBar(title: buildSearchInput(context),),
    );
  }

  Widget buildSearchInput(BuildContext context) {
    return new SearchInput((value) async {
      if (value != "") {
        List<WidgetPoint> list = await widgetControlModel.search(value);
        return list
            .map((item) =>
        new MaterialSearchResult<String>(
          value: item.name,
          icon: WidgetName2Icon.icons[item.name] ?? null,
          text: "widget",
          onTap: () {
            onWidgetTap(item, context);
          },
        ))
            .toList();
      }
    }, (value) {}, () {});
  }

  void onWidgetTap(WidgetPoint widgetPoint, BuildContext context) {
    List widgetDemosList = new WidgetDemoList().getDemos();
    String targetName = widgetPoint.name;
    String targetRouter = '/category/error/404';
    widgetDemosList.forEach((item) {
      if (item.name == targetName) {
        targetRouter = item.routerName;
      }
    });
    searchHistoryList
        .add(SearchHistory(name: targetName, targetRouter: targetRouter));
    print("searchHistoryList ${searchHistoryList.toString()}");
    Application.router.navigateTo(context, "$targetRouter");
  }

  void _onTabChange() {
    if (this.mounted) {
      this.setState(() {
        appBarTitle = tabData[controller.index]["text"];
      });
    }
  }
}

