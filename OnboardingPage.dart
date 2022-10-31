import 'package:barcode_widget/barcode_widget.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late String description ='';
  late String stringNumber ='Line2';
  late String subwayName1 = 'Destination';
  late String passenger1 = 'invalid name';
  late int countvalue = subwayName1.length;
  late int countvalueN = stringNumber.length;
  late int lineNumber = 0;
  String QRdata = '1234ffov3pp5oq23lk';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                                      color : Colors.green
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
                                child: Text( 'KOR',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:  mainBoxHeight/31,   ///
                                      color: Colors.white),
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
                                  Text('TRIP TO SEOUL', style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                      /// IPHONE 11 기준 mainBoxHeight == 520
                                     mainBoxHeight/11.4 /// 45
                                  ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(width: appRatio >= 0.5? mainBoxHeight/6 : mainBoxHeight/15,),

                          Column(
                            children: <Widget>[
                              SizedBox(height: mainBoxHeight/30,),
                              SizedBox(
                                width: appHeight/6,
                                child: RotatedBox(
                                  quarterTurns: 1,
                                  child: IconButton(
                                    onPressed: () {
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
                              SizedBox(height: mainBoxHeight/9),

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