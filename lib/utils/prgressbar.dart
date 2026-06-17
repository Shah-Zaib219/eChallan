// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sizer/sizer.dart';

class Prgressbar extends StatefulWidget {
  const Prgressbar({
    Key? key,
    required this.flag,
  }) : super(key: key);
  final bool flag;
  @override
  State<Prgressbar> createState() => _PrgressbarState();
}

class _PrgressbarState extends State<Prgressbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0.0, end: widget.flag ? 1.0 : 0.0)
        .animate(_animationController)
      ..addListener(() {
        setState(() {});
      });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 14.h,
          width: 23.w,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: CircularPercentIndicator(
            radius: 40.0,
            backgroundColor: Colors.white,
            lineWidth: 10.0,
            percent: _animation.value,
            center: Text(
              "${(_animation.value * 100).toInt()}%",
              style: TextStyle(fontSize: 22),
            ),
            progressColor: const Color.fromARGB(255, 47, 137, 211),
          ),
        ),
      ],
    );
  }
}
