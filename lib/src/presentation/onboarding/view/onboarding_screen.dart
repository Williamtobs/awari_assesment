import 'package:flutter/material.dart';
import 'package:lumi_fashion_mobile/src/core/constants/app_colors.dart';
import 'package:lumi_fashion_mobile/src/presentation/onboarding/widgets/custom_marquee.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final height = constraints.maxHeight;
          final width = constraints.maxWidth;

          return Column(
            children: [
              Container(
                width: double.infinity,
                height: height * 0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  image: const DecorationImage(
                    image: AssetImage('assets/bg_pose.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 50,
                      child: Text(
                        'Lumière',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.foregroundColor,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -70,
                      child: Text(
                        'Lumière',
                        style: TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.w600,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 1.8
                            ..color = AppColors.foregroundColor.withValues(
                              alpha: 0.85,
                            ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: height * 0.15,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.bgColor, width: 4),
                ),
                child: CustomMarquee(
                  speed: 100,
                  spacing: 50,
                  direction: MarqueeDirection.rightToLeft,
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'TRENDY COUTURE',
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: width * 0.18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.bgColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.11,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {},
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 12.0,
                      ),
                      child: Text(
                        'Discover Now',
                        style: TextStyle(
                          fontSize: (height * 0.11 * 0.35).clamp(12, 24),
                          fontWeight: FontWeight.bold,
                          color: AppColors.bgColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
            ],
          );
        },
      ),
    );
  }
}
