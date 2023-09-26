import 'package:cosmo_care/core/Constants/assets_path_constants.dart';
import 'package:flutter/material.dart';

class CosmoCareSplashWidget extends StatelessWidget {
  const CosmoCareSplashWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          width: deviceSize.width,
          height: deviceSize.height,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Image.asset(AssetsPathConstants.kBlueLogoPath),
            ),
          ),
        ),
      ),
    );
  }
}
