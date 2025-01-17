import 'package:cosmo_care/core/Constants/ui_constants.dart';
import 'package:cosmo_care/features/customers/model/customer_type_model.dart';
import 'package:cosmo_care/features/customers/model/government_model.dart';
import 'package:cosmo_care/features/customers/model/payment_terms_model.dart';
import 'package:cosmo_care/features/customers/model/sale_zone_model.dart';
import 'package:cosmo_care/features/customers/view/widgets/customer_card.dart';
import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/widgets/widgets/custom_text_field.dart';
import '../../controller/customers_controller.dart';
import '../../controller/get_all_customer_cubit.dart';
import '../../controller/get_all_customers_states.dart';
import 'add_customer_screen.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50.h,
            color: UiConstant.kCosmoCareCustomColors1,
            child:  Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Our Customers'.tr,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: CustomTextField(
                    hintText: "Search here".tr,
                    prefixIconData: Iconsax.search_normal,
                    onChange: (value) async {
                      await BlocProvider.of<GetAllCustomerCubit>(context)
                          .filterCustomers(value);
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () async {
                      await BlocProvider.of<GetAllCustomerCubit>(context)
                          .getAllCustomers();
                    },
                    child: const Icon(
                      Iconsax.refresh,
                      color: UiConstant.kCosmoCareCustomColors1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<GetAllCustomerCubit, GetAllCustomersStates>(
              // future: futureCustomers,
              builder: (context, state) {
                if (state is GetAllCustomersLoadingState) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: UiConstant.kCosmoCareCustomColors1,
                  ));
                } else if (state is GetAllCustomersFailedState) {
                  return  Center(child: Text('Something went wrong please try agin'.tr));
                } else if (state is GetAllCustomersSuccessState) {
                  return ListView.builder(
                    itemCount: BlocProvider.of<GetAllCustomerCubit>(context)
                        .allFilteredCustomers
                        .length,
                    itemBuilder: (BuildContext context, int index) {
                      return CustomerCard(customer: state.customers[index]);
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: EasyButton(
        idleStateWidget: const Icon(
          Iconsax.add,
          color: Colors.white,
        ),
        loadingStateWidget: SizedBox(
          width: 30.w,
          height: 30.h,
          child: const Center(
            child: CircularProgressIndicator(
              strokeWidth: 3.0,
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.white,
              ),
            ),
          ),
        ),
        useWidthAnimation: false,
        width: 60.w,
        height: 60.w,
        buttonColor: UiConstant.kCosmoCareCustomColors1,
        borderRadius: 10,
        onPressed: () async {
          List<CustomerTypeModel> types =
              await CustomersController.getAllCustomerTypes();
          List<PaymentTermsModel> payments =
              await CustomersController.getAllCustomersPaymentTerms();
          List<GovernmentModel> governments =
              await CustomersController.getAllGovernments();
         List<SaleZoneModel> zones =
              await CustomersController.getSaleZones();
          await Get.to(
            () => AddCustomerScreen(
              governments: governments,
              types: types,
              payments: payments,
              saleZone: zones,

            ),
          );
        },
      ),
    );
  }
}
