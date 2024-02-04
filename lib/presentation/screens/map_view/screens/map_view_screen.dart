import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewScreen extends StatefulWidget {
  final String userId;

  const MapViewScreen({super.key, required this.userId});

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();

}


class _MapViewScreenState extends State<MapViewScreen> {

  BitmapDescriptor loactionMarker = BitmapDescriptor.defaultMarker;


  @override
  void initState() {
    addCustomIcon();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(FirebaseConstants.userDb)
              .doc(widget.userId)
              .snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return const CircularProgressIndicator();
            }else{
              return GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                        snapshot.data![FirebaseConstants.fieldLattitude],
                        snapshot.data![FirebaseConstants.fieldLongitude]),
                        zoom: 15
                        ),
                        markers: {
                          Marker(markerId: const MarkerId('User Location'),
                          position: LatLng(
                        snapshot.data![FirebaseConstants.fieldLattitude],
                        snapshot.data![FirebaseConstants.fieldLongitude]),
                        icon: loactionMarker
                          ),
                        },
                        );
                        
            }
          }),
    );
  }


  void addCustomIcon(){
    BitmapDescriptor.fromAssetImage(const ImageConfiguration(size: Size(10, 10)), "assets/icons/marker1.png").then((icon){
      setState(() {
        loactionMarker=icon;
      });
    });
  }
}
