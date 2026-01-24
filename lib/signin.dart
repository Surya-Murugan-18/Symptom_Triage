import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:symtom_checker/forget_password.dart';
import 'package:symtom_checker/homepage.dart';
import 'package:symtom_checker/login.dart';
import 'package:symtom_checker/signup.dart';

// 🌐 Language imports
import 'package:symtom_checker/language/app_state.dart';
import 'package:symtom_checker/language/app_strings.dart';

void main() => runApp(const SignInDemoApp());

class SignInDemoApp extends StatelessWidget {
  const SignInDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInPage(),
    );
  }
}

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _obscure = true;
  final _formKey = GlobalKey<FormState>();
  final _emailRegex = RegExp(r'^.+@.+\..+$');
  final _passwordRegex =
      RegExp(r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$&*~]).{8,}$');

  @override
  Widget build(BuildContext context) {
    final lang = AppState.selectedLanguage;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              // Header
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                      );
                    },
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        AppStrings.data[lang]!['login']!,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),

              const SizedBox(height: 8),

              // Logo
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'assets/logo.png',
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => Center(
                            child: Icon(
                              Icons.local_hospital,
                              size: 60,
                              color: Colors.teal.shade400,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),

              // Email
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 24.0, right: 8.0),
                      child: Icon(Icons.email_outlined),
                    ),
                    prefixIconConstraints:
                        const BoxConstraints(minWidth: 48),
                    hintText:
                        AppStrings.data[lang]!['email_hint']!,
                    border: InputBorder.none,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 25),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppStrings.data[lang]!['email_empty']!;
                    }
                    if (!_emailRegex.hasMatch(value.trim())) {
                      return AppStrings.data[lang]!['email_invalid']!;
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 14),

              // Password
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: TextFormField(
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 24.0, right: 8.0),
                      child: Icon(Icons.lock_outline),
                    ),
                    prefixIconConstraints:
                        const BoxConstraints(minWidth: 48),
                    hintText:
                        AppStrings.data[lang]!['password_hint']!,
                    border: InputBorder.none,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 25),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscure
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () =>
                          setState(() => _obscure = !_obscure),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.data[lang]!['pwd_empty']!;
                    }
                    if (value.length < 8) {
                      return AppStrings.data[lang]!['pwd_len']!;
                    }
                    if (!value.contains(RegExp(r'[A-Z]'))) {
                      return AppStrings.data[lang]!['pwd_upper']!;
                    }
                    if (!value.contains(RegExp(r'[0-9]'))) {
                      return AppStrings.data[lang]!['pwd_number']!;
                    }
                    if (!value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) {
                      return AppStrings.data[lang]!['pwd_symbol']!;
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgetPasswordPage(),
                      ),
                    );
                  },
                  child: Text(
                    AppStrings.data[lang]!['forgot_password']!,
                    style:
                        TextStyle(color: Colors.teal.shade600),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Login Button
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    final isValid = _formKey.currentState?.validate() ?? false;
                    if (!isValid) return;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HealthcareHomePage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF2CB39D),
                          Color(0xFF0F8F78)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        AppStrings.data[lang]!['login']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // Signup Text
              Center(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      AppStrings.data[lang]!['no_account']!,
                      style: const TextStyle(fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SignupPage()),
                        );
                      },
                      child: Text(
                        AppStrings.data[lang]!['signup']!,
                        style: TextStyle(
                          color: Colors.teal.shade600,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // OR
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      AppStrings.data[lang]!['or']!,
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),

              const SizedBox(height: 18),

              // Google
              Center(
  child: FractionallySizedBox(
    widthFactor: 0.92,
    child: SizedBox(
      height: 54,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.grey.shade300),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          backgroundColor: Colors.white,
        ),
        icon: const FaIcon(
          FontAwesomeIcons.google,
          size: 26,
          color: Colors.red,
        ),
        label: Text(
          AppStrings.data[lang]!['google_signin']!,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {},
      ),
    ),
  ),
),


        

              


              const SizedBox(height: 24),

              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 150,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
            ),
          ),
        ),
      ),
    );
  }
}
