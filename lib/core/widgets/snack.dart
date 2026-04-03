import 'package:flutter/material.dart';

import 'custom_text.dart';

class Snack {

  // ignore: strict_top_level_inference
  void success (context , msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: CustomText(text: msg),
        backgroundColor: Colors.blueGrey,
    ));
  }


  // ignore: strict_top_level_inference
  void error (context , msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: CustomText(text: msg),
      backgroundColor: Colors.red.shade300,
    ));
  }


}
