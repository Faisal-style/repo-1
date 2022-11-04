import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repo/core/routes/routes.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutesRepo.login,
      title: 'ITC Repository',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blue,
      ),
      getPages: AppRoutesRepo.pages,
    ),
  );
}
