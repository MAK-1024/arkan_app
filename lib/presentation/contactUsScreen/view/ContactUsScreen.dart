import 'package:arkanstore_app/core/theme/colors.dart';
import 'package:flutter/material.dart';import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تواصل معنا'),
        backgroundColor: Colors.transparent,
        elevation: 0, // No shadow
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildContactOption(
              'شكاوى',
              Icons.report_problem_outlined,
              ['218910056423', '218910056423'],
              context,
            ),
            SizedBox(height: 40),
            _buildContactOption(
              'خدمة العملاء',
              Icons.headset_mic_outlined,
              ['218910056423', '218910056423'],
              context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactOption(String title, IconData icon,
      List<String> phoneNumbers, BuildContext context) {
    return InkWell(
      onTap: () {
        _showBottomSheet(context, phoneNumbers);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.MainColor), // Simple border
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600, // Slightly less bold
                    color: AppColors.MainColor,
                  ),
                ),
              ],
            ),
            Icon(
              icon,
              size: 30,
              color: AppColors.MainColor,
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, List<String> phoneNumbers) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: phoneNumbers.map((phoneNumber) {
              return ListTile(
                leading: Icon(Icons.phone, color: AppColors.MainColor),
                title: Text(phoneNumber),
                onTap: () async {
                  final Uri launchUri = Uri(
                    scheme: 'tel',
                    path: phoneNumber.replaceAll(RegExp(r'[^\d+]'), ''),
                  );
                  if (await canLaunchUrl(launchUri)) {
                    await launchUrl(launchUri);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Could not launch $launchUri')),
                    );
                  }
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}