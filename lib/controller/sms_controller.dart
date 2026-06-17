import 'package:echallan/model/twillo_model.dart';

class SmsController {
  final TwilioService _twilioService = TwilioService();

  Future<void> sendSmsToUser(String phoneNumber, String message) async {
    try {
      await _twilioService.sendSms(phoneNumber, message);
      print("Message sent to $phoneNumber");
    } catch (e) {
      print("Error sending message to $phoneNumber: $e");
    }
  }
}
