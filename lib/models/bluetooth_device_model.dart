class BluetoothDeviceModel {
  late String deviceId;
  String? deviceName;

  BluetoothDeviceModel({required this.deviceId, this.deviceName});

  @override
  bool operator ==(other) {
    return (other is BluetoothDeviceModel) && (other.deviceId == deviceId);
  }

  @override
  int get hashCode => deviceId.hashCode;

  BluetoothDeviceModel.fromJson(Map<String, dynamic> json) {
    deviceId = json['deviceId'];
    deviceName = json['deviceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deviceId'] = deviceId;
    data['deviceName'] = deviceName;
    return data;
  }


}
