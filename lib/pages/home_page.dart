import "package:carpooling_app/pages/book_ride_page.dart";
import "package:carpooling_app/pages/offer_ride_page.dart";
import "package:carpooling_app/services/auth_service.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = const [
      OfferRidePage(),
      BookRidePage(),
    ];

    return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: currentPage,
          onTap: (value) {
            if (value == 0) {
              setState(() {
                currentPage = 1;
              });
            } else {
              setState(() {
                currentPage = 0;
              });
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.car_rental),
              label: "",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.phone_android), label: "")
          ],
        ),
        appBar: AppBar(
          title: const Text(
            "LiftLoop",
            style: TextStyle(fontSize: 25, fontFamily: "PoppinsBold"),
          ),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {
                  Provider.of<AuthService>(context, listen: false).logout();
                },
                icon: const Icon(Icons.power_settings_new_outlined))
          ],
        ),
        body: IndexedStack(
          index: currentPage,
          children: pages,
        ));
  }
}
