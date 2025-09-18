import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class VendorCategoryScreen extends ConsumerStatefulWidget {
  const VendorCategoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VendorCategoryScreenState();
}

class _VendorCategoryScreenState extends ConsumerState<VendorCategoryScreen> {

  @override
  Widget build(BuildContext context) {
    return Center(child:  Text("see all vendors"));
  }
}