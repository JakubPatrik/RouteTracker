import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:myapp/Slides/SlideOne.dart';
import 'package:myapp/Slides/SlideThree.dart';
import 'package:myapp/Slides/SlideTwo.dart';

import 'my_flutter_app_icons.dart' as CustomIcon;


class Welcome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Welcome();
}

class _Welcome extends State<Welcome> with SingleTickerProviderStateMixin{

  final SwiperController  _swiperController = SwiperController();
  final int _pageCount = 3;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Swiper(
            index: _currentIndex,
            controller: _swiperController,
            itemCount: _pageCount,
            onIndexChanged: (index) {
              setState(() {_currentIndex = index;});
            },
          loop: false,
          itemBuilder: (context, index){
            return _buildPage(index);
          },
          pagination: SwiperPagination(
            margin: new EdgeInsets.all(5.0),
            builder: const DotSwiperPaginationBuilder(
              size: 10.0, activeSize: 15.0, space: 10.0,
              color: Colors.teal,activeColor: Colors.black )),
          control: new SwiperControl(
            iconPrevious: null,
            iconNext: Icons.arrow_forward_ios,
            color: Colors.teal,disableColor: Colors.blueGrey,
            padding: EdgeInsets.only(top:sh*0.9,right: sw*0.05),
          ),
    ))));
  }

  _buildPage(int page){
    switch(page){
      case 0:
        return SlideOne();
      case 1:
        return SlideTwo();
      case 2:
        return SlideThree();
    }
  }
}

//---------------------------------------------------------//
/*

TabBarView(
            children: [
              SlideOne(),
              SlideTwo(),
              SlideThree(),
            ],
            controller: _tabController,
          ),),


bottomNavigationBar: Container(color:Colors.white,child:TabBar(
        unselectedLabelColor: Colors.blueGrey,
        labelColor: Colors.blue,
        tabs: [
          Tab(text:"Step one",icon:Icon(Icons.arrow_forward_ios)),
          Tab(text:"Step two",icon:Icon(Icons.arrow_forward_ios)),
          Tab(text:"Done",icon:Icon(Icons.power_settings_new)),
        ],
        controller: _tabController,
        indicatorColor: Color(0x008080),
        indicatorSize: TabBarIndicatorSize.tab,),
      ),),
*/