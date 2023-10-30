import 'dart:async';

import 'package:cutting_flutter/extension/padding_extension.dart';
import 'package:cutting_flutter/models/bluetooth_device_model.dart';
import 'package:cutting_flutter/utils/hi_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import '../utils/hi_logger.dart';

/// 首页
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FlutterBluePlus flutterBluePlus = FlutterBluePlus();
  List<BluetoothDeviceModel> scanResultList = [];

  @override
  void initState() {
    super.initState();
    FlutterBluePlus.scanResults.listen((List<ScanResult> resultList) {
      HiLogger.log(message: '----------------------监听扫描结果--------------------------------------');
      for (var result in resultList) {
        if (result.advertisementData.localName.isNotEmpty) {
          HiLogger.log(message: '扫描结果-设备名称：${result.advertisementData.localName}');
          BluetoothDeviceModel model = BluetoothDeviceModel(
              deviceId: result.device.remoteId.toString(), deviceName: result.advertisementData.localName);
          if (!scanResultList.contains(model)) {
            setState(() {
              scanResultList.add(model);
            });
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 12, top: 36, right: 12, bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('测试切割', style: TextStyle(fontSize: 16, color: Colors.blue), textAlign: TextAlign.center),
                _sendBtn()
              ],
            ),
            30.paddingHeight,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StreamBuilder<BluetoothAdapterState>(
                  stream: FlutterBluePlus.adapterState,
                  initialData: BluetoothAdapterState.unknown,
                  builder: (c, snapshot) {
                    final adapterState = snapshot.data;
                    HiLogger.log(message: 'adapterState"$adapterState');
                    if (adapterState == BluetoothAdapterState.on) {
                      return genItem(context, Icons.bluetooth, '蓝牙', onBluetoothClick, Colors.blue);
                    } else {
                      return genItem(context, Icons.bluetooth, '蓝牙', onBluetoothClick, Colors.grey);
                    }
                  },
                ),
                genItem(context, Icons.hourglass_empty_outlined, '进纸', onPaperInClick, Colors.blue),
                genItem(context, Icons.hourglass_empty_outlined, '退纸', onPaperOutClick, Colors.blue),
                genItem(context, Icons.hourglass_empty_outlined, '刀压', onKnifePressClick, Colors.blue),
                // scanResultList()
              ],
            ),
            30.paddingHeight,
            Expanded(
                child: ListView.builder(
              // 解决ListView数据量较少时无法滑动问题
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true, // 使用shrinkWrap属性
              itemCount: scanResultList.length,
              itemBuilder: (BuildContext ancestor, int index) => _scanResultItemWidget(index),
            ))
          ],
        ),
      ),
    );
  }

  get _sendBtn => () {
        return Container(
          margin: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(6),
          ),
          padding: const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
          child: InkWell(
            onTap: _onSend,
            child: const Text('发送', style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
        );
      };

  void _onSend() {
    HiLogger.log(message: '点击发送');
  }

  genItem(BuildContext context, IconData icon, String text, Function onClick, Color color) {
    return InkWell(
      onTap: () {
        if (color == Colors.grey) {
          HiDialog.showSnackBar(context, "请打开蓝牙");
          return;
        }
        onClick();
      },
      child: Column(
        children: [
          Icon(icon, color: color),
          Text(
            text,
            style: const TextStyle(color: Colors.grey, fontSize: 16),
          )
        ],
      ),
    );
  }

  onBluetoothClick() {
    HiLogger.log(message: '点击蓝牙');
    setState(() {
      scanResultList.clear();
    });
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 15), androidUsesFineLocation: false);
  }

  onPaperInClick() {
    HiLogger.log(message: '点击进纸');
  }

  onPaperOutClick() {
    HiLogger.log(message: '点击退纸');
  }

  onKnifePressClick() {
    HiLogger.log(message: '点击刀压');
  }

  _scanResultItemWidget(int index) {
    return Card(
      margin: const EdgeInsets.only(left: 2, top: 4, right: 2, bottom: 4),
      elevation: 10.0,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 6, right: 10, bottom: 6),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("设备ID ------ ${scanResultList[index].deviceId}",
              style: const TextStyle(fontSize: 16, color: Colors.green)),
          6.paddingHeight,
          Text("设备名称 ------ ${scanResultList[index].deviceName ?? ""}",
              style: const TextStyle(fontSize: 16, color: Colors.red)),
        ]),
      ),
    );
  }

// scanResultList() {
//   return SingleChildScrollView(
//     child: Column(
//       children: <Widget>[
//         StreamBuilder<List<ScanResult>>(
//           stream: FlutterBluePlus.scanResults,
//           builder: (c, snapshot){
//             HiLogger.log(message: '扫描结果:${snapshot.data}');
//             return Column(
//               // children: (snapshot.data ?? []).map((r) => scanResultItem(r)).toList(),
//             );
//           },
//         )
//       ],
//     ),
//   );
// }

// scanResultItem(ScanResult r) {
//   return Column(
//     children: [],
//   );
// }
}
