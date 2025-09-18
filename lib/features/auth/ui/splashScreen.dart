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
      ref.listen<AsyncValue<Session?>>(authControllerProvider, (
        previous,
        next,
      ) {
        next.when(
          data: (session) {
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.pushReplacementNamed(
                context,
                session != null ? "/home" : "/login",
              );
            });
          },
          error: (_, __) {
            ref.read(authControllerProvider.notifier).signOut();
            Navigator.pushReplacementNamed(context, "/login");
          },
          loading: () {},
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
