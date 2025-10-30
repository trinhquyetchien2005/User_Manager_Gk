
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/input_field.dart';
import '../widgets/custom_button.dart';
import 'home_page.dart';
import 'register_page.dart';
import '../utils/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF7F53AC), Color(0xFF647DEE)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text('Đăng nhập', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 20),
                        InputField(
                          label: 'Email',
                          controller: emailController,
                          validator: Validators.validateEmail,
                        ),
                        const SizedBox(height: 12),
                        InputField(
                          label: 'Mật khẩu',
                          controller: passwordController,
                          obscureText: true,
                          validator: Validators.validatePassword,
                        ),
                        const SizedBox(height: 20),
                        loading
                            ? const Center(child: CircularProgressIndicator())
                            : CustomButton(
                                text: 'Đăng nhập',
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() => loading = true);
                                    final error = await auth.login(
                                        emailController.text.trim(), passwordController.text.trim());
                                    setState(() => loading = false);
                                    if (error != null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(content: Text(error)));
                                    } else {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (_) => const HomePage()),
                                      );
                                    }
                                  }
                                },
                              ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage()));
                          },
                          child: const Text('Chưa có tài khoản? Đăng ký'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
