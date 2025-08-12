import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:toastification/toastification.dart';
import '../../../core/Routing/routes.dart';
import '../../../core/theme/colors.dart';
import '../../../core/widgets/buttonCompo.dart';
import '../../../core/widgets/textfeildCompo.dart';
import '../bloc/adress_cubit.dart';
import '../bloc/adress_state.dart';

class AddLocationInfoScreen extends StatelessWidget {
  final gmaps.LatLng location;

  const AddLocationInfoScreen({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController();
    final _descriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('أضف تفاصيل الموقع'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).pushReplacement(AppRouter.addressScreen);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AddressCubit, AddressState>(
          listener: (context, state) {
            if (state is AddressSuccess) {
              toastification.show(
                context: context,
                style: ToastificationStyle.flat,
                type: ToastificationType.success,
                title: const Text('تم اضافة الموقع بنجاح'),
                autoCloseDuration: const Duration(seconds: 3),
                alignment: Alignment.topCenter,
                icon: const Icon(Icons.check),
                closeOnClick: true,
              );
              GoRouter.of(context).pushReplacement(AppRouter.addressScreen);
            } else if (state is AddressError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            final isSaving = state is AddressLoading;

            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context).pushReplacement(AppRouter.addressScreen);
                      },
                      child: CustomTextField(
                        hintText: 'الموقع (Lat: ${location.latitude}, Lng: ${location.longitude})',
                        controller: TextEditingController(text: '${location.latitude}, ${location.longitude}'),
                        prefixIcon: Icons.location_on,
                        borderRadius: 12.0,
                        borderColor: AppColors.SecondaryColor,
                        readOnly: true,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    CustomTextField(
                      hintText: 'الاسم',
                      controller: _nameController,
                      prefixIcon: Icons.person,
                      borderRadius: 12.0,
                      borderColor: AppColors.SecondaryColor,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال اسم';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    CustomTextField(
                      hintText: 'الوصف',
                      controller: _descriptionController,
                      prefixIcon: Icons.description,
                      borderRadius: 12.0,
                      borderColor: AppColors.SecondaryColor,
                    ),
                    const SizedBox(height: 20.0),
                    Center(
                      child: CustomMaterialButton(
                        onPressed: isSaving
                            ? () {}
                            : () {
                          if (_formKey.currentState!.validate()) {
                            final newAddress = {
                              'name': _nameController.text,
                              'details': _descriptionController.text,
                              'latitude': location.latitude,
                              'longitude': location.longitude,
                              'timestamp': DateTime.now().toIso8601String(),
                            };

                            context.read<AddressCubit>().saveAddress(newAddress);
                          }
                        },
                        buttonText: isSaving ? 'جاري الحفظ...' : 'حفظ',
                        buttonColor: AppColors.SecondaryColor,
                        height: 50,
                        minWidth: 200,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}