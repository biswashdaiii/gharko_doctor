import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharko_doctor/app/service_locator/service_locator.dart';
import 'package:gharko_doctor/features/authentication/presentation/view/signin_screen.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/sigin_view_model/signin_view_model.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/signup_view_model/signup_event.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/signup_view_model/signup_state.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/signup_view_model/signup_view_model.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _obscurePassword = ValueNotifier<bool>(true);
  final _obscureConfirmPassword = ValueNotifier<bool>(true);

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupViewModel, SignupState>(
      listener: (context, state) {
        if (state.isSuccess) {
          // After successful signup, navigate to SigninScreen wrapped with LoginViewModel BlocProvider
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider<LoginViewModel>(
                create: (_) => serviceLocator<LoginViewModel>(),
                child: SigninScreen(),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: constraints.maxWidth > 600 ? 500 : double.infinity,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Icon(Icons.arrow_back),
                            ),
                            const SizedBox(height: 20),
                            const Center(
                              child: Column(
                                children: [
                                  Text(
                                    "Create Account",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.teal,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Enter your Personal Data",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            _buildTextField("First Name", firstNameController),
                            _buildTextField("Last Name", lastNameController),
                            _buildTextField("Email", emailController),
                            _buildTextField("Phone Number", phoneController),
                            ValueListenableBuilder<bool>(
                              valueListenable: _obscurePassword,
                              builder: (context, obscure, _) {
                                return _buildPasswordField(
                                  "Create Password",
                                  obscure,
                                  () => _obscurePassword.value = !obscure,
                                  controller: passwordController,
                                );
                              },
                            ),
                            ValueListenableBuilder<bool>(
                              valueListenable: _obscureConfirmPassword,
                              builder: (context, obscure, _) {
                                return _buildPasswordField(
                                  "Confirm Password",
                                  obscure,
                                  () => _obscureConfirmPassword.value = !obscure,
                                  controller: confirmPasswordController,
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.teal,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<SignupViewModel>().add(
                                          RegisterUserEvent(
                                            context: context,
                                            username: emailController.text.trim(),
                                            phone: phoneController.text.trim(),
                                            password: passwordController.text.trim(),
                                            confirmPassword: confirmPasswordController.text.trim(),
                                          ),
                                        );
                                  }
                                },
                                child: state.isLoading
                                    ? const CircularProgressIndicator(color: Colors.white)
                                    : const Text("Signup"),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Center(
                              child: Text(
                                "By continuing you are agreeing to our Terms & Conditions and our Privacy Policies",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Divider(),
                            const SizedBox(height: 16),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  // Navigate back to SigninScreen wrapped with LoginViewModel BlocProvider
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => BlocProvider<LoginViewModel>(
                                        create: (_) => serviceLocator<LoginViewModel>(),
                                        child: SigninScreen(),
                                      ),
                                    ),
                                  );
                                },
                                child: const Text.rich(
                                  TextSpan(
                                    text: "Already have an account? ",
                                    children: [
                                      TextSpan(
                                        text: "Login",
                                        style: TextStyle(color: Colors.teal),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "$label is required";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField(
      String label, bool obscureText, VoidCallback toggle,
      {required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          suffixIcon: IconButton(
            icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
            onPressed: toggle,
          ),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "$label is required";
          }
          return null;
        },
      ),
    );
  }
}
