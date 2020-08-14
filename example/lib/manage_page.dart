import 'package:flutter/material.dart';
import 'package:linkageview/linkage_view.dart';

/// 经营
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class MyBaseItem extends BaseItem {
  String image;
  MyBaseItem({bool isHeader, String header, dynamic info, String title, this.image})
      : super(isHeader: isHeader, header: header, info: info, title: title);
}

class _HomePageState extends State<HomePage> {
  List<MyBaseItem> myitems;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myitems = [
      MyBaseItem(isHeader: true, header: "水果"),
      MyBaseItem(
          isHeader: false,
          title: "苹果",
          image:
              "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597386020912&di=96e7b17bd4468137170a45d1eaba4223&imgtype=0&src=http%3A%2F%2Fmpic.tiankong.com%2F30d%2F57a%2F30d57aef9e1eea1910a4fbdadfd0d03c%2F640.jpg"),
      MyBaseItem(
          isHeader: false,
          title: "香蕉",
          image: "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1121089958,3018372729&fm=26&gp=0.jpg"),
      MyBaseItem(
          isHeader: false,
          title: "西瓜",
          image:
              "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597386215674&di=210b776d8ab10158649695115ab082ba&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fq_70%2Cc_zoom%2Cw_640%2Fimages%2F20180524%2F95e445560f9c4f5494aa0a304635ffce.jpeg"),
      MyBaseItem(isHeader: false, title: "菠萝"),
      MyBaseItem(isHeader: true, header: "水果2"),
      MyBaseItem(isHeader: false, title: "苹果"),
      MyBaseItem(isHeader: false, title: "香蕉"),
      MyBaseItem(isHeader: false, title: "西瓜"),
      MyBaseItem(isHeader: false, title: "菠萝"),
      MyBaseItem(isHeader: false, title: "哈密瓜"),
      MyBaseItem(isHeader: false, title: "桃子"),
      MyBaseItem(isHeader: true, header: "水果3"),
      MyBaseItem(isHeader: false, title: "龙眼"),
      MyBaseItem(isHeader: false, title: "荔枝"),
      MyBaseItem(isHeader: false, title: "火龙果"),
      MyBaseItem(isHeader: false, title: "柚子"),
      MyBaseItem(isHeader: false, title: "葡萄"),
      MyBaseItem(isHeader: false, title: "草莓"),
      MyBaseItem(isHeader: false, title: "蓝莓"),
      MyBaseItem(isHeader: false, title: "梨子"),
      MyBaseItem(isHeader: false, title: "百香果"),
      MyBaseItem(isHeader: true, header: "饮料"),
      MyBaseItem(isHeader: false, title: "农夫山泉"),
      MyBaseItem(isHeader: false, title: "王老吉"),
      MyBaseItem(isHeader: false, title: "加多宝"),
      MyBaseItem(isHeader: false, title: "农夫山泉"),
      MyBaseItem(isHeader: false, title: "王老吉"),
      MyBaseItem(isHeader: false, title: "加多宝"),
      MyBaseItem(isHeader: false, title: "农夫山泉"),
      MyBaseItem(isHeader: false, title: "王老吉"),
      MyBaseItem(isHeader: false, title: "加多宝"),
      MyBaseItem(isHeader: false, title: "农夫山泉"),
      MyBaseItem(isHeader: false, title: "王老吉"),
      MyBaseItem(isHeader: false, title: "加多宝"),
      MyBaseItem(isHeader: true, header: "饮料0"),
      MyBaseItem(isHeader: false, title: "茶派"),
      MyBaseItem(isHeader: false, title: "公牛"),
      MyBaseItem(isHeader: false, title: "东鹏特饮"),
      MyBaseItem(isHeader: false, title: "矿泉水"),
      MyBaseItem(isHeader: false, title: "奶茶"),
      MyBaseItem(isHeader: false, title: "椰汁"),
      MyBaseItem(isHeader: false, title: "柠檬茶"),
      MyBaseItem(isHeader: false, title: "AD钙奶"),
      MyBaseItem(isHeader: true, header: "饮料2"),
      MyBaseItem(isHeader: false, title: "农夫山泉"),
      MyBaseItem(isHeader: false, title: "王老吉"),
      MyBaseItem(isHeader: false, title: "加多宝"),
      MyBaseItem(isHeader: false, title: "茶派"),
      MyBaseItem(isHeader: false, title: "公牛"),
      MyBaseItem(isHeader: false, title: "东鹏特饮"),
      MyBaseItem(isHeader: false, title: "矿泉水"),
      MyBaseItem(isHeader: false, title: "奶茶"),
      MyBaseItem(isHeader: false, title: "椰汁"),
      MyBaseItem(isHeader: false, title: "柠檬茶"),
      MyBaseItem(isHeader: false, title: "AD钙奶"),
      MyBaseItem(isHeader: true, header: "饮料3"),
      MyBaseItem(isHeader: false, title: "农夫山泉"),
      MyBaseItem(isHeader: false, title: "王老吉"),
      MyBaseItem(isHeader: false, title: "加多宝"),
      MyBaseItem(isHeader: false, title: "茶派"),
      MyBaseItem(isHeader: false, title: "公牛"),
      MyBaseItem(isHeader: true, header: "饮料4"),
      MyBaseItem(isHeader: false, title: "东鹏特饮"),
      MyBaseItem(isHeader: false, title: "矿泉水"),
      MyBaseItem(isHeader: false, title: "奶茶"),
      MyBaseItem(isHeader: false, title: "椰汁"),
      MyBaseItem(isHeader: false, title: "柠檬茶"),
      MyBaseItem(isHeader: false, title: "AD钙奶"),
      MyBaseItem(isHeader: true, header: "饮料5"),
      MyBaseItem(isHeader: false, title: "东鹏特饮"),
      MyBaseItem(isHeader: false, title: "矿泉水"),
      MyBaseItem(isHeader: false, title: "奶茶"),
      MyBaseItem(isHeader: false, title: "椰汁"),
      MyBaseItem(isHeader: false, title: "柠檬茶"),
      MyBaseItem(isHeader: false, title: "AD钙奶"),
      MyBaseItem(isHeader: true, header: "饮料6"),
      MyBaseItem(isHeader: false, title: "东鹏特饮"),
      MyBaseItem(isHeader: false, title: "矿泉水"),
      MyBaseItem(isHeader: false, title: "奶茶"),
      MyBaseItem(isHeader: false, title: "椰汁"),
      MyBaseItem(isHeader: false, title: "柠檬茶"),
      MyBaseItem(isHeader: false, title: "AD钙奶"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("经营"),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: LinkageView<MyBaseItem>(
            items: myitems,
            duration: 500,
            isNeedStick: true,
            itemHeadHeight: 50,
            itemHeight: 80,
            itemBuilder: (content, index, item) {
              if ((item as MyBaseItem).image == null) {
                (item as MyBaseItem).image =
                    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597386475752&di=da878b9ce8846a1a70f36064bca8ce25&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20181113%2Fa6a61fbc0cff4c15bf33453185dd81cc.jpg";
              }
              if (item.isHeader) {
                return Container(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(0),
                    color: Colors.white,
                    child: Text(item.header),
                  ),
                );
              } else {
                return Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(8),
                    color: Colors.white,
                    child: Row(
                        children: [Image.network((item as MyBaseItem).image), SizedBox(width: 10), Text(item.title)]));
              }
            },
            groupItemBuilder: (content, index, item) {
              return Container(
                height: 50,
                padding: const EdgeInsets.all(8),
                color: item.isSelect ? Colors.white : Colors.grey[200],
                child: Text(item.header),
              );
            },
            onGroupItemTap: (content, index, item) {
              print("tab is ${item.header} click");
            },
            headerBuilder: (content, item) {
              return Container(
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(0),
                  color: Colors.white,
                  child: Text(item.header),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
