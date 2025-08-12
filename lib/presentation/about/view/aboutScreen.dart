import 'package:arkanstore_app/core/images/app_images.dart';
import 'package:arkanstore_app/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  final String appVersion = '1.0.0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: Text('حول التطبيق'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 80),
            Image.asset(
              AppImages.arkanLogo,
              height: 200,
              width: 200,
            ),
            SizedBox(height: 30),
            Text(
              'V$appVersion',
              style: TextStyle(
                  color: AppColors.SecondaryColor, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Text(
              "تطبيق أركان .................",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _socialMediaIcon(
                  context: context,
                  url: 'http://arkanco.ly/',
                  icon: FontAwesomeIcons.facebook,
                  color: Color(0xFF3b5998),
                ),
                _socialMediaIcon(
                  context: context,
                  url: 'https://www.tiktok.com/@estore.ly',
                  icon: FontAwesomeIcons.tiktok,
                  color: Color(0xFF000000),
                ),
                _socialMediaIcon(
                  context: context,
                  url: 'https://www.instagram.com/your_instagram_profile',
                  icon: FontAwesomeIcons.instagram,
                  color: Color(0xFFE1306C),
                ),
                _socialMediaIcon(
                  context: context,
                  url: 'https://wa.me/+218914661000',
                  icon: FontAwesomeIcons.whatsapp,
                  color: Color(0xFF25D366),
                ),
                _socialMediaIcon(
                  context: context,
                  url: 'https://wa.me/+218914661000',
                  icon: FontAwesomeIcons.globe,
                  color: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialMediaIcon({
    required BuildContext context,
    required String url,
    required IconData icon,
    required Color color,
  }) {
    return IconButton(
      onPressed: () => _launchSocialMedia(context, url),
      icon: FaIcon(icon, color: color, size: 25),
    );
  }

  void _launchSocialMedia(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        _showErrorSnackBar(context, 'Could not launch $url');
      }
    } on PlatformException catch (e) {
      _showErrorSnackBar(context, 'Error launching URL: $e');
    } catch (e) {
      _showErrorSnackBar(context, 'An unexpected error occurred: $e');
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
