
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/input_field.dart';
import '../widgets/custom_button.dart';
import '../utils/validators.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Đăng ký')),
      body: Center(
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
                      const Text('Tạo tài khoản', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
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
                              text: 'Đăng ký',
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() => loading = true);
                                  final error = await auth.register(
                                      emailController.text.trim(), passwordController.text.trim());
                                  setState(() => loading = false);
                                  if (error != null) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(content: Text(error)));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(content: Text('Đăng ký thành công')));
                                    Navigator.pop(context);
                                  }
                                }
                              },
                            ),
                    ],
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
