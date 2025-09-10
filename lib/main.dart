import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://ppxjlrvmirqtuusfddax.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBweGpscnZtaXJxdHV1c2ZkZGF4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTcwMDgyNTUsImV4cCI6MjA3MjU4NDI1NX0.jjH6X79_VjxyI60s3Hx8oC_q8oNmxUSItxjJFRh5hSc',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: );

  }
}
