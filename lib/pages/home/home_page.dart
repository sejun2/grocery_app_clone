import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app_clone/constants.dart';
import 'package:grocery_app_clone/controllers/home_controller.dart';
import 'package:grocery_app_clone/pages/home/components/home_header.dart';

import 'components/cart_details_view.dart';
import 'components/cart_short_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController? _homeController = Get.put(HomeController());

  void _onVerticalGesture(DragUpdateDetails details) {
    if (details.primaryDelta! < -0.7) {
      _homeController!.changeHomeState(HomeState.cart);
    } else if (details.primaryDelta! > 12) {
      _homeController!.changeHomeState(HomeState.normal);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color: Color(0xFFEAEAEA),
          child: SafeArea(
            child: Container(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Obx(() =>  Stack(
                      children: [
                        //bottom sheet
                        AnimatedPositioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          height: _homeController!.homeState.value == HomeState.normal
                              ? cartBarHeight
                              : (constraints.maxHeight - cartBarHeight),
                          duration: panelTransition,
                          child: GestureDetector(
                            onVerticalDragUpdate: _onVerticalGesture,
                            child: Container(
                              alignment: Alignment.topCenter,
                              color: Color(0xFFEAEAEA),
                              padding: EdgeInsets.all(defaultPadding),
                              child: AnimatedSwitcher(
                                duration: panelTransition,
                                child: _homeController!.homeState.value ==
                                        HomeState.normal
                                    ? CartShortView(controller: _homeController)
                                    : CartDetailsView(controller: _homeController),
                              ),
                            ),
                          ),
                        ),
                        //content
                        AnimatedPositioned(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30)),
                              color: Colors.red,
                            ),
                            padding: const EdgeInsets.all(defaultPadding),
                          ),
                          duration: panelTransition,
                          height: _homeController!.homeState.value == HomeState.normal
                              ? constraints.maxHeight - headerHeight - cartBarHeight
                              : headerHeight,
                          width: Get.width,
                          top: _homeController!.homeState.value == HomeState.normal
                              ? headerHeight
                              : 0,
                        ),

                        //header
                        AnimatedPositioned(
                          left: 0,
                          right: 0,
                          duration: panelTransition,
                          child: GestureDetector(child: HomeHeader()),
                          top: _homeController!.homeState.value == HomeState.normal
                              ? 0
                              : -headerHeight,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
  }

  @override
  void dispose() {
    if (_homeController != null) {
      _homeController = null;
    }
    super.dispose();
  }
}
