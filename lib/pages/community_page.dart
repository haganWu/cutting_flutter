import 'package:flutter/material.dart';

/// 社区页面
class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('社区页面', style: TextStyle(fontSize: 30, color: Colors.blue)),
      ),
    );
  }
}
