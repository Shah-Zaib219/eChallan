import 'package:twilio_flutter/twilio_flutter.dart';

class TwilioService {
  late TwilioFlutter twilioFlutter;

  TwilioService() {
    twilioFlutter = TwilioFlutter(
      accountSid:
          'AC50764a4eb6694142b84a0e295cc7c10f', // Replace with your Account SID
      authToken:
          '8f86acefb9d8952b1c2e739366a99a45', // Replace with your Auth Token
      twilioNumber: '+15076232813', // Replace with your Twilio Number
    );
  }

  Future<void> sendSms(String toNumber, String messageBody) async {
    try {
      await twilioFlutter.sendSMS(
        toNumber: toNumber,
        messageBody: messageBody,
      );
      print("SMS sent successfully");
    } catch (e) {
      print("Failed to send SMS: $e");
    }
  }
}
