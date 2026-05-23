// RegisterScreen.dart
import 'package:flutter/material.dart';
import 'package:frontend/services/register_service.dart';
import 'package:frontend/settings/constant.dart';
import 'package:frontend/widgets/password_underline_text.dart';
import 'package:frontend/widgets/signup_underline_text.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? selectedGender;
  String? _emailError;
  String? _passwordError;
  DateTime? selectedDate;
  bool _obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobileOrTablet = screenWidth < 1000;
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
                  const Text('Hai, Calon pengguna baru!',
                      style: TextStyle(
                          fontFamily: AppFonts.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primarycolor)),
                  const SizedBox(height: 12),
                  const Text(
                    'Daftarkan akun baru Anda menggunakan email atau jejaring sosial.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: AppFonts.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: AppColors.primarycolor),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            Form(
                key: _formKey,
                child: Container(
                    constraints:
                        BoxConstraints(maxWidth: isMiniMobile ? 300 : 400),
                    child: Column(children: [
                      TextFormField(
                        controller: _nameController,
                        cursorColor: AppColors.primarycolor,
                        style: const TextStyle(
                            fontFamily: AppFonts.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primarycolor),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(LucideIcons.idCard,
                              color: AppColors.primarycolor, size: 16),
                          labelStyle: TextStyle(
                              fontFamily: AppFonts.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primarycolor),
                          labelText: 'Nama Lengkap',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primarycolor),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primarycolor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primarycolor),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _emailController,
                        cursorColor: AppColors.primarycolor,
                        onChanged: (value) {
                          setState(() {
                            _emailError = _validateEmail(value);
                          });
                        },
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
                            borderSide:
                                BorderSide(color: AppColors.primarycolor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primarycolor),
                          ),
                        ),
                      ),
                      if (_emailError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            _emailError!,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.red,
                              fontFamily: AppFonts.primary,
                            ),
                          ),
                        ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _passwordController,
                        cursorColor: AppColors.primarycolor,
                        obscureText: _obscurePassword,
                        onChanged: (value) {
                          setState(() {
                            _passwordError = _validatePassword(value);
                          });
                        },
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
                            borderSide:
                                BorderSide(color: AppColors.primarycolor),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primarycolor),
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
                      if (_passwordError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            _passwordError!,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.red,
                              fontFamily: AppFonts.primary,
                            ),
                          ),
                        ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _phoneController,
                        cursorColor: AppColors.primarycolor,
                        style: const TextStyle(
                            fontFamily: AppFonts.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primarycolor),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            LucideIcons.phone,
                            color: AppColors.primarycolor,
                            size: 16,
                          ),
                          labelStyle: TextStyle(
                              fontFamily: AppFonts.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primarycolor),
                          labelText: 'No. Telepon',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primarycolor),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primarycolor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primarycolor),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _birthController,
                        readOnly: true,
                        cursorColor: AppColors.primarycolor,
                        style: const TextStyle(
                          fontFamily: AppFonts.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primarycolor,
                        ),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            LucideIcons.cake,
                            color: AppColors.primarycolor,
                            size: 16,
                          ),
                          labelText: 'Tgl. Lahir',
                          labelStyle: TextStyle(
                            fontFamily: AppFonts.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primarycolor,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primarycolor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primarycolor),
                          ),
                        ),
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  textTheme: Theme.of(context).textTheme.apply(
                                        fontFamily:
                                            AppFonts.primary, // 🔥 FONT DI SINI
                                      ),
                                  colorScheme: const ColorScheme.light(
                                    primary: AppColors.primarycolor,
                                    onSurface: AppColors.primarycolor,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );

                          if (date != null) {
                            setState(() {
                              selectedDate = date;

                              // 🔥 INI YANG UPDATE UI
                              _birthController.text =
                                  "${date.day.toString().padLeft(2, '0')}/"
                                  "${date.month.toString().padLeft(2, '0')}/"
                                  "${date.year}";
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        initialValue: selectedGender,
                        icon: const Icon(
                          LucideIcons.chevronDown,
                          color: AppColors.primarycolor,
                          size: 16,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Jenis Kelamin',
                          labelStyle: TextStyle(
                            fontFamily: AppFonts.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primarycolor,
                          ),
                          prefixIcon: Icon(
                            LucideIcons.user,
                            color: AppColors.primarycolor,
                            size: 16,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primarycolor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primarycolor),
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'lk', // 🔥 FIX
                            child: Text(
                              'Laki-laki',
                              style: TextStyle(
                                fontFamily: AppFonts.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primarycolor,
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'pr', // 🔥 FIX
                            child: Text(
                              'Perempuan',
                              style: TextStyle(
                                fontFamily: AppFonts.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primarycolor,
                              ),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          PasswordUnderlineText(
                            text: 'Lupa password?',
                            onTap: () {
                              // TODO: action lupa password
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      InkWell(
                        onTap: () async {
                          // 🔥 trigger semua validator TextFormField
                          final isValid = _formKey.currentState!.validate();

                          // 🔥 cek juga validation custom (live validation)
                          if (!isValid ||
                              _emailError != null ||
                              _passwordError != null ||
                              selectedDate == null ||
                              selectedGender == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Periksa kembali data Anda'),
                              ),
                            );
                            return;
                          }

                          try {
                            await RegisterService.register(
                              name: _nameController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                              phone: _phoneController.text,
                              birthDate: formatDate(selectedDate!),
                              gender: selectedGender,
                            );

                            Navigator.pushReplacementNamed(
                              context,
                              '/login',
                              arguments: {
                                'email': _emailController.text,
                                'password': _passwordController.text,
                              },
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Register berhasil 🎉'),
                              ),
                            );
                          } catch (e, stackTrace) {
                            debugPrint('Register Error: $e');
                            debugPrint('Stack Trace: $stackTrace');

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Register gagal, coba lagi'),
                              ),
                            );
                          }
                        },
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        hoverColor: const Color.fromRGBO(0, 0, 0, 0),
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: AppColors.primarycolor,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Register',
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
                            'Sudah punya akun?',
                            style: TextStyle(
                                fontFamily: AppFonts.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.primarycolor),
                          ),
                          const SizedBox(width: 5),
                          SignuplineText(
                              text: 'Masuk',
                              onTap: () {
                                Navigator.pushNamed(context, '/login');
                              }),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Divider(
                                color: Color.fromARGB(255, 211, 211, 211),
                                thickness: 1,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Atau masuk dengan',
                              style: TextStyle(
                                  fontFamily: AppFonts.primary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primarycolor),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Divider(
                                color: Color.fromARGB(255, 211, 211, 211),
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(5),
                              onTap: () {},
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color(0x0DD8D8D8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 20),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/img/google.png',
                                      width: 24,
                                    ),
                                    const SizedBox(width: 24),
                                    const Text(
                                      'Google',
                                      style: TextStyle(
                                          fontFamily: AppFonts.primary,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.primarycolor),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ])
                    ])))
          ],
        )),
      ),
    );
  }
}

String? _validatePassword(String value) {
  if (value.isEmpty) {
    return 'Password wajib diisi';
  }

  if (value.length < 6) {
    return 'Minimal 6 karakter';
  }

  if (!RegExp(r'[A-Z]').hasMatch(value)) {
    return 'Harus ada huruf besar';
  }

  if (!RegExp(r'[0-9]').hasMatch(value)) {
    return 'Harus ada angka';
  }

  return null;
}

String? _validateEmail(String value) {
  final emailRegex = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  if (value.isEmpty) return 'Email wajib diisi';
  if (!emailRegex.hasMatch(value)) return 'Format email tidak valid';

  return null;
}
