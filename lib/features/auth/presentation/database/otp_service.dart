import 'package:bikretaa/app/urls.dart';
import 'package:bikretaa/features/auth/presentation/database/network_caller.dart';

class OtpApiService {
  static Future<NetworkResponse> sendOtp({
    required String email,
    required String otp,
  }) async {
    return await NetworkCaller.postRequest(
      url: Urls.sendEmailOtp,
      body: {
        "sender": {"name": "Bikretaa", "email": "rentrover2025@gmail.com"},
        "to": [
          {"email": email},
        ],
        "subject": "Your One-Time Password (OTP) Code",
        "htmlContent":
            "<html lang='en'><body>"
            "<h2>One-Time Verification Code</h2>"
            "<p>Dear User,</p>"
            "<p>Your One-Time Password (OTP) for verification is:</p>"
            "<h1 style='color:#2E86C1;'>$otp</h1>"
            "<br>"
            "<p>Best regards,<br>Bikretaa Team</p>"
            "</body></html>",
      },
      isBrevoRequest: true,
    );
  }
}
