import 'package:url_launcher/url_launcher.dart';

// Function to open a website in Chrome
void openWebsite() async {
  const String websiteUrl = "https://www.pacaqld.org/";

  try {
    bool launched = await launchUrl(Uri.parse(websiteUrl),
        mode: LaunchMode.externalApplication);

    if (!launched) {
      // If the website does not open, you can handle the error here
      print('Could not launch $websiteUrl');
    }
  } catch (e) {
    print('Error: $e');
  }
}

void openPrivacyPolicy() async {
  const String websiteUrl =
      "https://allspicetechnologiesptyltd-my.sharepoint.com/:b:/g/personal/k_sajjad_allspicetech_com_au/EfuSQ_6RoWVDoxHJoy4wAt8BhmrOG_uTPw9HlB58tq4Xjg?e=x6AVXT";

  try {
    bool launched = await launchUrl(Uri.parse(websiteUrl),
        mode: LaunchMode.externalApplication);

    if (!launched) {
      // If the website does not open, you can handle the error here
      print('Could not launch $websiteUrl');
    }
  } catch (e) {
    print('Error: $e');
  }
}
