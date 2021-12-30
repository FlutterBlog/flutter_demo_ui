library flutter_picker;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// 选择时间
/// void showActionPicker() {
///  List dataList = [
///     {
///       'value': '2020',
///       'children': [
///         {
///           'value': '1',
///           'children': ['12:00', '13:00', '14:00']
///         },
///         {
///           'value': '2',
///           'children': ['12:00', '13:00', '14:00']
///         },
///         {
///           'value': '3',
///           'children': ['12:00', '13:00', '14:00']
///         }
///       ]
///     },
///     {
///       'value': '2021',
///       'children': [
///         {
///           'value': '3',
///           'children': ['9:00', '10:00', '14:00']
///         },
///         {
///           'value': '4',
///           'children': ['12:00', '17:00', '18:00']
///         },
///         {
///           'value': '5',
///           'children': ['14:00', '15:00', '16:00']
///         }
///       ]
///     }
///   ];
///
///   FlutterPicker.showPicker(
///     context: context,
///     data: dataList,
///     currentData: ['2021', '4', '17:00'],
///     onConfirm: (List<String> selectedData) {
///        print('当前值：$value, 第一个：$firstIndex, 第二个：$secondIndex, 第三个：$thirdIndex');
///     },
///   );
/// }

///数据更改回调
typedef DataChangeCallback(
    List<String> selectedData, int firstIndex, int secondIndex, int thirdIndex);

///value 解析标示
final String kValue = 'value';

///孩子解析标示
final String kChildren = 'children';

class FlutterPicker {
  static void showPicker({
    required BuildContext context,
    required List data,
    required List<String> currentData,
    required DataChangeCallback onConfirm,
    TextStyle? cancelStyle,
    TextStyle? confirmStyle,
    TextStyle? titleStyle,
    String cancelText: '取消',
    String confirmText: '确认',
    String titleText: '',
  }) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(8),
          ),
        ),
        builder: (BuildContext context) {
          return PickerSheet(
            data: data,
            currentData: currentData,
            onConfirm: onConfirm,
            cancelStyle: cancelStyle,
            confirmStyle: confirmStyle,
            titleStyle: titleStyle,
            cancelText: cancelText,
            confirmText: confirmText,
            titleText: titleText,
          );
        });
  }
}

///自定义底部面板
class PickerSheet extends StatefulWidget {
  final List data;
  final List<String> currentData;
  final DataChangeCallback onConfirm;

  final String? cancelText;
  final String? confirmText;
  final String? titleText;

  final TextStyle? cancelStyle;
  final TextStyle? confirmStyle;
  final TextStyle? titleStyle;

  PickerSheet({
    required this.data,
    required this.currentData,
    required this.onConfirm,
    this.cancelStyle,
    this.confirmStyle,
    this.titleStyle,
    this.cancelText,
    this.confirmText,
    this.titleText,
  })  : assert(data != null),
        assert(onConfirm != null);

  @override
  State<StatefulWidget> createState() =>
      _PickerSheetState(this.data, this.currentData);
}

class _PickerSheetState extends State<PickerSheet> {
  ///数据集合
  late List data1, data2, data3 = [];

  ///控制器
  late FixedExtentScrollController _controller1, _controller2, _controller3;

  ///索引
  int firstIndex = 0;
  int secondIndex = 0;
  int thirdIndex = 0;

  _PickerSheetState(List data, List<String> currentData) {
    data1 = data;

    ///获取数据一
    firstIndex = data1.indexWhere((item) => item[kValue] == currentData[0]);
    _controller1 = FixedExtentScrollController(initialItem: firstIndex);

    ///获取数据二
    data2 = data1[firstIndex][kChildren];
    secondIndex = data2.indexWhere((item) => item[kValue] == currentData[1]);
    _controller2 = FixedExtentScrollController(initialItem: secondIndex);

    ///获取数据三
    data3 = data2[secondIndex][kChildren];
    thirdIndex = data3.indexOf(currentData[2]);
    _controller3 = FixedExtentScrollController(initialItem: thirdIndex);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return sheetScaffold(<Widget>[
      ///Title 操作栏
      Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MaterialButton(
              child: Text(
                widget.cancelText ?? "取消",
                style: widget.cancelStyle ?? Theme.of(context).textTheme.button,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Text(
              widget.titleText ?? "",
              style: widget.titleStyle ?? Theme.of(context).textTheme.subtitle1,
            ),
            MaterialButton(
              child: Text(
                widget.confirmText ?? "确认",
                style: widget.confirmStyle ??
                    TextStyle(color: Theme.of(context).primaryColor),
              ),
              onPressed: () {
                if (widget.onConfirm != null) {
                  Navigator.of(context).pop();
                  List<String> confirmData = [];
                  confirmData.add(data1[_controller1.selectedItem][kValue]);
                  confirmData.add(data2[_controller2.selectedItem][kValue]);
                  confirmData.add(data3[_controller3.selectedItem]);
                  widget.onConfirm(confirmData, _controller1.selectedItem,
                      _controller2.selectedItem, _controller3.selectedItem);
                }
              },
            )
          ],
        ),
      ),
      Row(
        children: [
          _buildCupertinoPicker(data1, (index) {
            setState(() {
              data2 = data1[index][kChildren];
              _controller2.jumpToItem(0);
              _controller3.jumpToItem(0);
              firstIndex = index;
              secondIndex = 0;
              thirdIndex = 0;
              print("firstIndex:$index");
            });
          }, _controller1, 1),
          _buildCupertinoPicker(data2, (index) {
            setState(() {
              data3 = data2[index][kChildren];
              _controller3.jumpToItem(0);
              secondIndex = index;
              thirdIndex = 0;
              print("secondIndex:$secondIndex");
            });
          }, _controller2, 2),
          _buildCupertinoPicker(data3, (index) {
            thirdIndex = index;
            setState(() {});
            print("thirdIndex:$thirdIndex");
          }, _controller3, 3),
        ],
      ),
    ]);
  }

  ///构建地区展示
  Widget _buildCupertinoPicker(
      dynamic itemData,
      ValueChanged<int> onSelectedItemChanged,
      FixedExtentScrollController controller,
      int which) {
    return Expanded(
      flex: 1,
      child: SizedBox(
        height: 216,
        child: CupertinoPicker.builder(
          itemExtent: 48,
          backgroundColor: Colors.transparent,
          scrollController: controller,
          onSelectedItemChanged: onSelectedItemChanged,
          itemBuilder: (context, index) {
            var label = itemData[index];
            if (label is Map) {
              label = label[kValue];
            }
            return Container(
              height: 48,
              color: Colors.transparent,
              alignment: Alignment.center,
              child: Text(
                '$label',
                style: getTextStyle(index, which),
              ),
            );
          },
          childCount: itemData?.length ?? 0,
        ),
      ),
    );
  }

  TextStyle getTextStyle(int index, int which) {
    print("thirdIndex:$thirdIndex,index：$index,which:$which");
    if (which == 1 && firstIndex == index) {
      return TextStyle(
          fontSize: 14, color: Colors.black26, fontWeight: FontWeight.bold);
    } else if (which == 2 && secondIndex == index) {
      return TextStyle(
          fontSize: 14, color: Colors.black26, fontWeight: FontWeight.bold);
    } else if (which == 3 && thirdIndex == index) {
      return TextStyle(
          fontSize: 14, color: Colors.black26, fontWeight: FontWeight.bold);
    } else {
      return TextStyle(fontSize: 14, color: Colors.grey);
    }
  }

  ///面板脚手架
  Widget sheetScaffold(List<Widget> children) {
    return SafeArea(
      top: false,
      bottom: true,
      left: false,
      right: false,
      child: IntrinsicHeight(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }
}
