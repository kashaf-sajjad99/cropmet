import 'package:url_launcher/url_launcher.dart';

void openPrivacyPolicy() async {
  const String websiteUrl =
      "https://kashaf-sajjad99.github.io/cropmet/privacy-policy.html";

  try {
    bool launched = await launchUrl(
      Uri.parse(websiteUrl),
      mode: LaunchMode.externalApplication,
    );

    if (!launched) {}
  } catch (e) {}
}
