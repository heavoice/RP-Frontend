import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/services/login_service.dart';
import 'package:frontend/settings/constant.dart';
import 'package:frontend/widgets/password_underline_text.dart';
import 'package:frontend/widgets/signup_underline_text.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      _emailController.text = args['email'] ?? '';
      _passwordController.text = args['password'] ?? '';
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Email dan password wajib diisi',
          ),
        ),
      );

      return;
    }

    try {
      await ref.read(authProvider.notifier).login(
            email: _emailController.text,
            password: _passwordController.text,
          );

      debugPrint(
        'LOGIN SUCCESS',
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Login berhasil 🎉',
          ),
        ),
      );
    } catch (e, stackTrace) {
      debugPrint(
        'LOGIN ERROR: $e',
      );

      debugPrint(
        'STACK TRACE: $stackTrace',
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Login gagal, cek email/password',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMiniMobile = screenWidth < 480;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: isMiniMobile ? 300 : 400),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/img/splash_screen2.0x.png',
                      height: 150,
                      filterQuality: FilterQuality.high,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Selamat datang!',
                      style: TextStyle(
                        fontFamily: AppFonts.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primarycolor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Masuk ke akun Anda menggunakan email atau jejaring sosial.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: AppFonts.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: AppColors.primarycolor,
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),

              /// FORM
              Form(
                child: Container(
                  constraints:
                      BoxConstraints(maxWidth: isMiniMobile ? 300 : 400),
                  child: Column(
                    children: [
                      /// EMAIL
                      TextFormField(
                        controller: _emailController,
                        cursorColor: AppColors.primarycolor,
                        style: const TextStyle(
                          fontFamily: AppFonts.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primarycolor,
                        ),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            LucideIcons.mail,
                            color: AppColors.primarycolor,
                            size: 16,
                          ),
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            fontFamily: AppFonts.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primarycolor,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primarycolor,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primarycolor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primarycolor,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// PASSWORD
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        cursorColor: AppColors.primarycolor,
                        style: const TextStyle(
                          fontFamily: AppFonts.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primarycolor,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            LucideIcons.key,
                            color: AppColors.primarycolor,
                            size: 16,
                          ),
                          labelText: 'Password',
                          labelStyle: const TextStyle(
                            fontFamily: AppFonts.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primarycolor,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primarycolor,
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primarycolor,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primarycolor,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? LucideIcons.eye
                                  : LucideIcons.eyeOff,
                              color: AppColors.primarycolor,
                              size: 16,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          PasswordUnderlineText(
                            text: 'Lupa password?',
                            onTap: () {},
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      /// LOGIN BUTTON
                      InkWell(
                        onTap: _handleLogin,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: AppColors.primarycolor,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Login',
                                style: TextStyle(
                                  fontFamily: AppFonts.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Belum punya akun?',
                            style: TextStyle(
                              fontFamily: AppFonts.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primarycolor,
                            ),
                          ),
                          const SizedBox(width: 5),
                          SignuplineText(
                            text: 'Daftar',
                            onTap: () {
                              Navigator.pushNamed(context, '/register');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
