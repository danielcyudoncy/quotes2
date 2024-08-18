import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quotes2/controllers/register_controller.dart';
import 'package:quotes2/screens/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterController registerController = Get.put(RegisterController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(
            () => Form(
              key: registerController.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  _buildTextFormField(
                    controller: registerController.fullNameController,
                    label: 'Full Name',
                    hint: 'Enter Full Name',
                    validator: (value) => value?.isEmpty ?? true ? 'Please enter Full name' : null,
                    onChanged: (value) => registerController.fullName.value = value,
                  ),
                  const SizedBox(height: 15.0),
                  _buildTextFormField(
                    controller: registerController.emailController,
                    label: 'Email',
                    hint: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => registerController.validateEmail(value),
                    onChanged: (value) => registerController.email.value = value,
                  ),
                  const SizedBox(height: 15.0),
                  _buildPasswordFormField(
                    controller: registerController.passwordController,
                    label: 'Password',
                    hint: 'Enter your password',
                    onChanged: (value) => registerController.password.value = value,
                    toggle: registerController.toggled,
                  ),
                  const SizedBox(height: 15.0),
                  _buildPasswordFormField(
                    controller: registerController.confirmPasswordController,
                    label: 'Confirm Password',
                    hint: 'Re-enter your password',
                    validator: (value) => value != registerController.password.value ? "Passwords don't match" : null,
                    onChanged: (value) => registerController.confirmPassword.value = value,
                    toggle: registerController.toggled,
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    children: [
                      Checkbox(
                        value: registerController.agreePersonalData.value,
                        onChanged: (value) => registerController.agreePersonalData.value = value ?? false,
                        activeColor: Colors.blue,
                      ),
                      const Text(
                        'I agree to the processing of ',
                        style: TextStyle(color: Colors.black54),
                      ),
                      const Text(
                        'Personal data',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25.0),
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: registerController.register,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(350, 50),
                        backgroundColor: const Color.fromARGB(255, 31, 44, 226),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text('Register'),
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.7,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        child: Text(
                          'Register with',
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.7,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25.0),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SvgPicture.asset('assets/images/icon-google.svg'),
                          const SizedBox(width: 15.0),
                          const Text(
                            'Google',
                            style: TextStyle(fontWeight: FontWeight.w800),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: TextStyle(color: Colors.black45),
                      ),
                      GestureDetector(
                        onTap: () => Get.to(() => const LoginScreen()),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black26),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black12),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
    );
  }

  Widget _buildPasswordFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
    String? Function(String?)? validator,
    required RxBool toggle,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: toggle.value,
      obscuringCharacter: '*',
      validator: validator ?? (value) {
        if (value == null || value.isEmpty || value.length < 6) {
          return 'Password must be at least 6 characters long!';
        }
        return null;
      },
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            toggle.value ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () => toggle.toggle(),
        ),
        labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black26),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black12),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
