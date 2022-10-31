import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'dart:async';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const double _initiallat = 37.554526;
  static const double _initiallng = 126.970383;
  static  CameraPosition _initialCameraPosition = CameraPosition(
      target: LatLng(_initiallat, _initiallng),zoom: 17);
  final Completer<GoogleMapController> _controller = Completer();

  var data = Get.arguments;

  late String subwayName1 = 'invaild location';
  late int lineNumber = 0;
  double lat1 = 0.0, lng1 = 0.0;
  String QRdata = '1234ffov3pp5oq23lk';

  @override
  Widget build(BuildContext context) {

    double appHeight = MediaQuery.of(context).size.height;
    double appWidth = MediaQuery.of(context).size.width;
    double appRatio = MediaQuery.of(context).size.aspectRatio;
    double mainBoxHeight = appHeight * 0.58;
    double mainBoxWidth = appWidth * 0.915;

    return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                color: Colors.white,
                height: appHeight * 0.17,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: mainBoxWidth/40,),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: QrImage(data: QRdata)),
                    ),

                    SizedBox(width: appRatio >= 0.5? mainBoxHeight/6
                        : mainBoxHeight/15,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: mainBoxHeight/25,
                        ),
                        Text(
                          DateFormat('y-M-dd EEE').format(DateTime.now()),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: appRatio >= 0.5? mainBoxHeight/22
                                  : mainBoxHeight/25,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: mainBoxHeight/50,
                        ),
                        Container(
                          height:  mainBoxHeight/7,
                          width: mainBoxWidth/2.2,
                          // decoration: BoxDecoration(
                          //   border: Border.all(width: 1),
                          // ),
                          child: BarcodeWidget(
                            data: 'FR9XZ227A93',style: TextStyle(fontWeight: FontWeight.bold,fontSize: mainBoxHeight/35),
                            barcode: Barcode.code93(),
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                color: Colors.white,
                height: appHeight * 0.60,
                width: appWidth * 0.92,
                child: Column(
                  children: <Widget>[
                    DottedLine(
                      dashLength: 15, dashGapLength: 6, lineThickness: 7,
                      lineLength: appWidth * 0.92,),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: [
                              SizedBox(height: mainBoxHeight/20,),
                              SizedBox(
                                height: appHeight * 0.58 * 0.90,
                                width: appWidth * 0.08,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: data[4] == 'Line1'? const Color(0xff2b3990)
                                          : data[4] == 'Line2'? const Color(0xff009D3E)
                                          : data[4] == 'Line3'? const Color(0xffEF7C1C)
                                          : data[4] == 'Line4'? const Color(0xff00A5DE)
                                          : data[4] == 'Line5'? const Color(0xff996CAC)
                                          : data[4] == 'Line6'? const Color(0xffCD7C2F)
                                          : data[4] == 'Line7'? const Color(0xff747F00)
                                          : data[4] == 'Line8'? const Color(0xffEA545D)
                                          : data[4] == 'Line9'? const Color(0xffBB8336)
                                          : data[4] == '서해'? const Color(0xff8FC31F)
                                          : data[4] == '공항'? const Color(0xff0090D2)
                                          : data[4] == '경의중앙'? const Color(0xff77C4A3)
                                          : data[4] == '경춘'? const Color(0xff0C8E72)
                                          : data[4] == '수인분당'? const Color(0xff8FC31F)
                                          : data[4] == '신분당'? const Color(0xffD4003B)
                                          : data[4] == '경강'? const Color(0xff003DA5)
                                          : data[4] == '인천1선'? const Color(0xff7CA8D5)
                                          : data[4] == '인천2선'? const Color(0xffED8B00)
                                          : data[4] == '에버라인'? const Color(0xff6FB245)
                                          : data[4] == '의정부'? const Color(0xffFDA600)
                                          : data[4] == '우이신설'? const Color(0xffB7C452)
                                          : data[4] == '김포골드'? const Color(0xffA17800)
                                          : data[4] == '신림'? const Color(0xff6789CA)
                                          : Colors.green
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: appRatio >= 5? mainBoxHeight/25
                              : mainBoxHeight/35,),
                          Column(
                            children: [
                              SizedBox(height: mainBoxHeight/20,),
                              Container(
                                  height: appHeight * 0.58 * 0.90,
                                  width: appWidth * 0.75,
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 1)),
                                  child:GoogleMap(
                                    mapType: MapType.normal,
                                    initialCameraPosition: _initialCameraPosition,
                                    myLocationButtonEnabled: true,
                                    myLocationEnabled: true,
                                    zoomGesturesEnabled: true,
                                    zoomControlsEnabled: true,
                                    scrollGesturesEnabled: true,
                                    rotateGesturesEnabled: true,
                                    compassEnabled: true,
                                    // minMaxZoomPreference: MinMaxZoomPreference(14, 19),
                                    onCameraMove: (_){},

                                    markers: {
                                      Marker(
                                        markerId: MarkerId("MyLocation"),
                                        position: LatLng(data[1], data[2]),
                                        visible: true,
                                        icon: BitmapDescriptor.defaultMarker,
                                      ),
                                      Marker(
                                        markerId: MarkerId("SEOUL"),
                                        position: LatLng(37.554526, 126.970383),
                                        visible: true,
                                        icon: BitmapDescriptor.defaultMarker,
                                      ),

                                      Marker(
                                        markerId: MarkerId("Sadang"),
                                        position: LatLng(37.476527, 126.981685),
                                        visible: true,
                                        icon: BitmapDescriptor.defaultMarker,
                                      ),
                                      Marker(
                                        markerId: MarkerId("Hapjeong"),
                                        position: LatLng(37.549463, 126.913739),
                                        visible: true,
                                        icon: BitmapDescriptor.defaultMarker,
                                      ),
                                    },
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Container(
                  color: Colors.white,
                  height: appHeight * 0.35,
                  // width: mainBoxWidth,
                  // width: appWidth * 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // SizedBox(width: mainBoxWidth/30,),
                      Padding(
                        padding:  EdgeInsets.all(appRatio >= 0.5? 10.0
                            : 5.0),
                        child: BarcodeWidget(
                          data: '-------LAFAYETTE.co--------',style: TextStyle(fontWeight: FontWeight.bold),
                          barcode: Barcode.code128(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}