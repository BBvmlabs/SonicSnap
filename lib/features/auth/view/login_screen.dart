import 'package:flutter/material.dart';
import 'package:sonic_snap/features/auth/widgets/input_widget.dart';
import 'package:sonic_snap/routes/navigator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome Back!',
                style: Theme.of(context).textTheme.headlineLarge),
            Text('Login to your account',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16),
            LoginInputWidget(
                label: "Email",
                placeholder: "Email",
                controller: emailController),
            const SizedBox(height: 16),
            LoginInputWidget(
              label: "Password",
              placeholder: "Password",
              controller: passwordController,
              isPassword: true,
            ),
            ElevatedButton(
                onPressed: () {
                  navigate(context, "/home-screen");
                },
                child: const Text('Login')),
          ],
        ),
      ),
    );
  }
}
