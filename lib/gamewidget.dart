import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'dart:async';


class Gamewidget extends StatefulWidget {
  const Gamewidget({super.key});

  @override
  _gamewidget createState() => _gamewidget();
}

class _gamewidget extends State<Gamewidget> {
  static const methodChannel = MethodChannel("com.kaiyo.ezgodot/method/start");
  bool _showNativeView = false;

  double _width = 300.0; // Default width for resizable widget
  double _height = 300.0; // Default height for resizable widget

  final _eventStream = const EventChannel("kaiyo.ezgodot/generic");
  StreamSubscription<dynamic>? _eventSubscription;


  @override
  void initState() {
    super.initState();
    startEvent();
  }


  @override
  Widget build(BuildContext context) {
    
    //_eventStream.receiveBroadcastStream().distinct().map((dynamic event) {
    //  
    //}).listen;
    /*_eventStream.receiveBroadcastStream().listen((event) {
      print("flutter data $event");
      
      });*/


    return Scaffold(
      appBar: AppBar(
        title: const Text('PlatformView Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _showNativeView = true;
                });
              },
              child: const Text('Show Godot View'),
            ),
            if (_showNativeView)
    Column(
      children: [
        GestureDetector(
          onPanUpdate: (details) {
            // Update the width and height when the user drags to resize
            setState(() {
              _width += details.delta.dx;
              _height += details.delta.dy;

              _width = _width.clamp(100.0, MediaQuery.of(context).size.width - 20);
              _height = _height.clamp(100.0, MediaQuery.of(context).size.height - 20);
            });
          },
          child: SizedBox(
            width: _width,
            height: _height,
                child: PlatformViewLink(
                  viewType: 'platform-view-type',
                  surfaceFactory: (context, controller) {
                    //Future.delayed(const Duration(seconds:9 ),(){
                    print("SurfaceFactory called with controller: $controller");
                    return AndroidViewSurface(
                      controller: controller as AndroidViewController,
                      gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
                      hitTestBehavior: PlatformViewHitTestBehavior.opaque,
                    );
                   // });
                  },
                  onCreatePlatformView: (PlatformViewCreationParams params) {
                  print("PlatformView is being created with id: ${params.id}");
                    final androidViewController =PlatformViewsService.initSurfaceAndroidView(
                        id: params.id,
                      viewType: 'platform-view-type',
                      layoutDirection: TextDirection.ltr);
                  androidViewController.create();
                  print("PlatformView created with controller: $androidViewController");
                  return androidViewController;
                  },
                  //nCreatePlatformView: (params) {
                    /*return PlatformViewsService.initSurfaceAndroidView(
                      id: params.id,
                      viewType: 'platform-view-type',
                      layoutDirection: TextDirection.ltr,
                      creationParams: null,
                      creationParamsCodec: StandardMessageCodec(),
                    )
                      ..create();*/
                  //    print("jh");
                  //},
                ),
              ),
              ),

          ],

        ),
    ]
      ),
    ),
    );
  }
  Future<void> sendData2Game(String data) async {
    try {
      await methodChannel.invokeMethod("sendData2Godot", {"data": data});
    } catch (e) {
      print("Error sending data to native godot: $e");
    }
  }

  void TakeString(){
    String data="";
    print("Function to take String and process it");
    //send data to godot after processing
    /*sendData2Game(data);*/
  }

  /*Stream<dynamic> networkStream(){return _eventStream.receiveBroadcastStream().distinct().map((dynamic event) {
    debugPrint("flutter data: $event");
    return event;

  });}*/

  void startEvent(){

    print("Started listening for events in SE");
    _eventSubscription=_eventStream.receiveBroadcastStream().listen((dynamic event) {
      // Handle incoming events here
      print('Received data from GD-Android: $event');
      if (event == "close_view") {
        // Hide the native view and show the Flutter view again
        setState(() {
          _showNativeView = false;
        });
      }

      else if (event == "TakeString") {
        TakeString();
      }
      // Update UI or perform other actions based on the received event
    }, onError: (error) {
      // Handle any errors here
      print('Error receiving data from GD-Android: $error');
    });

  }

  @override
  void dispose() {
    // Cancel the subscription when the widget is disposed
    _eventSubscription?.cancel();
    super.dispose();
  }


}