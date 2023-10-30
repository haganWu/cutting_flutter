import 'dart:async';

import 'package:cutting_flutter/extension/padding_extension.dart';
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

  // bool isBlueOn = false;

  @override
  void initState() {
    super.initState();
    // isBlueOn = false;
    // FlutterBluePlus.adapterState.listen((event) {
    //   HiLogger.log(message: '蓝牙状态改变');
    //   if (event == BluetoothAdapterState.on) {
    //     HiLogger.log(message: '蓝牙已打开');
    //     setState(() {
    //       isBlueOn = true;
    //     });
    //   } else {
    //     HiLogger.log(message: '蓝牙已关闭');
    //     setState(() {
    //       isBlueOn = false;
    //     });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:
            const EdgeInsets.only(left: 12, top: 36, right: 12, bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('测试切割',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                    textAlign: TextAlign.center),
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
                      return genItem(
                          Icons.bluetooth, '蓝牙', onBluetoothClick, Colors.blue);
                    } else {
                      FlutterBluePlus.stopScan();
                      return genItem(
                          Icons.bluetooth, '蓝牙', onBluetoothClick, Colors.grey);
                    }
                  },
                ),
                // genItem(Icons.bluetooth, '蓝牙', onBluetoothClick,
                //     isBlueOn ? Colors.blue : Colors.grey),
                genItem(Icons.hourglass_empty_outlined, '进纸', onPaperInClick,
                    Colors.blue),
                genItem(Icons.hourglass_empty_outlined, '退纸', onPaperOutClick,
                    Colors.blue),
                genItem(Icons.hourglass_empty_outlined, '刀压', onKnifePressClick,
                    Colors.blue),
              ],
            )
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
          padding:
              const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
          child: InkWell(
            onTap: _onSend,
            child: const Text('发送',
                style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
        );
      };

  void _onSend() {
    HiLogger.log(message: '点击发送');
  }

  genItem(IconData icon, String text, Function onClick, Color color) {
    return InkWell(
      onTap: () {
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
}
