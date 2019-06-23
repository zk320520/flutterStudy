import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwiperDiy extends StatelessWidget {
  final List swiperDataList;
  const SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    // print('设备宽度:${ScreenUtil.screenWidth}');
    // print('设备高度:${ScreenUtil.screenHeight}');
    // print('设备像素密度:${ScreenUtil.pixelRatio}');
    return Container(
      width: ScreenUtil().setWidth(750.0),
      height: ScreenUtil().setHeight(280.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network("${this.swiperDataList[index]['image']}",
              fit: BoxFit.fill);
        },
        itemCount: this.swiperDataList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}