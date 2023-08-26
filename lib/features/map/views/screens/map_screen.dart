import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cosmo_care/core/shared/global_variables.dart' as global;
import 'package:iconsax/iconsax.dart';
import '../../../../core/Constants/ui_constants.dart';
import '../../../../core/widgets/widgets/custom_text_field.dart';
import '../../../customers/controller/customers_controller.dart';
import '../../../customers/model/customer_model.dart';
import '../../../customers/view/screens/customer_details_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<CustomerModel> allCustomers = [];
  List<Marker> displayedMarkers = [];
  bool customerLoaded = false;

  @override
  void initState() {
    super.initState();
    _getAllCustomers();
  }

  Future<void> _getAllCustomers() async {
    List<CustomerModel> customers = await CustomersController.getAllCustomers();
    setState(() {
      allCustomers = customers;
      displayedMarkers = customers.map(_createMarker).toList();
      customerLoaded = true;
    });
  }

  Marker _createMarker(CustomerModel customer) {
    return Marker(
      infoWindow: InfoWindow(
        title: customer.title,
      ),
      markerId: MarkerId(customer.id.toString()),
      position: LatLng(customer.lat, customer.lng),
      onTap: () {
        Get.to(() => CustomerDetailsScreen(customer: customer));
      },
    );
  }

  void _searchMarkers(String query) {
    setState(() {
      if (query != '') {
        displayedMarkers = allCustomers
            .where((customer) =>
                customer.title.toLowerCase().contains(query.toLowerCase()))
            .map(_createMarker)
            .toList();
      } else {
        displayedMarkers = allCustomers.map(_createMarker).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
         customerLoaded? GoogleMap(
            myLocationEnabled: true,
            markers: Set.from(displayedMarkers),
            initialCameraPosition: CameraPosition(
              target: LatLng(global.currentUserLat, global.currentUserLong),
              zoom: 8.0,
            ),
            mapType: MapType.normal,
          ): const Center(
                  child: CircularProgressIndicator(color: UiConstant.kCosmoCareCustomColors1,),
                ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Padding(
              padding: const EdgeInsets.only(right: 50),
              child: CustomTextField(
                borderRadius: 0,
                hintText: "Search by customer name",
                prefixIconData: Iconsax.user,
                onChange: _searchMarkers,
              ),
            ),
          )
        ],
      ),
    );
  }
}

// class MapScreen extends StatelessWidget {
//   const MapScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<List<CustomerModel>>(
//           future: CustomersController.getAllCustomers(),
//           builder: (context, snapShot) {
//             if (snapShot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else {
//               if (snapShot.hasData) {
//                 List<Marker> markers = [];
//                 if (snapShot.hasData) {
//                   for (var customer in snapShot.data!) {
//                     markers.add(
//                       Marker(
//                         infoWindow: InfoWindow(
//                           title: customer.title,
//                         ),
//                         markerId: MarkerId(customer.id.toString()),
//                         position: LatLng(customer.lat, customer.lng),
//                         // icon: BitmapDescriptor.fromBytes(markersData[index]),

//                         onTap: () {
//                           Get.to(
//                               () => CustomerDetailsScreen(customer: customer));
//                         },
//                       ),
//                     );
//                   }
//                 }
//                 return GoogleMap(
//                   myLocationEnabled: true,
//                   markers: Set.from(markers),
//                   initialCameraPosition: CameraPosition(
//                     target:
//                         LatLng(global.currentUserLat, global.currentUserLong),
//                     zoom: 10.0,
//                   ),
//                   mapType: MapType.normal,
//                 );
//               } else {
//                 return Container();
//               }
//             }
//           }),
//     );
//   }
// }
