import 'package:flutter/material.dart';

class NavItemModel {
  final String title;
  final Icon icon;

  NavItemModel({required this.title, required this.icon});
}

List<NavItemModel> bottomNavItems = [
  NavItemModel(
      title: "Persediaan",
      icon: Icon(
        Icons.storage_outlined,
        color: Colors.white,
      )),
  NavItemModel(
      title: "Pengembalian",
      icon: Icon(
        Icons.loop_outlined,
        color: Colors.white,
      ))
];
