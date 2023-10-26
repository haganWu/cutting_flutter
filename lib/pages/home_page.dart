import 'package:cutting_flutter/extension/padding_extension.dart';
import 'package:flutter/material.dart';
import '../utils/hi_logger.dart';

/// 首页
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // FlutterBlue flutterBlue = FlutterBlue.instance;
  // BluetoothDevice selectedDevice;
  // bool isTransferring = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 12, top: 30, right: 12, bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text('测试切割', style: TextStyle(fontSize: 16, color: Colors.blue), textAlign: TextAlign.center), _sendBtn()],
            ),
            30.paddingHeight,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                genItem(Icons.bluetooth, '蓝牙', onBluetoothClick),
                genItem(Icons.hourglass_empty_outlined, '进纸', onPaperInClick),
                genItem(Icons.hourglass_empty_outlined, '退纸', onPaperOutClick),
                genItem(Icons.hourglass_empty_outlined, '刀压', onKnifePressClick),
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

  genItem(IconData icon, String text, Function onClick) {
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Column(
        children: [
          Icon(icon, color: Colors.grey,),
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
