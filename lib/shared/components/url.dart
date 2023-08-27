import 'package:url_launcher/url_launcher.dart';

class UrlUtils {
  UrlUtils._();

  static Future<void> urlLauncher(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
