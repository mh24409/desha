// ignore_for_file: deprecated_member_use

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cosmo_care/core/Constants/assets_path_constants.dart';
import 'package:cosmo_care/core/Constants/ui_constants.dart';
import 'package:cosmo_care/core/shared/global_variables.dart' as global;
import 'package:cosmo_care/core/widgets/widgets/vertical_spacer.dart';
import 'package:cosmo_care/features/check_in_tracking/controller/track_check_cubit.dart';
import 'package:cosmo_care/features/check_in_tracking/controller/track_check_states.dart';
import 'package:cosmo_care/features/customers/view/widgets/details_row.dart';
import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/widgets/widgets/custom_button_widget.dart';
import '../../../orders/controller/order_controller.dart';
import '../../../orders/model/customer_products_model.dart';
import '../../../orders/views/screens/sale_order_line_screen.dart';
import '../../model/customer_model.dart';

class CustomerDetailsScreen extends StatefulWidget {
  final CustomerModel customer;

  const CustomerDetailsScreen({super.key, required this.customer});

  @override
  // ignore: library_private_types_in_public_api
  _CustomerDetailsScreenState createState() => _CustomerDetailsScreenState();
}

// ignore: constant_identifier_names
enum DetailsView { CustomerDetails, Responsibility, Owner }

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  DetailsView _currentView = DetailsView.CustomerDetails;
  bool isCheckIn = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getCheckInState();
    });
  }

  _getCheckInState() async {
    await BlocProvider.of<TrackCheckingCubit>(context)
        .getCustomerTrackCheckingState(widget.customer.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1.0,
        title: Text(
          'Customer Details'.tr,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.customer.title,
                      style: TextStyle(
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Iconsax.location,
                      color: UiConstant.kCosmoCareCustomColors1,
                    ),
                    onPressed: () async {
                      final url =
                          'https://www.google.com/maps/search/?api=1&query=${widget.customer.lat},${widget.customer.lng}';
                      if (await canLaunch(url)) {
                        await launch(url);
                      }
                    },
                  ),
                ],
              ),
            ),
            ConditionalBuilder(
              condition: widget.customer.image != null &&
                  widget.customer.image!.isNotEmpty,
              builder: (context) => Image(
                image: NetworkImage(widget.customer.image!),
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width * 0.7,
                fit: BoxFit.contain,
              ),
              fallback: (context) => Image(
                image: const AssetImage(AssetsPathConstants.kProfile),
                height: 200.w,
                width: 200.w,
                fit: BoxFit.contain,
              ),
            ),
            VerticalSpacer(10.h),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor:
                          _currentView == DetailsView.CustomerDetails
                              ? UiConstant.kCosmoCareCustomColors1
                              : const Color(0xff005469),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    onPressed: () {
                      setState(() {
                        _currentView = DetailsView.CustomerDetails;
                      });
                    },
                    child: Text(
                      'Customer Details'.tr,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor:
                          _currentView == DetailsView.Responsibility
                              ? UiConstant.kCosmoCareCustomColors1
                              : const Color(0xff005469),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    onPressed: () {
                      setState(() {
                        _currentView = DetailsView.Responsibility;
                      });
                    },
                    child: Text(
                      'Responsibility'.tr,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: _currentView == DetailsView.Owner
                          ? UiConstant.kCosmoCareCustomColors1
                          : const Color(0xff005469),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    onPressed: () {
                      setState(() {
                        _currentView = DetailsView.Owner;
                      });
                    },
                    child: Text(
                      'Owner'.tr,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Flexible(child: _buildDetailsContent()),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.h,
                horizontal: 10.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: EasyButton(
                      idleStateWidget: Text(
                        'Add Order'.tr,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      loadingStateWidget: const CircularProgressIndicator(
                        strokeWidth: 3.0,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      ),
                      useWidthAnimation: true,
                      useEqualLoadingStateWidgetDimension: true,
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 45.h,
                      contentGap: 6.0,
                      buttonColor: UiConstant.kCosmoCareCustomColors1,
                      borderRadius: 20,
                      onPressed: () async {
                        if (OrderController.inSaveZoneToCreateOrder(
                          customerLat: widget.customer.lat,
                          customerLong: widget.customer.lng,
                          currentLat: global.currentUserLat,
                          currentLong: global.currentUserLong,
                        )) {
                          List<CustomerProductsModel> offers =
                              await OrderController.getCustomerOffers(
                                  customerId: widget.customer.id);
                          Get.to(
                            () => SaleOrderLineScreen(
                              customerId: widget.customer.id,
                              offers: offers,
                            ),
                          );
                        } else {
                          Get.snackbar(
                            "Can't Create Order".tr,
                            "You mustn't be in a distance more than 500m from the customer"
                                .tr,
                            backgroundColor: Colors.red,
                            duration: const Duration(
                              seconds: 5,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  Flexible(child: SizedBox(width: 1.w)),
                  BlocBuilder<TrackCheckingCubit, TrackCheckingStates>(
                      builder: (trackCheckingContext, trackCheckingState) {
                    if (trackCheckingState is TrackCheckingSuccessState) {
                      isCheckIn = trackCheckingState.isCheckIn;
                      return Flexible(
                        child: CustomButton(
                          buttonWidth: 0.6.sw,
                          buttonHeight: 45.h,
                          buttonBorderRadius: 20.r,
                          buttonMargin: 0,
                          buttonTextFontSize: 14.sp,
                          buttonText:
                              (isCheckIn) ? 'Check out'.tr : 'Check in'.tr,
                          buttonAction: () async {
                            if (OrderController.inSaveZoneToCreateOrder(
                              customerLat: widget.customer.lat,
                              customerLong: widget.customer.lng,
                              currentLat: global.currentUserLat,
                              currentLong: global.currentUserLong,
                            )) {
                              await BlocProvider.of<TrackCheckingCubit>(context)
                                  .trackChecking(isCheckIn, widget.customer.lat,
                                      widget.customer.lng, widget.customer.id);
                              Get.snackbar(
                                  (isCheckIn) ? "Check out".tr : "Check in".tr,
                                  "Changed customer status successfully".tr,
                                  backgroundColor: Colors.green);
                            } else {
                              Get.snackbar(
                                "Can't check in".tr,
                                "You mustn't be in a distance more than 500m from the customer"
                                    .tr,
                                backgroundColor: Colors.red,
                                duration: const Duration(
                                  seconds: 5,
                                ),
                              );
                            }
                          },
                          buttonColor: UiConstant.kCosmoCareCustomColors1,
                        ),
                      );
                    } else {
                      return const Flexible(
                        child: CircularProgressIndicator(
                          strokeWidth: 3.0,
                        ),
                      );
                    }
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsContent() {
    switch (_currentView) {
      case DetailsView.CustomerDetails:
        String governmentAndCity = (widget.customer.government != null)
            ? widget.customer.government!.title ?? ""
            : "";
        governmentAndCity += " - ";
        governmentAndCity += (widget.customer.city != null)
            ? widget.customer.city!.title ?? ""
            : "";
        return Padding(
          padding: EdgeInsets.all(12.h),
          child: ListView(
            children: [
              DetailRow(
                  icon: Iconsax.message,
                  detailText: widget.customer.email ?? "N/A"),
              DetailRow(
                  icon: Iconsax.mobile,
                  detailText: widget.customer.phone ?? "N/A"),
              DetailRow(
                icon: Iconsax.location,
                detailText: widget.customer.address,
              ),
              DetailRow(
                icon: Icons.location_city_rounded,
                detailText: governmentAndCity,
              ),
              DetailRow(
                icon: Iconsax.link,
                detailText: widget.customer.website ?? "N/A",
              ),
              DetailRow(
                icon: Iconsax.card,
                detailText: widget.customer.paymentTerms?.title ?? "N/A",
              ),
            ],
          ),
        );

      case DetailsView.Responsibility:
        if (widget.customer.responsiblies != null &&
            widget.customer.responsiblies!.isNotEmpty) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.35,
            ),
            child: CarouselSlider.builder(
              itemCount: widget.customer.responsiblies!.length,
              slideBuilder: (index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView(
                    children: <Widget>[
                      Text(
                          '${"Name:".tr} ${widget.customer.responsiblies![index].name ?? 'N/A'}'),
                      Divider(
                        color: Colors.grey.shade200,
                      ),
                      Text(
                          '${"Mobile:".tr} ${widget.customer.responsiblies![index].mobile ?? 'N/A'}'),
                      Divider(
                        color: Colors.grey.shade200,
                      ),
                      Text(
                          '${"Email:".tr} ${widget.customer.responsiblies![index].email ?? 'N/A'}'),
                      Divider(
                        color: Colors.grey.shade200,
                      ),
                      Text(
                          '${"Work At:".tr} ${widget.customer.responsiblies![index].workAt ?? 'N/A'}'),
                      Divider(
                        color: Colors.grey.shade200,
                      ),
                      Text(
                          '${"Work To:".tr} ${widget.customer.responsiblies![index].workTo ?? 'N/A'}'),
                      Divider(
                        color: Colors.grey.shade200,
                      ),
                      Text(
                          '${"Work Day From:".tr} ${widget.customer.responsiblies![index].workDayFrom ?? 'N/A'}'),
                      Divider(
                        color: Colors.grey.shade200,
                      ),
                      Text(
                          '${"Work Day To:".tr} ${widget.customer.responsiblies![index].workDayTo ?? 'N/A'}'),
                    ],
                  ),
                );
              },
              slideTransform: const CubeTransform(),
              slideIndicator: CircularSlideIndicator(),
            ),
          );
        } else {
          return Center(child: Text("No Responsiblies For this Customer".tr));
        }

      case DetailsView.Owner:
        if (widget.customer.owners != null &&
            widget.customer.owners!.isNotEmpty) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.35,
            ),
            child: CarouselSlider.builder(
              itemCount: widget.customer.owners!.length,
              slideBuilder: (index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView(
                    children: <Widget>[
                      Text(
                          '${"Name:".tr} ${widget.customer.owners![index].name ?? 'N/A'}'),
                      Divider(
                        color: Colors.grey.shade200,
                      ),
                      Text(
                          '${"Mobile:".tr} ${widget.customer.owners![index].mobile ?? 'N/A'}'),
                      Divider(
                        color: Colors.grey.shade200,
                      ),
                      Text(
                          '${"Email:".tr} ${widget.customer.owners![index].email ?? 'N/A'}'),
                      Divider(
                        color: Colors.grey.shade200,
                      ),
                      Text(
                          '${"Work At:".tr} ${widget.customer.owners![index].workAt ?? 'N/A'}'),
                      Divider(
                        color: Colors.grey.shade200,
                      ),
                      Text(
                          '${"Work To:".tr} ${widget.customer.owners![index].workTo ?? 'N/A'}'),
                      Divider(
                        color: Colors.grey.shade200,
                      ),
                      Text(
                          '${"Work Day From:".tr} ${widget.customer.owners![index].workDayFrom ?? 'N/A'}'),
                      Divider(
                        color: Colors.grey.shade200,
                      ),
                      Text(
                          '${"Work Day To:".tr} ${widget.customer.owners![index].workDayTo ?? 'N/A'}'),
                    ],
                  ),
                );
              },
              slideTransform: const CubeTransform(),
              slideIndicator: CircularSlideIndicator(),
            ),
          );
        } else {
          return Center(child: Text("No Owners For this Customer".tr));
        }
    }
  }
}
