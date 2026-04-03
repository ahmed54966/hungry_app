import 'package:flutter/material.dart';
import 'package:hungry/core/widgets/dialog_utilies.dart';
import 'package:hungry/features/auth/data/auth_model.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/network/api_error.dart';

class PaymentSelectionScreen extends StatefulWidget {
  const PaymentSelectionScreen({super.key});

  @override
  State<PaymentSelectionScreen> createState() => _PaymentSelectionScreenState();
}

class _PaymentSelectionScreenState extends State<PaymentSelectionScreen> {
  
  String selectedMethod = "cash";
  bool isLoading = true;
  final AuthRepo authRepo = AuthRepo();
  AuthModel? authModel;
  Future<void> getProfileData() async {
    try {
      
      final user = await authRepo.getProfileData();

      if (user != null) {
        if (!mounted) return;
        setState(() {
          authModel = user;
          isLoading = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => isLoading = false);
      
      String displayMessage = e is ApiError ? e.message : "something went wrong";
      DialogUtiles.showMessage(
        context: context,
        message: displayMessage,
        title: "Error",
        posActionName: "ok",
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return 
      
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildPaymentCard(
                id: "cash",
                title: "Cash on Delivery",
                icon: Icons.attach_money,
                iconColor: const Color(0xFF264E03), 
                isDark: true,
              ),
        
              const SizedBox(height: 15),
        
              (isLoading && authModel?.visa == null) ?
              SizedBox():
              _buildPaymentCard(
                id: "visa",
                title: "Debit card",
                subtitle: authModel?.visa??"3566 **** **** 0505",
                isVisa: true,
                isDark: false,
              ),
            ],
          ),
        ),
      );
    
  }
  
  Widget _buildPaymentCard({
    required String id,
    required String title,
    String? subtitle,
    IconData? icon,
    Color? iconColor,
    bool isVisa = false,
    required bool isDark,
  }) {
    bool isActive = selectedMethod == id;

    return GestureDetector(
      onTap: () => setState(() => selectedMethod = id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          
          color: isDark ? const Color(0xFF2D2626) : const Color(0xFFF4F5F7),
          borderRadius: BorderRadius.circular(20),
          
          border: Border.all(
            color: (isActive && !isDark) ? Colors.blue : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isVisa ? Colors.white : iconColor,
                shape: BoxShape.circle,
                boxShadow: isVisa ? [BoxShadow(color: Colors.black12, blurRadius: 4)] : [],
              ),
              child: isVisa 
                  ? const Center(child: Text("VISA", style: TextStyle(color: Color(0xFF1A1F71), fontWeight: FontWeight.bold, fontSize: 12)))
                  : Icon(icon, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 15),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: TextStyle(color: Colors.grey[500], fontSize: 13),
                    ),
                ],
              ),
            ),
            
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDark ? Colors.white : Colors.grey.shade300,
                  width: 2,
                ),
              ),
              child: isActive 
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white : Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}