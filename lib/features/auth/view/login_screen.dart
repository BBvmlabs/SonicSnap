import 'package:flutter/material.dart';
import 'package:sonic_snap/core/app_theme.dart';
import 'package:sonic_snap/features/auth/widgets/input_widget.dart';
import 'package:sonic_snap/routes/navigator.dart';
import 'package:sonic_snap/widgets/appLogo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  double screenWidth = 0;
  bool isLargeScreen = false;
  bool isOfflineMode = false;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    isLargeScreen = screenWidth > 1000;
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: isLargeScreen ? buildLargeScreen() : buildSmallScreen(),
      ),
    );
  }

  Widget buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("EMAIL ADDRESS",
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Colors.white60,
                )),
        const SizedBox(height: 12),
        LoginInputWidget(
            label: "Email",
            placeholder: "user@example.com",
            controller: emailController),
        const SizedBox(height: 24),
        Text("PASSWORD",
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Colors.white60,
                )),
        const SizedBox(height: 12),
        LoginInputWidget(
          label: "Password",
          placeholder: "• • • • • • • • • •",
          controller: passwordController,
          isPassword: true,
        ),
      ],
    );
  }

  Widget buildWelcomeText() {
    return Column(
      children: [
        Text('PlLUG INOT THE SOUNDSCAPE',
            style: isLargeScreen
                ? Theme.of(context).textTheme.bodyLarge
                : Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Widget screenButtons() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: Text(
              'Forgot Password?',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppTheme.primaryCyan.withOpacity(0.8),
                  ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Offline Only Mode",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Switch(
              value: isOfflineMode,
              activeThumbColor: AppTheme.primaryCyan,
              onChanged: (val) {
                setState(() => isOfflineMode = val);
              },
            ),
          ],
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () => navigate(context, "/home-screen"),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("SIGN IN"),
              SizedBox(width: 8),
              Icon(Icons.login_rounded, size: 20),
            ],
          ),
        ),
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed: () {},
          child: const Center(child: Text("Create Account")),
        ),
        // _buildSocialLogin(),
      ],
    );
  }

  Widget buildCard() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const SizedBox(height: 48),
          buildForm(),
          const SizedBox(height: 16),
          screenButtons(),
        ],
      ),
    );
  }

  Widget buildLargeScreen() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildLogo(context),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildCard(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSmallScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        children: [
          buildLogo(context),
          const SizedBox(height: 48),
          buildForm(),
          screenButtons(),
        ],
      ),
    );
  }
}
