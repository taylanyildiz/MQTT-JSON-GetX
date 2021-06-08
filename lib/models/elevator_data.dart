const bool _maintenance = true;
const bool _status = true;
const bool _isMoving = false;

class ElevatorData {
  ElevatorData({
    required this.imei,
    required this.id,
    required this.speed,
    required this.temperature,
    required this.floor,
    this.isMove = _isMoving,
    this.maintenance = _maintenance,
    this.status = _status,
    required this.dateTime,
  });

  /// Every electronic device use TCP/IP.
  final String imei;

  /// Elevator id.
  /// Every elevator must have different id.
  /// The sent message id is different from the received message id.
  /// We use them for controller elevator calling floor.
  final String id;

  /// Elevator if it is moving,speed.
  final double speed;

  /// Elevator engine temperature.
  final double temperature;

  /// Floor information about elevator.
  /// remotely switchable
  int floor;

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
  final String dateTime;

  /// Parse from Json.
  factory ElevatorData.fromJson(Map<String, dynamic> json) {
    return ElevatorData(
      imei: json['imei'] as String? ?? 'error-imei',
      id: json['id'] as String? ?? 'error-id',
      speed: json['speed'] as double? ?? 0.0,
      temperature: json['temperature'] as double? ?? 0.0,
      floor: json['floor'] as int? ?? 0,
      isMove: json['isMove'] as bool? ?? false,
      maintenance: json['maintenance'] as bool? ?? false,
      status: json['status'] as bool? ?? false,
      dateTime: json['dateTime'] as String? ?? 'error-date',
    );
  }

  /// To Json Format.
  Map<String, dynamic> toJson() => {
        'imei': imei,
        'id': id,
        'speed': speed,
        'temperature': temperature,
        'floor': floor,
        'isMove': isMove,
        'maintenance': maintenance,
        'status': status,
        'dateTime': dateTime,
      };
}
