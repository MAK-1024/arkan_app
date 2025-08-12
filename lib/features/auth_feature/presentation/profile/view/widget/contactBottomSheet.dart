import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../core/theme/colors.dart';

class ContactBottomSheet extends StatelessWidget {
  const ContactBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _makePhoneCall(String phoneNumber) async {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $launchUri')),
        );
      }
    }

    void _launchEmail(String email) async {
      final Uri launchUri = Uri(
        scheme: 'mailto',
        path: email,
      );
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $launchUri')),
        );
      }
    }

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            buildPhoneNumbers('218 91-0056423', Icons.call,  () => _makePhoneCall('218 91-0056423')),
            buildPhoneNumbers('218 91-0056423', Icons.call,  () => _makePhoneCall('218 91-0056423')),
            buildPhoneNumbers('218 91-0056423', Icons.call,  () => _makePhoneCall('218 91-0056423')),
            buildPhoneNumbers('218 91-0056423', Icons.call,  () => _makePhoneCall('218 91-0056423')),

          ],
        ),
      ),
    );
  }


  ListTile buildPhoneNumbers(String phoneNumber , IconData icon , VoidCallback onTap){
    return ListTile(

      leading: Icon(icon , color: AppColors.SecondaryColor,),
      title: Text(phoneNumber),
      onTap: onTap,
    );
  }

}
