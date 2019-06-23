import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'dart:convert';

import '../service/service_method.dart';
import '../components/swiperDiy.dart';
import '../components/topNavigator.dart';
import '../components/adBanner.dart';
import '../components/leaderPhone.dart';
import '../components/recommend.dart';
import '../components/floorTitle.dart';
import '../components/floorContent.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  String homePageContent = '正在获取数据';
  int page = 1;
  List<Map> hotGoodsList = [];
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();

  @override
  void initState() {
    var formPage = {'page': page};
    request('homePageBelowConten', formData: formPage).then((val) {
      var data = json.decode(val.toString());
      List<Map> newGoodsList = (data['data'] as List).cast();
      setState(() {
        this.hotGoodsList.addAll(newGoodsList);
        this.page++;
      });
    });
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  Widget _hotTitle = Container(
    margin: EdgeInsets.only(top: 10.0),
    padding: EdgeInsets.all(5.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(bottom: BorderSide(width: 0.5, color: Colors.black12)),
    ),
    child: Text('火爆专区'),
  );

  Widget _wrapList() {
    if (this.hotGoodsList.length != 0) {
      List<Widget> listWidget = this.hotGoodsList.map((val) {
        return InkWell(
            onTap: () {
              print('点击了火爆商品');
            },
            child: Container(
              width: ScreenUtil().setWidth(372.0),
              color: Colors.white,
              padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.only(bottom: 3.0),
              child: Column(
                children: <Widget>[
                  Image.network(
                    val['image'],
                    width: ScreenUtil().setWidth(375.0),
                  ),
                  Text(
                    val['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
                  ),
                  Row(
                    children: <Widget>[
                      Text('￥${val['mallPrice']}'),
                      Text(
                        '￥${val['price']}',
                        style: TextStyle(
                            color: Colors.black26,
                            decoration: TextDecoration.lineThrough),
                      )
                    ],
                  )
                ],
              ),
            ));
      }).toList();
      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text(' ');
    }
  }

  Widget _hotGoods() {
    return Container(
        child: Column(
      children: <Widget>[
        _hotTitle,
        _wrapList(),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    return Scaffold(
        appBar: AppBar(title: Text('百姓生活+')),
        body: FutureBuilder(
          future: request('homePageContext',
              formData: {'lon': '115.02932', 'lat': '35.76189'}),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());
              List<Map> swiperDataList =
                  (data['data']['slides'] as List).cast(); // 顶部轮播组件数

              List<Map> navigatorList =
                  (data['data']['category'] as List).cast(); //类别列表
              if (navigatorList.length > 10) {
                navigatorList.removeRange(10, navigatorList.length);
              }

              String advertesPicture =
                  data['data']['advertesPicture']['PICTURE_ADDRESS']; //广告图片

              String leaderImage =
                  data['data']['shopInfo']['leaderImage']; //店长图片
              String leaderPhone =
                  data['data']['shopInfo']['leaderPhone']; //店长电话

              List<Map> recommendList =
                  (data['data']['recommend'] as List).cast(); // 商品推荐

              String floor1Title =
                  data['data']['floor1Pic']['PICTURE_ADDRESS']; //楼层1的标题图片
              String floor2Title =
                  data['data']['floor2Pic']['PICTURE_ADDRESS']; //楼层1的标题图片
              String floor3Title =
                  data['data']['floor3Pic']['PICTURE_ADDRESS']; //楼层1的标题图片
              List<Map> floor1 =
                  (data['data']['floor1'] as List).cast(); //楼层1商品和图片
              List<Map> floor2 =
                  (data['data']['floor2'] as List).cast(); //楼层1商品和图片
              List<Map> floor3 =
                  (data['data']['floor3'] as List).cast(); //楼层1商品和图片
              return EasyRefresh(
                child: ListView(
                  children: <Widget>[
                    SwiperDiy(swiperDataList: swiperDataList), //页面顶部轮播组件
                    TopNavigator(navigatorList: navigatorList), //导航组件
                    AdBanner(advertesPicture: advertesPicture), //广告组件
                    LeaderPhone(
                        leaderImage: leaderImage, leaderPhone: leaderPhone),
                    Recommend(recommendList: recommendList),
                    FloorTitle(pictureAddress: floor1Title),
                    FloorContent(floorGoodsList: floor1),
                    FloorTitle(pictureAddress: floor2Title),
                    FloorContent(floorGoodsList: floor2),
                    FloorTitle(pictureAddress: floor3Title),
                    FloorContent(floorGoodsList: floor3),
                    _hotGoods(),
                  ],
                ),
                loadMore: () async {
                  print('开始加载更多');
                  var formPage = {'page': page};
                  await request('homePageBelowConten', formData: formPage)
                      .then((val) {
                    var data = json.decode(val.toString());
                    List<Map> newGoodsList = (data['data'] as List).cast();
                    setState(() {
                      hotGoodsList.addAll(newGoodsList);
                      page++;
                    });
                  });
                },
                refreshFooter: ClassicsFooter(
                    key: _footerKey,
                    bgColor: Colors.white,
                    textColor: Colors.pink,
                    moreInfoColor: Colors.pink,
                    showMore: true,
                    noMoreText: '',
                    moreInfo: '加载中',
                    loadReadyText: '上拉加载....'),
              );
            } else {
              return Center(
                child: Text('加载中'),
              );
            }
          },
        ));
  }
}
