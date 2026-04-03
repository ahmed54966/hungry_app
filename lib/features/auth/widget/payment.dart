import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DebitCardWidget extends StatelessWidget {
  String text;
  DebitCardWidget({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 100), 
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          
          const SizedBox(
            width: 70,
            child: Text(
              'VISA',
              style: TextStyle(
                color: Color(0xFF01579B),
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const SizedBox(width: 15),
          
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, 
              children: [
                const Text(
                  'Debit card',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 1, 
                  overflow: TextOverflow.ellipsis, 
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  maxLines: 1,
                  overflow: TextOverflow.clip, 
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 10),
          
          
          _buildRadioIcon(),
        ],
      ),
    );
  }

  Widget _buildRadioIcon() {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF1B5E20), width: 2),
      ),
      child: Center(
        child: Container(
          width: 12,
          height: 12,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF1B5E20),
          ),
        ),
      ),
    );
  }
}