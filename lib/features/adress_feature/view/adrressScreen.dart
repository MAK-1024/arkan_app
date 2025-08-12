import 'package:arkanstore_app/core/Routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:toastification/toastification.dart';
import '../../../core/theme/colors.dart';
import '../bloc/adress_cubit.dart';
import '../bloc/adress_state.dart';
import 'addLocationScreen.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final String lottieUrl = 'https://lottie.host/ba99bd24-7218-49af-826b-21d29286b764/NQSxpNIouB.json';

  @override
  void initState() {
    super.initState();
    context.read<AddressCubit>().loadAddresses();
  }

  Future<void> _checkPermissionsAndGPS() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      await Permission.location.request();
      status = await Permission.location.status;
      if (!status.isGranted) {
        _showSnackBar('الرجاء إعطاء السماحية للوصول للموقع الخاص بك');
        return;
      }
    }

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showSnackBar('الرجاء تفعيل الموقع الخاص بك');
      await _openLocationSettings();
      return;
    }

    final result = await GoRouter.of(context).pushReplacement(AppRouter.addLocationScreen);
    if (result != null && result is Map<String, dynamic>) {
      context.read<AddressCubit>().saveAddress(result);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _openLocationSettings() async {
    bool opened = await Geolocator.openLocationSettings();
    if (!opened) {
      _showSnackBar('Could not open location settings');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: AppColors.appBarColor,
          title: const Text('العناوين'),
          actions: [
            IconButton(
              onPressed: _checkPermissionsAndGPS,
              icon: const Icon(Icons.add_location_outlined, color: AppColors.SecondaryColor, size: 35),
            ),
          ],
        ),
        body: BlocConsumer<AddressCubit, AddressState>(
          listener: (context, state) {
            if (state is AddressError) {
              _showSnackBar(state.message);
            } else if (state is AddressUpdated) {
              _showSnackBar('Address updated successfully!');
            } else if (state is AddressDeleted) {
              _showSnackBar('Address deleted successfully!');
            }
          },
          builder: (context, state) {
            if (state is AddressLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AddressLoaded) {
              final addresses = state.addresses;
              return addresses.isEmpty ? _buildEmptyState() : _buildAddressList(addresses);
            }
            return const Center(child: Text('No data available.'));
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.network(lottieUrl, width: 300, height: 300),
          const SizedBox(height: 16),
          const Text('لم يتم حفظ أي عناوين حتى الآن', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87, fontSize: 20)),
          const SizedBox(height: 20),
          TextButton(
            onPressed: _checkPermissionsAndGPS,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              backgroundColor: AppColors.SecondaryColor.withOpacity(0.1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            child: const Text(' إضافة عنوان جديد ', style: TextStyle(color: AppColors.SecondaryColor, fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressList(List<Map<String, dynamic>> addresses) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          return AddressListItem(address: addresses[index]);
        },
      ),
    );
  }
}

class AddressListItem extends StatelessWidget {
  final Map<String, dynamic> address;

  const AddressListItem({Key? key, required this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = address['name'] ?? 'Unnamed Address';
    final details = address['details'] ?? 'No details provided';
    final id = address['id'];

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(details, style: const TextStyle(color: Colors.black54)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                if (id != null) {
                  _showDeleteConfirmationDialog(context, id);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Address ID is missing.')));
                }
              },
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          title: const Center(child: Text('تأكيد الحذف', style: TextStyle(fontWeight: FontWeight.bold))),
          content: const Text('هل أنت متأكد من حذف هذا العنوان؟', textAlign: TextAlign.center),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
              child: const Text('إغلاق'),
            ),
            TextButton(
              onPressed: () {
                context.read<AddressCubit>().deleteAddress(id);
                Navigator.pop(context);
                toastification.show(
                  context: context,
                  style: ToastificationStyle.flat,
                  type: ToastificationType.success,
                  title: const Text('تم حذف العنوان'),
                  autoCloseDuration: const Duration(seconds: 3),
                  alignment: Alignment.topCenter,
                  icon: const Icon(Icons.check),
                  closeOnClick: true,
                );
              },
              style: TextButton.styleFrom(foregroundColor: AppColors.SecondaryColor),
              child: const Text('حذف'),
            ),
          ],
        );
      },
    );
  }
}