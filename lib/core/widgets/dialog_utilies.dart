import 'package:flutter/material.dart';
import 'package:hungry/core/styling/app_colors.dart';

class DialogUtiles {
  // ignore: non_constant_identifier_names
  static void ShowLoading({required BuildContext context , required String message}){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context){
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor), 
                backgroundColor: Colors.grey[200], 
                strokeWidth: 3,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(message,
                style: Theme.of(context).textTheme.titleMedium,),
              )
            ],
          ),
        );
      }
      );
  }

  static void hideDialog(BuildContext context){
    
  } 

  static void showMessage ({required BuildContext context ,
  required String message ,
    required String title ,
    String? posActionName,
    Function? posAction,
    String? negActionName,
    Function? negAction
    }){

    List <Widget> actions = [];
    
    if (posActionName != null){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        posAction?.call();
      },
      child: Text(posActionName,style: Theme.of(context).textTheme.bodyMedium,)));
    }

    if (negActionName != null){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        posAction?.call();
      },
      child: Text(negActionName)));
    }    


    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          content: 
                Text(message,
                style: Theme.of(context).textTheme.titleMedium,),
                title: Text(title,
                style: Theme.of(context).textTheme.titleMedium ,),
                actions: actions,
              );
      }
        );
      }
  }
