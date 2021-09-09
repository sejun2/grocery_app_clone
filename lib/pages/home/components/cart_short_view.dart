import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app_clone/constants.dart';
import 'package:grocery_app_clone/controllers/home_controller.dart';

class CartShortView extends StatelessWidget {
  CartShortView({required this.controller});

  final HomeController? controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Cart',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(
            width: defaultPadding,
          ),
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Text(
              controller!.totalCartItems().toString(),
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: primaryColor),
            ),
          )
        ],
      );
    });
  }
}
