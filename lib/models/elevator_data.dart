const bool _maintenance = true;
const bool _status = true;
const bool _isMoving = false;

class ElevatorData {
  ElevatorData({
    required this.id,
    required this.speed,
    required this.temperature,
    required this.floor,
    this.isMove = _isMoving,
    this.maintenance = _maintenance,
    this.status = _status,
    required this.dateTime,
  });

  /// Elevator id.
  /// Every elevator must have different id.
  final String id;

  /// Elevator if it is moving,speed.
  final double speed;

  /// Elevator engine temperature.
  final double temperature;

  /// Floor information about elevator.
  /// remotely switchable
  final int floor;

  /// Elevator if it is moving
  ///
  /// default value [false].
  final bool? isMove;

  /// Elevator maintance
  ///
  /// Every month renewal status
  /// If other month it is not refreshed which will get [true] value
  final bool? maintenance;

  /// Working status of the elevator.
  /// Returns false if it is under maintenance or malfunctioning.
  /// Default value [true].
  final bool? status;

  /// The date the data was sent
  final DateTime dateTime;

  /// If the data does not change, mqtt should not send
  @override
  int get hashCode =>
      id.hashCode ^
      speed.hashCode ^
      temperature.hashCode ^
      floor.hashCode ^
      isMove.hashCode ^
      maintenance.hashCode ^
      status.hashCode ^
      dateTime.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ElevatorData) &&
          id == other.id &&
          speed == other.speed &&
          temperature == other.temperature &&
          floor == other.floor &&
          isMove == other.isMove &&
          maintenance == other.maintenance &&
          status == other.status &&
          dateTime == other.dateTime;

  /// Parse from Json.
  factory ElevatorData.fromJson(Map<String, dynamic> json) {
    return ElevatorData(
      id: json['imei'] as String? ?? '',
      speed: json['speed'] as double? ?? 0.0,
      temperature: json['temperature'] as double? ?? 0.0,
      floor: json['floor'] as int? ?? 0,
      isMove: json['isMove'] as bool? ?? false,
      maintenance: json['maintenance'] as bool? ?? false,
      status: json['status'] as bool? ?? false,
      dateTime: json['dateTime'] as DateTime? ?? DateTime.now(),
    );
  }

  /// To Json Format.
  Map<String, dynamic> toJson() => {
        'imei': id,
        'speed': speed,
        'temperature': temperature,
        'floor': floor,
        'isMove': isMove,
        'maintenance': maintenance,
        'status': status,
        'dateTime': dateTime,
      };
}
