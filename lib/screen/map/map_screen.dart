import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../utils/images/app_images.dart';
import '../../utils/style/app_text_style.dart';


class GoogleMapsScreen extends StatefulWidget {
  const GoogleMapsScreen({
    super.key, required this.latLng,
  });

  final LatLng latLng;

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {


  @override
  Widget build(BuildContext context) {
    CameraPosition cameraPosition = CameraPosition(
      target: widget.latLng,
      zoom: 14.49,
    );
    final Completer<GoogleMapController> googleMapController = Completer<
        GoogleMapController>();
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onCameraIdle: () {},
            onMapCreated: (controller) {
              googleMapController.complete(controller);
            },
            onCameraMove: (CameraPosition currentCameraPosition) {
              cameraPosition = currentCameraPosition;
              debugPrint(
                  "CURRENT POSITION:${currentCameraPosition.target.longitude}");
            },
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
            target: widget.latLng,
            zoom: 15,
          ),

          ),
          Align(
            child: Image.asset(
              AppImages.location,
              width: 50,
              height: 50,
            ),
          ),
          Positioned(
            top: 100,
            right: 0,
            left: 0,
            child: Text(
              "Hello",
              textAlign: TextAlign.center,
              style: AppTextStyle.interSemiBold.copyWith(
                fontSize: 24,
              ),
            ),
          )
        ],
      ),

    );
  }
}
