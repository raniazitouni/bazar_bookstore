import 'package:bazar_bookstore/features/authors/ui/AuthorCategoryScreen.dart';
import 'package:bazar_bookstore/features/books/ui/BookCategoryScreen.dart';
import 'package:bazar_bookstore/features/vendors/ui/VendorCategoryScreen.dart';
import 'package:bazar_bookstore/features/whishlists/ui/wishlistScreen.dart';
import 'package:bazar_bookstore/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bazar_bookstore/features/auth/ui/loginScreen.dart';
import 'package:bazar_bookstore/features/auth/ui/SignUpScreen.dart';
import 'package:bazar_bookstore/features/auth/ui/SplashScreen.dart';

Future<void> main() async {
  //to ensure that flutter is ready before supabase initialization
  WidgetsFlutterBinding.ensureInitialized();

  // Load .env variables
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_API_URL']!,
    anonKey: dotenv.env['API_ANON_KEY']!,
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/splash",
      routes: {
        "/splash": (context) => SplashScreen(),
        "/login": (context) => LoginScreen(),
        "/signUp": (context) => SignUpScreen(),
        "/home": (context) => MainScreen(),
        "/books": (context) => BookCategoryScreen(),
        "/authors": (context) => AuthorCategoryScreen(),
        "/vendors": (context) => VendorCategoryScreen(),
        "/wishlist": (context) => WishlistScreen(),
      },
    );
  }
}
