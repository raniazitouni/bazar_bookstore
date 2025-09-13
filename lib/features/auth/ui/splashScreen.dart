import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bazar_bookstore/core/theme/app_colors.dart';
import 'package:bazar_bookstore/features/auth/controllers/auth_controller.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

     Future.microtask(() {
      final authState = ref.read(authControllerProvider);

      // check if the user is logged in or not
      authState.when(
        data: (session) {
          Future.delayed(const Duration(seconds: 2), () {
            if (session != null) {
              Navigator.pushReplacementNamed(context, "/signUp");
            } else {
              Navigator.pushReplacementNamed(context, "/login");
            }
          });
        },
        loading: () {
        },
        error: (err, _) {
          Navigator.pushReplacementNamed(context, "/login");
        },
      );

      //keep listening for future changes
      ref.listen<AsyncValue<Session?>>(authControllerProvider, (
        previous,
        next,
      ) {
        next.when(
          data: (session) {
            if (session != null) {
              Navigator.pushReplacementNamed(context, "/home");
            } else {
              Navigator.pushReplacementNamed(context, "/login");
            }
          },
          loading: () {},
          error: (err, _) {
            Navigator.pushReplacementNamed(context, "/login");
          },
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primary,
      body: Center(
        child: SvgPicture.asset(
          'assets/icons/app_logo.svg',
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
