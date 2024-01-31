abstract class NotificationDb {}

class NotificationDbFunctions extends NotificationDb {
  NotificationDbFunctions._internal();
  static NotificationDbFunctions instance = NotificationDbFunctions._internal();
  factory NotificationDbFunctions() {
    return instance;
  }
}
