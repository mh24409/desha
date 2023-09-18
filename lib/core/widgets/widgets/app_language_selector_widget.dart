// ignore_for_file: use_build_context_synchronously
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../features/products/controller/categories_cubit.dart';
import '../../utils/app_languages/controller/app_langauge_controller.dart';

class AppLanguageSelectorWidget extends StatelessWidget {
  const AppLanguageSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppLanguageController>(
      init: AppLanguageController(),
      builder: (controller) => DropdownButtonHideUnderline(
        child: DropdownButton2(
          hint: Align(
            alignment: AlignmentDirectional.center,
            child: Text(
              'Select Language',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
          ),
          isExpanded: true,
          items: const [
            DropdownMenuItem<String>(
              value: "en",
              child: Align(
                alignment: AlignmentDirectional.center,
                child: Text(
                  "English",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            DropdownMenuItem<String>(
              value: "ar",
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "عربي",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
          value: controller.currentAppLanguage,
          onChanged: (value) async {
            controller.changeSelectedLanguage(value!);
            await Get.updateLocale(Locale(value));
            await BlocProvider.of<CategoriesCubit>(context)
                .getProductDividedByCategories();
          },
          buttonStyleData: ButtonStyleData(width: 100.w),
        ),
      ),
    );
  }
}
