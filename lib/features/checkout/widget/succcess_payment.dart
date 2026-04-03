import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const SuccessDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
      
            Container(
              width: 90, height: 90,
              decoration: const BoxDecoration(
                color: Color(0xFF0F4A23),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 50),
            ),
            const Gap(20),
            const Text(
              "Success !",
              style: TextStyle(
                fontSize: 26, 
                fontWeight: FontWeight.bold, 
                color: Color(0xFF0D321A),
              ),
            ),
            const Gap(10),
            const Text(
              "Your payment was successful.\nA receipt for this purchase has\nbeen sent to your email.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, height: 1.4),
            ),
            const Gap(30),
            
            ElevatedButton(
              onPressed: () {
                context.pop(); 
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F4A23),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: const Text(
                "Go Back", 
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    )
        ],
      ),
    );
    
  }
}