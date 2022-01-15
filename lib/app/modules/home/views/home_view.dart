

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter/services.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        Obx(() => !controller.loading.value
            ? DropdownButton<BluetoothDevice>(
                value: controller.device,
                onChanged: (device) {
                  controller.device = device;
                },
                items: controller.prepareArr())
            : Text('loading')),
        SizedBox(height: 10),
        ElevatedButton(
            onPressed: () async{

              // await controller.printer.disconnect();
              await controller.printer.connect(controller.device!);
            },
            child: Text('connect')),
        ElevatedButton(
            onPressed: () async {
              await controller.printCheq();
            },
            child: Text('Print')),
            Image.asset("assets/images.png"),
        Obx(() => controller.imgLading.value ? Text("data") : Image.memory(controller.bytes)
        ),
        RepaintBoundary(
          key: controller.globalKey,
          child: Container(
            width: 302.36,
            color: Colors.white,
              child: Column(
              children: [
                Text("ahmed", style: TextStyle(color: Colors.black),),
                Text("اهلا بكم في النظم", style: TextStyle(color: Colors.black),),
                Text("ahme", style: TextStyle(color: Colors.black),),
                
                // SizedBox(height :600 )
                
                
              ],
            ),
          ),
        )
      ])),
    );
  }
}
