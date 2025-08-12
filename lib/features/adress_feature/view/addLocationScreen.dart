import 'package:arkanstore_app/core/Routing/routes.dart';
import 'package:arkanstore_app/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../bloc/adress_cubit.dart';
import '../bloc/adress_state.dart';
import 'addLocationInfoScreen.dart';

class AddLocationScreen extends StatefulWidget {
  final Map<String, dynamic>? address;

  const AddLocationScreen({Key? key, this.address}) : super(key: key);

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  late gmaps.GoogleMapController _googleMapController;
  gmaps.LatLng? _selectedLocation;

  @override
  void initState() {
    super.initState();
    if (widget.address == null) {
      context.read<AddressCubit>().getCurrentLocation();
    } else {
      _selectedLocation = gmaps.LatLng(widget.address!['latitude'], widget.address!['longitude']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اختر الموقع'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).pushReplacement(AppRouter.addressScreen);
          },
        ),
      ),
      body: BlocConsumer<AddressCubit, AddressState>(
        listener: (context, state) {
          if (state is AddressError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is AddressSuccess) {
            final location = state.address;
            setState(() {
              _selectedLocation = gmaps.LatLng(location['latitude'], location['longitude']);
            });
          }
        },
        builder: (context, state) {
          if (state is AddressLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AddressSuccess) {
            final initialLocation = state.address;
            return gmaps.GoogleMap(
              initialCameraPosition: gmaps.CameraPosition(
                target: _selectedLocation ?? gmaps.LatLng(initialLocation['latitude'], initialLocation['longitude']),
                zoom: 16.0,
              ),
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              onMapCreated: (controller) {
                _googleMapController = controller;
              },
              onTap: (gmaps.LatLng location) {
                setState(() {
                  _selectedLocation = location;
                });
              },
              markers: _selectedLocation == null ? {} : {
                gmaps.Marker(
                  markerId: gmaps.MarkerId('selectedLocation'),
                  position: _selectedLocation!,
                ),
              },
            );
          }

          return Center(
            child: LoadingAnimationWidget.newtonCradle(size: 150, color: AppColors.SecondaryColor),
          );
        },
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: 300,
            child: MaterialButton(
              onPressed: () async {
                if (_selectedLocation != null) {
                  final userId = await context.read<AddressCubit>().getUserId();
                  if (userId != null) {
                    final addressInfo = await Navigator.push<Map<String, dynamic>>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddLocationInfoScreen(location: _selectedLocation!),
                      ),
                    );

                    if (addressInfo != null) {
                      final newAddress = {
                        'latitude': _selectedLocation!.latitude,
                        'longitude': _selectedLocation!.longitude,
                        'userId': userId,
                        'name': addressInfo['name'],
                        'details': addressInfo['details'],
                        'timestamp': DateTime.now().toIso8601String(),
                      };

                      context.read<AddressCubit>().saveAddress(newAddress);
                      Navigator.pop(context);
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User ID not found.')));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('الرجاء اختيار الموقع قبل اتمام الاجراء')));
                }
              },
              color: AppColors.SecondaryColor,
              textColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              child: const Text('اختيار الموقع', style: TextStyle(fontSize: 16)),
            ),
          ),
        ),
      ),
    );
  }
}