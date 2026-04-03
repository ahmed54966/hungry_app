import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/styling/app_assets.dart';
import 'package:hungry/core/styling/app_colors.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';

class Splashview extends StatefulWidget {
  const Splashview({super.key});

  @override
  State<Splashview> createState() => _SplashviewState();
}

class _SplashviewState extends State<Splashview> {
  double _opacity = 0.0;
  double _burgerOffset = 200.0;

  AuthRepo authRepo = AuthRepo();

  Future<void> checkedLogin() async {
  
  final user = await authRepo.autoLogin();

  if (!mounted) return;

  
  if (user != null) {
    
    context.go("/rootView");
  } else if (authRepo.isGuest) {
    
    context.go("/rootView");
  } else {
    
    context.go("/loginScreen");
  }
}


  @override
  void initState() {
    super.initState();

  
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _opacity = 1.0; 
          _burgerOffset = 0.0; 
        });
      }
    });

    
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        checkedLogin();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack( 
        children: [
        
          Center(
            child: AnimatedOpacity(
              duration: const Duration(seconds: 1), 
              opacity: _opacity,
              child: SvgPicture.asset(
                AppAssets.logo,
                width: 180, 
              ),
            ),
          ),

          
          AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutBack,
            bottom: -_burgerOffset, 
            left: 0,
            right: 0,
            child: Image.asset(
              AppAssets.bergar,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}