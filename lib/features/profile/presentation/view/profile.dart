import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gharko_doctor/features/profile/domain/usecase/getprofile_usecase.dart';
import 'package:gharko_doctor/features/profile/domain/usecase/updateprofile_usecase.dart';
import 'package:gharko_doctor/features/profile/presentation/viewmodel/profile_bloc.dart';
import 'package:gharko_doctor/features/profile/presentation/viewmodel/profile_event.dart';
import 'package:gharko_doctor/features/profile/presentation/viewmodel/profile_state.dart';

class ProfilePage extends StatefulWidget {
  final String userId;

  const ProfilePage({super.key, required this.userId});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();

    // Load profile after widget is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileBloc>().add(LoadProfile(widget.userId));
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error!)));
          }
          if (!state.isLoading && state.error == null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Profile updated')));
          }
        },
        builder: (context, state) {
          if (state.isLoading) return const Center(child: CircularProgressIndicator());
          if (state.profile == null) return const Center(child: Text('No profile found'));

          final profile = state.profile!;
          // Populate controllers
          nameController.text = profile.name;
          emailController.text = profile.email;
          phoneController.text = profile.phone;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(profile.avatarUrl),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(labelText: 'Phone'),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      final updatedProfile = profile.copyWith(
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                      );
                      context.read<ProfileBloc>().add(UpdateProfile(updatedProfile));
                    },
                    child: const Text('Update Profile'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

