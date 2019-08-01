import 'package:flutter/material.dart';

import 'indicator.dart';
import 'shape.dart';

enum IndicatorAlign {
  top,
  center,
  bottom,
}

class PageIndicatorContainer extends StatefulWidget {
  final PageView pageView;

  final int length;

  final EdgeInsets padding;

  final IndicatorAlign align;

  final IndicatorShape shape;

  final Color indicatorColor;

  final Color indicatorSelectorColor;

  final double indicatorSpace;

  const PageIndicatorContainer({
    Key key,
    @required this.pageView,
    @required this.length,
    this.padding = const EdgeInsets.only(bottom: 10.0, top: 10.0),
    this.align = IndicatorAlign.bottom,
    this.indicatorColor = Colors.white,
    this.indicatorSelectorColor = Colors.grey,
    this.indicatorSpace = 8.0,
    this.shape = IndicatorShape.defaultCircle,
  }) : super(key: key);

  @override
  PageContainerState createState() => PageContainerState();
}

class PageContainerState extends State<PageIndicatorContainer> {
  @override
  Widget build(BuildContext context) {
    var controller = pageView.controller;
    double height = widget.shape.height;
    Widget indicator = PageIndicator(
      controller: controller,
      length: widget.length,
      color: widget.indicatorColor,
      selectedColor: widget.indicatorSelectorColor,
      indicatorSpace: widget.indicatorSpace,
      indicatorShape: widget.shape,
      align: widget.align,
    );

    var align = widget.align;

    if (align == IndicatorAlign.bottom) {
      indicator = Positioned(
        left: 0.0,
        right: 0.0,
        bottom: widget.padding.bottom,
        height: height,
        child: indicator,
      );
    } else if (align == IndicatorAlign.top) {
      indicator = Positioned(
        left: 0.0,
        right: 0.0,
        top: widget.padding.top,
        height: height,
        child: indicator,
      );
    } else if (align == IndicatorAlign.center) {
      indicator = Center(
        child: Container(
          child: indicator,
          height: height,
        ),
      );
    }

    return Stack(
      children: <Widget>[
        NotificationListener<ScrollNotification>(
          child: pageView,
          onNotification: _onScroll,
        ),
        indicator,
      ],
    );
  }

  PageView get pageView => widget.pageView;

  bool _onScroll(ScrollNotification notification) {
    setState(() {});
    return false;
  }

  void forceRefreshState() {
    this.setState(() {});
  }
}
