import 'package:default_app/pages/screens/home/widgets/glucose_card.dart';
import 'package:default_app/pages/screens/home/widgets/user_info_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:default_app/common/widgets/circular_conatiner.dart';
import 'package:default_app/constants/colors.dart';

import '../../../../common/widgets/curved_edges.dart';


class HomeHeader extends StatelessWidget {
  final String greeting;
  final User user;
  static const _deepBlue = MColors.primary;

  const HomeHeader({super.key, required this.greeting, required this.user});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final headerHeight = screenSize.height * 0.55;

    return CurvedEdgeWidget(
      child: Container(
        color: _deepBlue,
        padding: EdgeInsets.zero,
        child: SizedBox(
          height: headerHeight,
          child: Stack(
            children: [
              // Background circles
              Positioned(
                top: -headerHeight * 0.375,
                right: -screenSize.width * 0.375,
                child: CircularContainer(
                  backgroundColor: MColors.textWhite.withValues(alpha: 0.1),
                ),
              ),
              Positioned(
                top: headerHeight * 0.25,
                right: -screenSize.width * 0.75,
                child: CircularContainer(
                  backgroundColor: MColors.textWhite.withValues(alpha: 0.1),
                ),
              ),

              // Header content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).padding.top + 16),
                    UserInfoBar(greeting: greeting, user: user),
                    const SizedBox(height: 24),
                    Expanded(child: GlucoseCardSection()),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}