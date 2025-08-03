import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharko_doctor/core/network/auth_service.dart';
import 'package:gharko_doctor/features/authentication/presentation/view/signin_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gharko_doctor/features/profile/presentation/viewmodel/profile_bloc.dart';
import 'package:gharko_doctor/features/profile/presentation/viewmodel/profile_event.dart';
import 'package:gharko_doctor/features/profile/presentation/viewmodel/profile_state.dart';
import 'package:gharko_doctor/features/profile/domain/entity/profile_entity.dart';

//

class ProfilePage extends StatefulWidget {
  final String userId;
  final AuthService authService; // inject authService here

  const ProfilePage({
    super.key,
    required this.userId,
    required this.authService,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(LoadProfile(widget.userId));
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void _populateControllers(UserProfileEntity profile) {
    nameController.text = profile.name ?? '';
    phoneController.text = profile.phone ?? '';
    addressController.text = profile.address ?? '';
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() => _selectedImage = File(pickedFile.path));
    }
  }

  void _onSave(UserProfileEntity currentProfile) {
    final updatedProfile = UserProfileEntity(
      id: currentProfile.id,
      name:
          nameController.text.isNotEmpty
              ? nameController.text
              : currentProfile.name,
      phone:
          phoneController.text.isNotEmpty
              ? phoneController.text
              : currentProfile.phone,
      address:
          addressController.text.isNotEmpty
              ? addressController.text
              : currentProfile.address,
      avatarUrl: _selectedImage?.path ?? currentProfile.avatarUrl,
      email: currentProfile.email,
      lastSeen: currentProfile.lastSeen,
      gender: currentProfile.gender,
      dob: currentProfile.dob,
    );

    context.read<ProfileBloc>().add(UpdateProfile(updatedProfile));
  }

  Future<void> _logout() async {
    final result = await widget.authService.logout();

    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Logout failed: ${failure.message}')),
        );
      },
      (_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.profile != null) {
          _populateControllers(state.profile!);
        }
        if (state.error != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error!)));
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final profile = state.profile;
        if (profile == null) {
          return const Center(child: Text("No profile loaded"));
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("Profile"),
            centerTitle: true,
            backgroundColor: theme.primaryColorDark,
            elevation: 2,
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'Logout',
                onPressed: _logout,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: pickImage,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey[200],
                          backgroundImage:
                              _selectedImage != null
                                  ? FileImage(_selectedImage!)
                                  : (profile.avatarUrl.isNotEmpty
                                          ? NetworkImage(
                                            "http://192.168.1.77:5050/${profile.avatarUrl}",
                                          )
                                          : null)
                                      as ImageProvider<Object>?,
                          child:
                              profile.avatarUrl.isEmpty &&
                                      _selectedImage == null
                                  ? Icon(
                                    Icons.person,
                                    size: 60,
                                    color: Colors.grey[400],
                                  )
                                  : null,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.primaryColorDark,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          padding: const EdgeInsets.all(6),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.phone),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: addressController,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.location_on),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () => _onSave(profile),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                      child: const Text(
                        "Update Profile",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
