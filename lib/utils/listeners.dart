import 'package:flutter/services.dart';

const EventChannel eventChannel = EventChannel("com.auguryapps.magnet");

class EventChannelData {
  final double x;
  final double y;
  final double z;
  EventChannelData(this.x, this.y, this.z);

  @override
  String toString() => "[EventChannelData (x: $x, y: $y, z: $z)]";
}

EventChannelData _listOfValues(List<double> data) {
  return EventChannelData(data[0], data[1], data[2]);
}

Stream<EventChannelData>? _magneticEvent = null;

Stream<EventChannelData>? get eventData {
  if (_magneticEvent == null) {
    _magneticEvent = eventChannel
        .receiveBroadcastStream()
        .map((event) => _listOfValues(event.cast<double>()));
  }
  return _magneticEvent;
}
