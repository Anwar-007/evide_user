class LiveLocation {
  final String liveTime;
  final double latitude;
  final double longitude;
  final String timestamp;

  LiveLocation({
    required this.liveTime,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  // Convert JSON to LiveLocation
  factory LiveLocation.fromJson(Map<String, dynamic> json) {
    return LiveLocation(
      liveTime: json['LiveTime'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      timestamp: json['timestamp'],
    );
  }

  // Convert LiveLocation to JSON
  Map<String, dynamic> toJson() {
    return {
      'LiveTime': liveTime,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp,
    };
  }
}
class BusStop {
  final int timedifference;
  final double latitude;
  final double longitude;
  final String stopTime;
  final String stopname;

  BusStop({
    required this.timedifference,
    required this.latitude,
    required this.longitude,
    required this.stopTime,
    required this.stopname,
  });

  // Convert JSON to BusStop
  factory BusStop.fromJson(Map<String, dynamic> json) {
    return BusStop(
      timedifference: json['timedifference'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      stopTime: json['stopTime'],
      stopname: json['stopname'],
    );
  }

  // Convert BusStop to JSON
  Map<String, dynamic> toJson() {
    return {
      'timedifference': timedifference,
      'latitude': latitude,
      'longitude': longitude,
      'stopTime': stopTime,
      'stopname': stopname,
    };
  }
}
