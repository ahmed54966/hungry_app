import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/features/auth/view/profile_view.dart';
import 'package:hungry/features/cart/view/cart_view.dart';
import 'package:hungry/features/home/view/home_view.dart';
import 'package:hungry/features/order_history/view/order_history.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {

  late PageController? controller ;
  late List <Widget>screens ;
  int currentPage = 0;

  @override
  void initState() {
    screens =  [
    HomeView(),
    OrderHistory(),
    CartView(),
    ProfileView()
  ];
  controller = PageController(initialPage: currentPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller:controller ,
        physics: NeverScrollableScrollPhysics(),
        children: screens,
      ),

      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Theme.of(context).primaryColor
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
            ),
            
        child: BottomNavigationBar(
          currentIndex: currentPage,
          onTap: (index) {
            setState(() {
              currentPage = index;
            });
            controller?.jumpToPage(currentPage);
          },
          
          items: [
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.home),
        label: "Home"),
        
        BottomNavigationBarItem(icon: Icon(Icons.local_restaurant_sharp),
        label: "Order History"),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.cart),
        label: "Cart"),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled),
        label: "Profile"),
      ]
      ),
          ),
      ),
    );
  }
}