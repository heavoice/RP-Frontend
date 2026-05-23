// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:frontend/settings/constant.dart';

// class SignalWave extends StatefulWidget {
//   final Color color;
//   final double amplitude; // lebar simpangan
//   final double frequency; // banyaknya gelombang
//   final double speed; // kecepatan animasi
//   final int lines; // jumlah garis wave

//   const SignalWave({
//     super.key,
//     this.color = AppColors.fourthcolor,
//     this.amplitude = 40,
//     this.frequency = 1,
//     this.speed = 1,
//     this.lines = 24, // default 5 garis
//   });

//   @override
//   State<SignalWave> createState() => _SignalWaveState();
// }

// class _SignalWaveState extends State<SignalWave>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 3),
//     )..repeat();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (context, child) {
//         return CustomPaint(
//           painter: SignalWavePainter(
//             progress: _controller.value,
//             color: widget.color,
//             amplitude: widget.amplitude,
//             frequency: widget.frequency,
//             speed: widget.speed,
//             lines: widget.lines,
//           ),
//           size: size,
//         );
//       },
//     );
//   }
// }

// class SignalWavePainter extends CustomPainter {
//   final double progress;
//   final Color color;
//   final double amplitude;
//   final double frequency;
//   final double speed;
//   final int lines;

//   SignalWavePainter({
//     required this.progress,
//     required this.color,
//     required this.amplitude,
//     required this.frequency,
//     required this.speed,
//     required this.lines,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..isAntiAlias = true
//       ..color = color.withOpacity(0.4)
//       ..strokeWidth = 2
//       ..style = PaintingStyle.stroke;

//     final centerX = size.width / 2;
//     final double phase = progress * 2 * pi * speed;

//     for (int i = -(lines ~/ 2); i <= (lines ~/ 2); i++) {
//       final offsetX = i * (amplitude * 1.5); // jarak antar garis
//       final path = Path();
//       final startX = centerX +
//           offsetX +
//           amplitude * sin((0 * frequency / size.height * 2 * pi) + phase);

//       path.moveTo(startX, 0);

//       for (double y = 0; y <= size.height; y++) {
//         final offset =
//             amplitude * sin((y * frequency / size.height * 2 * pi) + phase);
//         final x = centerX + offsetX + offset;
//         path.lineTo(x, y);
//       }

//       canvas.drawPath(path, paint);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant SignalWavePainter oldDelegate) => true;
// }
