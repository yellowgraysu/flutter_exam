import 'package:flutter/material.dart';
import 'package:flutter_exam/service/auth.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({super.key});

  static const String path = '/login';

  @override
  Widget build(BuildContext context) {
    final accountController = useTextEditingController();
    final passwordController = useTextEditingController();
    final error = useState<String>('');

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: accountController,
                  decoration: const InputDecoration(
                    hintText: 'Account',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Account',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  error.value,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () async {
                    error.value = await authService.signIn(
                            accountController.text, passwordController.text) ??
                        '';
                  },
                  child: const Text('Sign In'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
