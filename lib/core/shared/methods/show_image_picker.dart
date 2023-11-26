import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

void showImagesPickers(context,
    {required Function()? onTapCamera,
    required void Function()? onTapGallery}) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return SafeArea(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Iconsax.gallery),
              title: Text("Photo Library".tr),
              onTap: onTapGallery,
            ),
            ListTile(
              leading: const Icon(Iconsax.camera),
              title: Text("camera".tr),
              onTap: onTapCamera,
             
            ),
          ],
        ),
      );
    },
  );
}
