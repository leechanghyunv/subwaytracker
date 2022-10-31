import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:input_history_text_field/input_history_text_field.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'Notification.dart';
import 'MapPage.dart';
import 'dart:async';
import 'Model.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  static const List<String> _kOptions = <String>[
    '혜화역','사당역','동대입구역','강남역','을지로4가', '을지로3가', '을지로입구','시청역', '충정로', '아현역', '이대역', '신촌역', '홍대입구', '합정역', '로컬스티치을지로', '구글본사', '시흥시청역', '송도달빛축제공원','동대문역사문화공원',
  ];

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  double lat = 0.0, lng = 0.0, lat1 = 0.0, lng1 = 0.0;
  double tracklat =0.0, tracklng =0.0;
  double streamlat =0.0, streamlng =0.0;
  late String description ='';
  late String stringNumber ='Line1';
  late String subwayName1 = 'Destination';
  late String passenger1 = '';
  late int countvalue = subwayName1.length;
  late int countvalueN = stringNumber.length;
  late int lineNumber = 0;
  String QRdata = '1234ffov3pp5oq23lk';

  void getLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  void findMyposition(
      List<SubwayModel> subway, double lat, double lng, String subwayName1,)
  {
    final index = subway.indexWhere((element) => element.name == subwayName1);
    lat1 = subway[index].lat;
    lng1 = subway[index].lng;
    lineNumber = subway[index].line;
    stringNumber = subway[index].Stringline;
  }

  late StreamSubscription _getPositionSubscription = Geolocator.getPositionStream(
        locationSettings:
        const LocationSettings(accuracy: LocationAccuracy.best))
        .listen((Position? position) {
      print(position == null
          ? 'Unknown'
          : '****${position.latitude.toString()}, ****${position.longitude.toString()}');
      position == null ? 'Unknown' : streamlat = position.latitude;
      position == null ? 'Unknown' : streamlng = position.longitude;
      if (streamlat.toStringAsFixed(2) == lat1.toStringAsFixed(2)
          && streamlng.toStringAsFixed(2) == lng1.toStringAsFixed(2)) {
        print('Call Notification');
        Noti.showBigTextNotification(
            title: "곧 ${subwayName1} 입니다.", body: "\n 내릴준비하세요",
            fln: flutterLocalNotificationsPlugin);
      }  else {
        print('Stop Notification');
      }
    });


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }


  void dispose() {
    if (_getPositionSubscription != null) {
      _getPositionSubscription.cancel();
      // _getPositionSubscription = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double appHeight = MediaQuery.of(context).size.height;
    double appWidth = MediaQuery.of(context).size.width;
    double appRatio = MediaQuery.of(context).size.aspectRatio;
    double mainBoxHeight = appHeight * 0.58;
    double mainBoxWidth = appWidth * 0.915;

    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: <Widget>[
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
                            Get.to(MapPage(),arguments: [subwayName1,lat1,lng1,lineNumber,stringNumber]);
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
                          child: BarcodeWidget(
                            data: 'FR9XZ227A93V6',style: TextStyle(fontWeight: FontWeight.bold,fontSize: mainBoxHeight/35),
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
                width: appWidth * 0.915,
                child: Column(
                  children: <Widget>[
                    const DottedLine(
                        dashLength: 15, dashGapLength: 6, lineThickness: 7),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: [
                              SizedBox(height: mainBoxHeight/20,),
                              SizedBox(
                                height: appHeight * 0.58 * 0.90,
                                width: appWidth * 0.08,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: stringNumber == 'Line1'? const Color(0xff2b3990)
                                          : stringNumber == 'Line2'? const Color(0xff009D3E)
                                          : stringNumber == 'Line3'? const Color(0xffEF7C1C)
                                          : stringNumber == 'Line4'? const Color(0xff00A5DE)
                                          : stringNumber == 'Line5'? const Color(0xff996CAC)
                                          : stringNumber == 'Line6'? const Color(0xffCD7C2F)
                                          : stringNumber == 'Line7'? const Color(0xff747F00)
                                          : stringNumber == 'Line8'? const Color(0xffEA545D)
                                          : stringNumber == 'Line9'? const Color(0xffBB8336)
                                          : stringNumber == '서해'? const Color(0xff8FC31F)
                                          : stringNumber == '공항'? const Color(0xff0090D2)
                                          : stringNumber == '경의중앙'? const Color(0xff77C4A3)
                                          : stringNumber == '경춘'? const Color(0xff0C8E72)
                                          : stringNumber == '수인분당'? const Color(0xff8FC31F)
                                          : stringNumber == '신분당'? const Color(0xffD4003B)
                                          : stringNumber == '경강선'? const Color(0xff003DA5)
                                          : stringNumber == '인천1선'? const Color(0xff7CA8D5)
                                          : stringNumber == '인천2선'? const Color(0xffED8B00)
                                          : stringNumber == '에버라인'? const Color(0xff6FB245)
                                          : stringNumber == '의정부'? const Color(0xffFDA600)
                                          : stringNumber == '우이신설'? const Color(0xffB7C452)
                                          : stringNumber == '김포골드'? const Color(0xffA17800)
                                          : stringNumber == '신림'? const Color(0xff6789CA)
                                          :  Colors.green
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: mainBoxHeight/50,),
                          Column(
                            children: <Widget>[
                              SizedBox(height: mainBoxHeight/25,),
                              Container(
                                height:  appWidth * 0.13,
                                width: mainBoxHeight/5.5,
                                color: Colors.black,
                                alignment: Alignment.center,
                                child:
                                /// if lineNumber != 0? : DropdownButton : DropdownButton
                                DropdownButton<dynamic>(
                                    value: stringNumber,
                                    dropdownColor: Colors.black,
                                    underline: Container(
                                      color: Colors.black,
                                    ),
                                    icon: SizedBox.shrink(),
                                    style: const TextStyle(color: Colors.white),
                                    onChanged: (dynamic? newValue) {
                                      setState(() {
                                        stringNumber = newValue!;
                                        print(stringNumber);
                                      });
                                    },
                                    items: <dynamic>['Line1', 'Line2', 'Line3', 'Line4','Line5','Line6','Line7','Line8','Line9']
                                        .map<DropdownMenuItem<dynamic>>((dynamic value) {
                                      return DropdownMenuItem<dynamic>(
                                        value: value,
                                        child: Text(value,style: TextStyle(
                                            fontSize: countvalueN >= 5?
                                            mainBoxHeight/21
                                                : mainBoxHeight/15,
                                            fontWeight: FontWeight.bold,color: Colors.white),),
                                      );
                                    }).toList()
                                ),
                              ),

                              SizedBox(height: mainBoxHeight/25,),
                              Container(
                                height: appHeight * 0.58 * 0.75,
                                decoration: BoxDecoration(
                                ),
                                child: RotatedBox(
                                  quarterTurns: 3,
                                  child:
                                  Text(
                                    ' ${subwayName1}', style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          /// IPHONE 11 기준 mainBoxHeight == 520
                                      subwayName1.length == 3? mainBoxHeight/6.5 /// 80
                                          : subwayName1.length == 4 ? mainBoxHeight/6.5 /// 80
                                          : subwayName1.length == 5 ? mainBoxHeight/6.5 /// 80
                                          : subwayName1.length == 6 ? mainBoxHeight/8.6 /// 60
                                          : subwayName1.length == 7 ? mainBoxHeight/8.6 /// 60
                                          : subwayName1.length == 8 ? mainBoxHeight/11.4 /// 45
                                          : mainBoxHeight/11.4
                                  ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: appRatio >= 0.5? mainBoxHeight/6
                              : mainBoxHeight/15,),
                          Column(
                            children: <Widget>[
                              SizedBox(height: mainBoxHeight/30,),
                              SizedBox(
                                width: appHeight/6,
                                child: RotatedBox(
                                  quarterTurns: 1,
                                  child: IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          content: Container(
                                            height: 330,
                                            child: Form(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          decoration: const BoxDecoration(
                                                            // color: Colors.blueGrey
                                                          ),
                                                          width: 80,
                                                          height: 80,
                                                          child: QrImage(
                                                            data: QRdata,
                                                          ),
                                                        ),
                                                        SizedBox(width: 5,),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            const Text('Boarding Psss',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black),),
                                                            Text(
                                                              DateFormat('y-M-dd EEE \nHH:mm').format(DateTime.now()),
                                                              style: const TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 15,
                                                                  color: Colors.black),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        Autocomplete<String>(
                                                          optionsBuilder: (TextEditingValue
                                                          textEditingValue) {
                                                            if (textEditingValue.text == '') {
                                                              return const Iterable<
                                                                  String>.empty();
                                                            }
                                                            subwayName1 = textEditingValue.text;
                                                            return MyHomePage._kOptions.where(
                                                                    (String option) => option.contains(textEditingValue.text.toLowerCase()));
                                                          },
                                                          onSelected: (String selection) {
                                                            debugPrint('You just selected $selection');
                                                          },
                                                          fieldViewBuilder: (context,
                                                              controller,
                                                              focusNode,
                                                              onEdittingComplete) {

                                                            return TextField(
                                                              controller: controller,
                                                              focusNode: focusNode,
                                                              onEditingComplete:
                                                              onEdittingComplete,
                                                              decoration: InputDecoration(
                                                                  border: OutlineInputBorder(
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        10),
                                                                  ),
                                                                  prefixIcon: const Icon(
                                                                    Icons.subway,
                                                                    color: Colors.black,
                                                                  ),
                                                                  hintText:
                                                                  'Enter your destination'),
                                                            );
                                                          },
                                                        ),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        InputHistoryTextField(
                                                            historyKey: "3",
                                                            decoration: InputDecoration(
                                                                border: OutlineInputBorder(
                                                                  borderRadius:
                                                                  BorderRadius.circular(10),
                                                                ),
                                                                prefixIcon: const Icon(
                                                                  Icons.person,
                                                                  color: Colors.black,
                                                                ),
                                                                hintText: 'Enter your name'),
                                                            onChanged: (val2) {
                                                              setState(() {
                                                                passenger1 = val2;
                                                                print(
                                                                    'passenger1 ${passenger1}');
                                                              });
                                                            }),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Container(
                                                          height: 70,
                                                          decoration: BoxDecoration(
                                                              color: Colors.white),
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                height: 60,
                                                                width: 10,
                                                                child: Container(
                                                                  decoration:   BoxDecoration(
                                                                      color: stringNumber == 'Line1'? Color(0xff2b3990)
                                                                          : stringNumber == 'Line2'? const Color(0xff00B140)
                                                                          : stringNumber == 'Line3'? const Color(0xffFC4C02)
                                                                          : stringNumber == 'Line4'? const Color(0xff00A5DE)
                                                                          : stringNumber == 'Line5'? const Color(0xff996CAC)
                                                                          : stringNumber == 'Line6'? const Color(0xffC75D28)
                                                                          : stringNumber == 'Line7'? const Color(0xff747F00)
                                                                          : stringNumber == 'Line8'? const Color(0xffEA545D)
                                                                          : stringNumber == 'Line9'? const Color(0xffBB8336)
                                                                          : stringNumber == '서해'? const Color(0xff8FC31F)
                                                                          : stringNumber == '공항'? const Color(0xff0090D2)
                                                                          : stringNumber == '경의중앙'? const Color(0xff77C4A3)
                                                                          : stringNumber == '경춘'? const Color(0xff0C8E72)
                                                                          : stringNumber == '수인분당'? const Color(0xff8FC31F)
                                                                          : stringNumber == '신분당'? const Color(0xffD4003B)
                                                                          : stringNumber == '경강'? const Color(0xff003DA5)
                                                                          : stringNumber == '인천1선'? const Color(0xff7CA8D5)
                                                                          : stringNumber == '인천2선'? const Color(0xffED8B00)
                                                                          : stringNumber == '에버라인'? const Color(0xff6FB245)
                                                                          : stringNumber == '의정부'? const Color(0xffFDA600)
                                                                          : stringNumber == '우이신설'? const Color(0xffB7C452)
                                                                          : stringNumber == '김포골드'? const Color(0xffA17800)
                                                                          : stringNumber == '신림'? const Color(0xff6789CA)
                                                                          : Colors.green
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 30,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  SizedBox(height: 10,),
                                                                  Text('DATE',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5)),
                                                                  SizedBox(height: 10,),
                                                                  Text(DateFormat('M-dd').format(DateTime.now()),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5)),
                                                                ],),
                                                              SizedBox(width: 15,),
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  SizedBox(height: 10,),
                                                                  Text('SEAT',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5)),
                                                                  SizedBox(height: 10,),
                                                                  Text('1XX',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5)),
                                                                ],),
                                                              SizedBox(width: 15,),
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  SizedBox(height: 10,),
                                                                  Text('CLASS',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5)),
                                                                  SizedBox(height: 10,),
                                                                  Text('FIRST C',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5))
                                                                ],),
                                                              SizedBox(width: 30,),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          actions: <Widget>[
                                            SizedBox(
                                              child: TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black),
                                                  )),
                                            ),
                                            SizedBox(
                                              child: TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      print('subwayName1 => ${subwayName1}');
                                                      print('passenger1 => ${passenger1}');
                                                      findMyposition(SubwayInfo2,lat1,lng1,subwayName1);
                                                      Navigator.pop(context);
                                                    });
                                                    _getPositionSubscription;
                                                  },
                                                  child: const Text(
                                                    'Adapt',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    icon: RotatedBox(
                                      quarterTurns: 3,
                                      child: Icon(
                                        Icons.subway,
                                        size: mainBoxHeight/7.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: mainBoxHeight/9,),

                              Container(
                                child: Center(
                                  child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('NUMBER', style: TextStyle(fontSize: mainBoxHeight/25, fontWeight: FontWeight.bold),),
                                            SizedBox(height: mainBoxHeight/60,),
                                            Text('23X13P', style: TextStyle(fontSize: mainBoxHeight/25, fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                        SizedBox(width: mainBoxHeight/20,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('GATE', style: TextStyle(fontSize: mainBoxHeight/25, fontWeight: FontWeight.bold),),
                                            SizedBox(height: mainBoxHeight/60,),
                                            Text('0010', style: TextStyle(fontSize: mainBoxHeight/25, fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                      ]
                                  ),
                                ),
                              ),
                              SizedBox(height: mainBoxHeight/9,),
                              ///-----------------------------------------
                              RotatedBox(
                                quarterTurns: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text('DATE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: mainBoxHeight/25),),
                                        SizedBox(width: mainBoxHeight/25,),
                                        Text('SEAT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: mainBoxHeight/25),),
                                        SizedBox(width: mainBoxHeight/25,),
                                        Text('CLASS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: mainBoxHeight/25),),
                                      ],
                                    ),
                                    SizedBox(
                                      height: mainBoxHeight/60,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          DateFormat('M/dd ').format(DateTime.now()),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: mainBoxHeight/25),
                                        ),
                                        SizedBox(width: mainBoxHeight/25,),
                                        Text('1XX',style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: mainBoxHeight/25),),
                                        SizedBox(width: mainBoxHeight/25,),
                                        Text('FIRST C',style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: mainBoxHeight/25),),
                                      ],
                                    ),
                                    SizedBox(
                                      height: mainBoxHeight/10,
                                    ),
                                    Text(
                                      'PASSENGER :',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: mainBoxHeight/25),
                                    ),
                                    SizedBox(
                                      height: mainBoxHeight/40,
                                    ),
                                    Text(
                                      '${passenger1}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: mainBoxHeight/30),
                                    ),
                                  ],
                                ),
                              ),
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
                  // width: appWidth * 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // SizedBox(width: mainBoxWidth/30,),
                      Padding(
                        padding: EdgeInsets.all(appRatio >= 0.5? 10.0
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