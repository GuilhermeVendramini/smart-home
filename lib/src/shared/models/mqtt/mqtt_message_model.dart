import 'package:mqtt_client/mqtt_client.dart' as mqtt;

class MqttMessageModel {
  final String topic;
  final String message;
  final mqtt.MqttQos qos;

  MqttMessageModel({this.topic, this.message, this.qos});
}
