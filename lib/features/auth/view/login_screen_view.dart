import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/styling/app_assets.dart';
import 'package:hungry/core/styling/app_colors.dart';
import 'package:hungry/core/widgets/custom_elvated_button.dart';
import 'package:hungry/core/widgets/custom_text_form_field.dart';
import 'package:hungry/core/widgets/dialog_utilies.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/network/api_error.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool showPassword = true;
  var formKey = GlobalKey<FormState>();
  TextEditingController emailControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  AuthRepo authRepo = AuthRepo();
  


  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        
            backgroundColor: AppColors.whiteColor,
            
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Gap(180),
      
                
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(AppAssets.logo,
                    width: 50,  
                    height: 50, 
                    fit: BoxFit.contain,
                    // ignore: deprecated_member_use
                    color: AppColors.primaryColor,),
                    
                  ),
      
                  Center(
                    child: Text("Welcome Back,Discover the Fast Foot",
                    style:Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.primaryColor,fontSize: 10) ,),
                  ),
                  Gap(100),
                
                Container(
                  height: 700.h,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    border: Border.all(color: AppColors.redColor,width: 2),
                    
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Column(
                    children: [
                      CustomTextFormField(hintText: "Enter your Email",controller:emailControler ,
                keyboardType:TextInputType.emailAddress ,
                validator: (text) {
                  if (text == null || text.trim().isEmpty){
                    return "please enter Email .";
                  }
                  final bool emailValid = 
                    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(text);
                    if(!emailValid){
                      return "plaease enter valid email.";
                    }
                  return null ;
                },),
                CustomTextFormField(hintText:  "Enter your password",controller:passwordControler ,
                keyboardType:TextInputType.visiblePassword ,
                      showPassword: showPassword,
                      suffixIcon: IconButton(
                      icon: Icon(
                            
                            showPassword ? Icons.visibility_off : Icons.visibility,
                            color:AppColors.primaryColor,
                      ),
                      onPressed: () {
                            
                            setState(() {
                  showPassword = !showPassword;
                            });}),
                validator: (text) {
                  if (text == null || text.trim().isEmpty){
                    return "please enter password.";
                  }
                  if (text.length < 6){
                    return "password should be at least 6 chars.";
                  }
                  return null ;
                },),
                
                
                SizedBox(
                  width: double.infinity,
                  child: CustomElvatedButton(backGroundColor: AppColors.redColor, 
                  forGroundColor: AppColors.redColor, 
                  borderRadius: 15, 
                  paddingHorizontal: 30, 
                  paddingVertical: 15, 
                  text: "Login", 
                  fun: () => login(),
                  textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.whiteColor),
                  borderColor: AppColors.redColor,),
                ),
                Row(
                children: [
                  Expanded(
                    child: 
                        CustomElvatedButton(backGroundColor: AppColors.redColor, 
                        forGroundColor: AppColors.redColor, 
                        borderRadius: 15, 
                        paddingHorizontal: 20, 
                        paddingVertical: 10, 
                        text: "Create Account", 
                        fun: () => context.pushNamed('/registerScreen'),
                        textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.whiteColor),
                        borderColor: AppColors.redColor,),
                  ),
              Expanded(
                child: CustomElvatedButton(backGroundColor: AppColors.redColor, 
                forGroundColor: AppColors.redColor, 
                borderRadius: 15, 
                paddingHorizontal: 20, 
                paddingVertical: 10, 
                text: "Continue As a Guest", 
                fun: () => context.pushNamed('/rootView'),
                textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.whiteColor),
                borderColor: AppColors.redColor,),
                
              )
                ],
              )
                ],
                  ),
                ),
      
      
              ],
            ),
          )),
      
      
      
      
      
      
      
      
          ),
    );

  }
  Future<void> login() async {
  if (formKey.currentState?.validate() == true) {
    try {

      DialogUtiles.ShowLoading(context: context, message: "loading...");

      final user = await authRepo.login(
        emailControler.text.trim(), 
        passwordControler.text.trim(),
      );

      
      if (!context.mounted) return;
      DialogUtiles.hideDialog(context); 

      if (user != null) {
        
        context.go("/rootView"); 
      }
    } catch (e) {
      if (!context.mounted) return;

      
      DialogUtiles.hideDialog(context);

    
      String displayMessage = "Something went wrong";
      if (e is ApiError) {
        displayMessage = e.message;
      } else {
        displayMessage = e.toString();
      }

      DialogUtiles.showMessage(
        context: context,
        message: displayMessage, 
        title: "Error",
        posActionName: "ok",
      );
    }
  }
}



}