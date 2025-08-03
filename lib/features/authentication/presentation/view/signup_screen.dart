import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharko_doctor/app/service_locator/service_locator.dart';
import 'package:gharko_doctor/features/authentication/presentation/view/signin_screen.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/signup_view_model/register_view_model.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/signup_view_model/register_event.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/signup_view_model/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharko_doctor/features/authentication/presentation/view/signin_screen.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/signup_view_model/register_event.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/signup_view_model/register_state.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/signup_view_model/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharko_doctor/features/authentication/presentation/view/signin_screen.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/signup_view_model/register_event.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/signup_view_model/register_state.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/signup_view_model/register_view_model.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _obscurePassword = ValueNotifier<bool>(true);

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterViewModel, RegisterState>(
      listener: (context, state) {
        if (state.isSuccess) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => LoginScreen()),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildTextField("Full Name", fullNameController),
                      _buildTextField("Email", emailController),
                      ValueListenableBuilder<bool>(
                        valueListenable: _obscurePassword,
                        builder: (context, obscure, _) {
                          return _buildPasswordField(
                            "Password",
                            obscure,
                            () => _obscurePassword.value = !obscure,
                            controller: passwordController,
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: state.isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<RegisterViewModel>().add(
                                          RegisterUserEvent(
                                            fullName: fullNameController.text.trim(),
                                            email: emailController.text.trim(),
                                            password: passwordController.text.trim(),
                                            context: context,
                                          ),
                                        );
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: state.isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Sign Up",
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (_) => LoginScreen()),
                            (route) => false,
                          ),
                          child: const Text.rich(
                            TextSpan(
                              text: "Already have an account? ",
                              children: [
                                TextSpan(
                                  text: "Login",
                                  style: TextStyle(color: Colors.teal),
                                ),
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
    String label,
    bool obscureText,
    VoidCallback toggle, {
    required TextEditingController controller,
  }) {
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
