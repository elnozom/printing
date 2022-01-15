

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
class HomeController extends GetxController {
  //TODO: Implement HomeController
  final GlobalKey globalKey = GlobalKey();
  final count = 0.obs;
  RxList<BluetoothDevice>? devices;
  BluetoothDevice? device;
  BlueThermalPrinter printer = BlueThermalPrinter.instance;
  Rx<bool> loading = true.obs;
  Rx<bool> imgLading = false.obs;
  Uint8List bytes = new Uint8List(1);
  Image img = Image(image: NetworkImage("asd"),) ;




  void printFixedLine(){
      printer.printCustom("ــــــــــــــــــــــــ",2, 1, charset:"windows-1256");
  }
  Future printCheq() async {
    capturePng().then((value) async {
      
      // printer.printImageBytes(value!);
    String charset = "windows-1256";
    String text = "WELCOME TO WAVE CAFE";
    String text2 = "فاتورة ضريبية";
    String text3 = "Reciept No : 2 ";
    String text4 = "Shift number: 5";
    String text5 = "Table number:2";
      printFixedLine();
      printer.printCustom(text, 2, 1, charset:charset);
      printer.printCustom(text2,2, 2, charset:charset);
      
      printFixedLine();
      printer.printLeftRight("LEFT", "RIGHT",1,format: "%-15s %15s %n");
      printer.printLeftRight("LEFT", "RIGHT",1,format: "%-15s %15s %n");
      printer.printLeftRight("LEFT", "RIGHT",1,format: "%-15s %15s %n");
    
      
      printFixedLine();

      printer.printNewLine();
      printer.printNewLine();
      printer.printNewLine();
      printer.printNewLine();
      // printer.printImageBytes(value!);
      // Directory dir =  await getApplicationDocumentsDirectory();
      // String dirPath = dir.path.toString();
      // print(dir);
    //   await Printing.layoutPdf(
    // onLayout: (PdfPageFormat format) async => await Printing.convertHtml(
    //       format: format,
    //       html: '<html><body><p>Hello!</p></body></html>',
    //     ));

      
      
    });
  }

  void getDevices() async {
    List<BluetoothDevice> d = await printer.getBondedDevices();
    devices = d.obs;
    loading = false.obs;
  }

  List<DropdownMenuItem<BluetoothDevice>>? prepareArr(){
    List<DropdownMenuItem<BluetoothDevice>>? list = [];
    for (var i = 0; i < devices!.length; i++) {
      var active = devices![i];
      DropdownMenuItem<BluetoothDevice> menuItem =  DropdownMenuItem<BluetoothDevice>(child: Text(active.name!),value: active,);
      list.add(menuItem);
    }

    return list;
  }

  Future<Uint8List?> capturePng() async {
    try {
      print('inside');
      RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData!.buffer.asUint8List();
      bytes = pngBytes;
        
      return pngBytes;
    } catch (e) {
      print(e);
    }
  }
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getDevices();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
