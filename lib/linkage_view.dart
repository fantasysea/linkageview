import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef Widget GetHearWidget<M extends BaseItem>(BuildContext context, M item);
typedef Widget GetGeneralItem<M extends BaseItem>(
    BuildContext context, int index, M item);
typedef Widget GetGroupItem<M extends BaseItem>(
    BuildContext context, int index, M item);
typedef void OnGroupItemTap<M extends BaseItem>(
    BuildContext context, int index, M item);

class BaseItem {
  bool isHeader;
  String header;
  bool isSelect;
  String? title;
  dynamic info;
  int index;

  BaseItem({
    this.isHeader = false,
    this.header = "",
    this.isSelect = false,
    this.title,
    this.info,
    this.index = 0,
  });
}

/// 双列表菜单
///
/// itemHeadHeight 是右边列表的高度
/// itemHeight 是没一项的高度
/// items 是列表内容,分head和item
/// itemBuilder是item的builder
/// groupItemBuilder是groupItem的builder
/// headerBuilder是header的builder
/// OnGroupItemTap是点击组的时候返回的回调
/// flexLeft是左边打flex
/// flexRight是右边的flex
/// duration 动画时间
/// isNeedStick 是否需要粘性头
/// curved 动画效果
/// 例子:
///   myBaseItem继承BaseItem
//  class myBaseItem extends BaseItem {
//   myBaseItem({bool isHeader, String header, dynamic info, String title})
//       : super(isHeader: isHeader, header: header, info: info, title: title);
// }
//  myitems = [
// myBaseItem(isHeader: true, header: "水果"),
// myBaseItem(isHeader: false, title: "苹果"),
// myBaseItem(isHeader: false, title: "香蕉"),
// myBaseItem(isHeader: false, title: "西瓜"),
// myBaseItem(isHeader: false, title: "菠萝"),
// myBaseItem(isHeader: false, title: "哈密瓜"),
// myBaseItem(isHeader: false, title: "桃子"),
// myBaseItem(isHeader: true, header: "饮料"),
// myBaseItem(isHeader: false, title: "荔枝"),
// myBaseItem(isHeader: false, title: "火龙果"),
// myBaseItem(isHeader: false, title: "柚子"),
// myBaseItem(isHeader: false, title: "葡萄"),
// myBaseItem(isHeader: false, title: "草莓"),
// myBaseItem(isHeader: false, title: "蓝莓"),
// myBaseItem(isHeader: false, title: "梨子"),
// myBaseItem(isHeader: false, title: "百香果"),
// myBaseItem(isHeader: true, header: "饮料2"),
// myBaseItem(isHeader: false, title: "农夫山泉"),
// myBaseItem(isHeader: false, title: "王老吉"),

// LinkageView<myBaseItem>(
//   items: myitems,
//   itemHeadHeight: 50,
//   itemHeight: 80,
//   itemBuilder: (content, index, item) {
//     if (item.isHeader) {
//       return Container(padding: const EdgeInsets.all(0), color: Colors.grey[100], child: Text(item.header));
//     } else {
//       return Container(padding: const EdgeInsets.all(8), color: Colors.green[100], child: Text(item.title));
//     }
//   },
//   groupItemBuilder: (content, index, item) {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       color: item.isSelect ? Colors.blue[100] : Colors.green[100],
//       child: Text(item.header),
//     );
//   },
//   headerBuilder: (content, item) {
//     return Container(
//       color: Colors.yellow[100],
//       child: new Text(item.header),
//     );
//   },
// ),
/// ```
///
class LinkageView<T extends BaseItem> extends StatefulWidget {
  final double itemHeadHeight;
  final double itemHeight;
  final double itemGroupHeight;

  final List<T> items;
  final GetGroupItem itemBuilder;
  final GetGeneralItem groupItemBuilder;
  final GetHearWidget headerBuilder;
  final OnGroupItemTap onGroupItemTap;
  final int flexLeft;
  final int flexRight;
  final int duration;
  final bool isNeedStick;
  final Curve curve;
  final List<T> groups = [];

  LinkageView(
      {required this.items,
      required this.itemBuilder,
      required this.groupItemBuilder,
      required this.headerBuilder,
      required this.onGroupItemTap,
      this.isNeedStick = true,
      this.curve = Curves.linear,
      this.itemHeadHeight = 30,
      this.itemHeight = 50,
      this.itemGroupHeight = 50,
      required this.duration,
      this.flexLeft = 1,
      this.flexRight = 3}) {
    for (var i = 0; i < items.length; i++) {
      items[i]
        ..index = i
        ..isSelect = false;
      if (items[i].isHeader) {
        groups.add(items[i]);
      }
    }
  }

  @override
  _LinkageViewState createState() => _LinkageViewState();
}

class _LinkageViewState<T extends BaseItem> extends State<LinkageView> {
  bool selected = false;
  int selectIndex = 0;
  bool showTopHeader = false;
  double headerOffset = 0.0;
  BaseItem? headerStr;
  double beforeScroll = 0.0;
  late VoidCallback callback;
  ScrollController scrollController = ScrollController();
  ScrollController groupScrollController = ScrollController();
  late Size? containerSize;
  @override
  void initState() {
    super.initState();
    init();
  }

  void dispose() {
    super.dispose();
    scrollController.removeListener(callback);
  }

  GlobalKey _containerKey = GlobalKey();
  void _onBuildCompleted(Duration timestamp) {
    final RenderBox? containerRenderBox =
        _containerKey.currentContext?.findRenderObject() as RenderBox?;
    if (containerRenderBox != null) {
      setState(() {
        containerSize = containerRenderBox.size;
      });
    }
  }

  Widget groupItem(BuildContext context, int index) {
    BaseItem item = widget.groups[index];
    return GestureDetector(
      onTap: () {
        print("$index tap");
        if (mounted) {
          setState(() {});
          widget.onGroupItemTap(context, index, widget.groups[index]);
          selectIndex = index;
          double tempLength = 0.0;
          for (var i = 0; i < widget.groups[index].index; i++) {
            double currentHeight = widget.items[i].isHeader
                ? widget.itemHeadHeight
                : widget.itemHeight;
            tempLength += currentHeight;
          }
          selected = true;
          scrollController
              .animateTo(tempLength,
                  duration: Duration(milliseconds: widget.duration),
                  curve: Curves.linear)
              .whenComplete(() {
            selected = false;
            print("异步任务处理完成");
          });
        }
      },
      child: Container(
        child: widget.groupItemBuilder(context, index, item),
        height: widget.itemGroupHeight,
      ),
    );
  }

  Widget generalItem(BuildContext context, int index) {
    BaseItem item = widget.items[index];
    if (item.isHeader) {
      return Container(
        child: widget.itemBuilder(context, index, item),
        height: widget.itemHeadHeight,
      );
    } else {
      return Container(
        child: widget.itemBuilder(context, index, item),
        height: widget.itemHeight,
      );
    }
  }

  //初始化控制器和分组
  init() {
    // if (scrollController == null) {
    //   scrollController = ScrollController();
    // }
    // if (groupScrollController == null) {
    //   groupScrollController = ScrollController();
    // }
    headerStr = widget.items.first;
    callback = () {
      double offset2 = scrollController.offset;
      if (offset2 >= 0) {
        if (mounted) {
          setState(() {
            showTopHeader = true;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            showTopHeader = false;
          });
        }
      }
      //计算滑动了多少距离了
      double pixels = scrollController.position.pixels;
      // print("pixels is $pixels");
      double tempLength = 0.0;
      int position = 0;
      double offset;
      double currentHeight = 0;

      for (var i = 0; i < widget.items.length; i++) {
        currentHeight = widget.items[i].isHeader
            ? widget.itemHeadHeight
            : widget.itemHeight;
        tempLength += currentHeight;
        if (widget.items[i].isHeader) {
          headerStr?.isSelect = false;
          headerStr = widget.items[i];
          headerStr?.isSelect = true;
        }
        //滚动的大小没有超过最大的item index,那么当前地一个item的下标就是index
        if (tempLength >= pixels) {
          position = i;
          break;
        }
      }
      if (widget.items[position + 1].isHeader) {
        //如果下一个是header,又刚刚滚定到临界点,那么group往下一个
        if (tempLength == pixels) {
          headerStr?.isSelect = false;
          headerStr = widget.items[position + 1];
          headerStr?.isSelect = true;
        }
        if (mounted) {
          setState(() {
            offset = currentHeight - (tempLength - pixels);
            if (offset - (widget.itemHeight - widget.itemHeadHeight) >= 0) {
              headerOffset =
                  -(offset - (widget.itemHeight - widget.itemHeadHeight));
            }
          });
        }
      } else {
        if (headerOffset != 0) {
          if (mounted) {
            setState(() {
              headerOffset = 0.0;
            });
          }
        }
      }
      // if (!selected) {
      resetGroupPosition();
      // }
    };
    headerStr?.isSelect = true;

    scrollController.addListener(callback);
  }

  resetGroupPosition() {
    if (containerSize != null) {
      int index = 0;
      if (!selected) {
        for (var i = 0; i < widget.groups.length; i++) {
          if (headerStr == widget.groups[i]) {
            index = i;
          }
        }
      } else {
        index = selectIndex;
      }

      double currentLength = widget.itemGroupHeight * (index + 1);
      double offset = 0;

      if (currentLength > containerSize!.height / 2 &&
          widget.groups.length * widget.itemGroupHeight >
              containerSize!.height) {
        offset = ((currentLength - containerSize!.height / 2) /
                widget.itemGroupHeight.round()) *
            widget.itemGroupHeight;
        if (offset + containerSize!.height >
            widget.groups.length * widget.itemGroupHeight) {
          offset = widget.groups.length * widget.itemGroupHeight -
              containerSize!.height;
        }
        groupScrollController.animateTo(offset,
            duration: Duration(milliseconds: widget.duration),
            curve: Curves.linear);
      }

      // if ((currentLength - (widget.itemGroupHeight / 2)) >= containerSize.height / 2 &&
      //     widget.groups.length * widget.itemGroupHeight > containerSize.height) {
      //   // offset = (currentLength - (widget.itemGroupHeight / 2)) - containerSize.height / 2;
      //   if (offset + containerSize.height > widget.groups.length * widget.itemGroupHeight) {
      //     offset = widget.groups.length * widget.itemGroupHeight - containerSize.height;
      //   }

      //   groupScrollController.animateTo(offset, duration: Duration(milliseconds: widget.duration), curve: Curves.ease);
      // }
      if (currentLength <= containerSize!.height / 2 &&
          offset < widget.itemGroupHeight) {
        offset = 0;
        groupScrollController.animateTo(offset,
            duration: Duration(milliseconds: widget.duration),
            curve: Curves.linear);
      }
      print(
          "currentLength is $currentLength offset is $offset   ${(currentLength - (widget.itemGroupHeight / 2))} ${containerSize!.height / 2}");
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(_onBuildCompleted);

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Row(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              key: _containerKey,
              padding: EdgeInsets.all(0),
              controller: groupScrollController,
              physics: BouncingScrollPhysics(),
              itemCount: widget.groups.length,
              itemBuilder: (BuildContext context, int index) {
                return groupItem(context, index);
              },
              // separatorBuilder: (context, index) {
              //   return Divider(
              //     height: .5,
              //     indent: 0,
              //     color: Color(0xFFDDDDDD),
              //   );
              // },
            ),
            flex: widget.flexLeft,
          ),
          Expanded(
            child: Stack(children: [
              ListView.builder(
                padding: EdgeInsets.all(0),
                controller: scrollController,
                physics: BouncingScrollPhysics(),
                itemCount: widget.items.length,
                itemBuilder: (BuildContext context, int index) {
                  return generalItem(context, index);
                },
                // separatorBuilder: (context, index) {
                //   return Divider(
                //     height: .1,
                //     indent: 0,
                //     color: Color(0xFFDDDDDD),
                //   );
                // },
              ),
              Visibility(
                visible: widget.isNeedStick ? showTopHeader : false,
                child: Container(
                  transform: Matrix4.translationValues(0.0, headerOffset, 0.0),
                  width: double.infinity,
                  height: widget.itemHeadHeight,
                  child: widget.headerBuilder(context, headerStr!),
                ),
              )
            ]),
            flex: widget.flexRight,
          ),
        ],
      ),
    );
  }
}
