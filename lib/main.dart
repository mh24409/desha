import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'core/Constants/ui_constants.dart';
import 'core/utils/app_languages/controller/binding.dart';
import 'core/utils/app_languages/translation/translation.dart';
import 'features/app_control_feature/controllers/main_view_control_cubit.dart';
import 'features/auth/controller/auth_cubit.dart';
import 'features/auth/controller/user_cubit.dart';
import 'features/check_in_tracking/controller/track_check_cubit.dart';
import 'features/customers/controller/get_all_customer_cubit.dart';
import 'features/orders/controller/cubit/user_sale_orders_cubit.dart';
import 'features/products/controller/categories_cubit.dart';
import 'features/splash_view/screens/cosmo_care_splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const CosmoCareTrackingApp());
}

class CosmoCareTrackingApp extends StatelessWidget {
  const CosmoCareTrackingApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit()..onSplashViewScreenLaunch(context),
        ),
        BlocProvider<UserCubit>(
          create: (context) => UserCubit()..getCurrentUserInfo(),
        ),
        BlocProvider<MainViewControlCubit>(
          create: (context) => MainViewControlCubit(),
        ),
        BlocProvider<GetAllCustomerCubit>(
          create: (context) => GetAllCustomerCubit()..getAllCustomers(),
        ),
        BlocProvider<CategoriesCubit>(
          create: (context) =>
              CategoriesCubit()..getProductDividedByCategories(),
        ),
        BlocProvider<TrackCheckingCubit>(
          create: (context) => TrackCheckingCubit(),
        ),
        BlocProvider<UserSaleOrdersCubit>(
          create: (context) => UserSaleOrdersCubit()..getCurrentUserSaleOrders(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) => GetMaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            primaryColor: UiConstant.kCosmoCareCustomColors1,
            fontFamily: "Gilory",
          ),
          debugShowCheckedModeBanner: false,
          initialBinding: Binding(),
          translations: Translation(),
          locale: Locale(Get.deviceLocale!.languageCode),
          fallbackLocale: const Locale("en"),
          home: const CosmoCareSplashScreen(),
        ),
      ),
    );
  }
}
