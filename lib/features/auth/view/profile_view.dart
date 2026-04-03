import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/styling/app_colors.dart';
import 'package:hungry/core/widgets/custom_elvated_button.dart';
import 'package:hungry/core/widgets/custom_material_text_form.dart';
import 'package:hungry/core/widgets/dialog_utilies.dart';
import 'package:hungry/features/auth/data/auth_model.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/features/auth/widget/payment.dart';
import 'package:hungry/network/api_error.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';


class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController visaController = TextEditingController();
  final AuthRepo authRepo = AuthRepo();
  AuthModel? authModel;
  bool isLoading = true; 
  bool isGuest = false;

  @override
  void initState() {
    super.initState();
    autoLogin();
    getProfileData();
  }
  String? selectedImage;
  Future<void> _pickImage() async {
    final image = await ImagePicker().pickImage(source:ImageSource.gallery);
    setState(() {
      if(image != null){
        selectedImage = image.path;
      }
      
    });
  }
  Future<void> autoLogin() async {
    final user = await authRepo.autoLogin();
    setState(() {
      isGuest = authRepo.isGuest;
    });
    if(user != null){
      setState(() {
        authModel =user;
      });
    }
  }

  Future<void> getProfileData() async {
    try {
      
      final user = await authRepo.getProfileData();

      if (user != null) {
        if (!mounted) return;
        setState(() {
          authModel = user;
          nameController.text = user.name ;
          emailController.text = user.email ;
          addressController.text = user.address ?? "";
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

  Future<void> updateProfileData() async {
  try {
    DialogUtiles.ShowLoading(context: context, message: "Updating...");

    final user = await authRepo.updateProfileData(
      emailController.text,
      nameController.text,
      addressController.text,
      visaController.text,
      selectedImage, 
    );

    DialogUtiles.hideDialog(context);
    if (!mounted) return;
    context.pop(context); 

    if (user != null) {
      setState(() {
        authModel = user;
      });
      
      DialogUtiles.showMessage(context: context, message: "Profile Updated!", title: "Success", posActionName: "OK");
    }
  } catch (e) {
    DialogUtiles.hideDialog(context);
    if (!mounted) return;
    context.pop(context); 

    String displayMessage = e is ApiError ? e.message : "something went wrong";
    DialogUtiles.showMessage(
      context: context,
      message: displayMessage,
      title: "Error",
      posActionName: "ok",
    );
  }
}

Future<void> logOut() async {
  try {
    await authRepo.logOut();
    
  } catch (e) {
    DialogUtiles.hideDialog(context);
    if (!mounted) return;

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
  Widget build(BuildContext context) {
    if(!isGuest){
      return RefreshIndicator(
      color: AppColors.primaryColor,
      displacement: 50,
      onRefresh: ()async {
        await getProfileData();
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.primaryColor,
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            elevation: 0,
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: Icon(Icons.arrow_back, color: AppColors.whiteColor),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Icon(Icons.settings, size: 30, color: AppColors.whiteColor),
              )
            ],
          ),
          body: Skeletonizer(
            enabled: isLoading,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Gap(20),
                  Center(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.grayColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: _buildImageWidget(), 
                      ),
                    )
                  ),
                  const Gap(10),
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(onPressed: (){
                      _pickImage();
                  },
                
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15), 
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),),
                backgroundColor: AppColors.whiteColor,
                foregroundColor: AppColors.whiteColor),
                
                  child: Text("Change Photo",
                  style: Theme.of(context).textTheme.bodySmall,)),
                ),
                  const Gap(20),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        MyCustomTextField(label: "Name", controller: nameController),
                        const Gap(15),
                        MyCustomTextField(label: "Email", controller: emailController),
                        const Gap(15),
                        MyCustomTextField(label: "Address", controller: addressController),
                        const Gap(20),
                        Divider(thickness: 1, color: AppColors.whiteColor),
                        const Gap(20),
                        authModel?.visa == null?
                        MyCustomTextField(label: "Visa Number", 
                        controller: visaController,
                        keyboardType: TextInputType.number,):
                        DebitCardWidget(
                          text: authModel?.visa ?? "**** **** **** 0000",
                        ),
                        const Gap(130),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomSheet: _buildBottomSheet(),
        ),
      ),
    );
    }else if (isGuest){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Guest Mode"),),
                CustomElvatedButton(backGroundColor: AppColors.primaryColor, 
                        forGroundColor: AppColors.primaryColor, 
                        borderRadius: 15, 
                        paddingHorizontal: 30,
                        fun: () => context.pushNamed('/registerScreen'), 
                        paddingVertical: 15, 
                        text: "Register Screen", 
                        textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.whiteColor),
                        borderColor: AppColors.redColor,),

                        CustomElvatedButton(backGroundColor: AppColors.primaryColor, 
                        forGroundColor: AppColors.primaryColor, 
                        borderRadius: 15, 
                        paddingHorizontal: 30,
                        fun: () => context.pushNamed('/loginScreen'), 
                        paddingVertical: 15, 
                        text: "Login Screen", 
                        textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.whiteColor),
                        borderColor: AppColors.redColor,),
        ],
      );

    }
    return Gap(10);
  }

  Widget _buildBottomSheet() {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: AppColors.whiteColor,
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                updateProfileData();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.grayColor,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: Text("Edit Profile", style: TextStyle(color: AppColors.whiteColor)),
            ),
          ),
          const Gap(20),
          Expanded(
            child: ElevatedButton(
              onPressed: () => logOut(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: Text("Log Out", style: TextStyle(color: AppColors.whiteColor)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

Widget _buildImageWidget() {
  
  if (selectedImage != null && selectedImage!.isNotEmpty) {
    return Image.file(
      File(selectedImage!), 
      fit: BoxFit.cover,
    );
  }

  
  if (authModel?.image != null && authModel!.image!.isNotEmpty) {
    return Image.network(
      authModel!.image!,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => 
          const Icon(Icons.person, size: 50, color: AppColors.whiteColor),
    );
  }

  return const Icon(Icons.person, size: 50, color: AppColors.whiteColor);
}
}