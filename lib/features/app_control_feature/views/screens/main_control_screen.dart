// ignore_for_file: prefer_collection_literals
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/Constants/ui_constants.dart';
import '../../../../core/widgets/widgets/app_language_selector_widget.dart';
import '../../../auth/view/screens/profile_screen.dart';
import '../../../customers/view/screens/customer_screen.dart';
import '../../../map/views/screens/map_screen.dart';
import '../../../products/views/screens/product_divided_by_category_screen.dart';
import '../../controllers/main_view_control_cubit.dart';
import '../../controllers/main_view_control_state.dart';

class MainControlScreen extends StatefulWidget {
  const MainControlScreen({Key? key}) : super(key: key);

  @override
  State<MainControlScreen> createState() => _MainControlScreenState();
}

class _MainControlScreenState extends State<MainControlScreen> {
  int notificationBadgeCount = 0;
  Set<String> processedMessageIds = Set();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: BlocBuilder<MainViewControlCubit, MainControlViewState>(
          builder: (context, state) {
            if (state is AccountViewStates) {
              return Text(
                "Profile".tr,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              );
            } else if (state is ProductViewStates) {
              return Text(
                "Products".tr,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              );
            } else if (state is CustomersViewStates) {
              return Text(
                "Customers".tr,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              );
            } else {
              return Text(
                "Map".tr,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              );
            }
          },
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: const [
          AppLanguageSelectorWidget(),
        ],
      ),
      bottomNavigationBar:
          BlocBuilder<MainViewControlCubit, MainControlViewState>(
        builder: (context, state) {
          return BottomNavigationBar(
            onTap: (index) {
              context
                  .read<MainViewControlCubit>()
                  .changeSelectedIndexForBottomBar(index);
            },
            currentIndex:
                context.read<MainViewControlCubit>().selectedIndexForBottomBar,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Iconsax.user),
                label: 'account'.tr,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Iconsax.category),
                label: 'products'.tr,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Iconsax.people),
                label: 'customers'.tr,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Iconsax.map),
                label: 'map'.tr,
              ),
            ],
            type: BottomNavigationBarType.shifting,
            selectedItemColor: UiConstant.kCosmoCareCustomColors1,
            unselectedItemColor: Colors.black,
          );
        },
      ),
      body: BlocBuilder<MainViewControlCubit, MainControlViewState>(
        builder: (context, state) {
          if (state is AccountViewStates) {
            return const ProfileScreen();
          } else if (state is ProductViewStates) {
            return const ProductDividedByCateScreen();
          } else if (state is CustomersViewStates) {
            return const CustomersScreen();
          } else {
            return const MapScreen();
          }
        },
      ),
    );
  }
}
