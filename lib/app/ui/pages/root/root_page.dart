import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica_nolatech/app/ui/pages/root/controller/root_controller.dart';

import '../bookings/bookings_page.dart';
import '../favorites/favorites_page.dart';
import '../home/home_page.dart';

class RootPage extends StatefulWidget {
  static const routerPage = "/root";
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final List<Widget> pages = [
    const HomePage(),
    const BookingsPage(),
    const FavoritesPage(),
  ];
  @override
  Widget build(BuildContext context) {
    final ctr = Provider.of<RootController>(context);
    return Scaffold(
      appBar: AppBar(
          title: Image.asset("assets/logo_header.png"),
          actions: [
            Row(
              children: [],
            )
          ],
          backgroundColor: const Color(0xff82BC00)),
      bottomNavigationBar: Consumer<RootController>(
        builder: (context, ctr, child) {
          return BottomNavigationBar(
              // Fixed
              type: BottomNavigationBarType.fixed,
              selectedItemColor: const Color(0xff82BC00),
              unselectedItemColor: Colors.black,
              currentIndex: ctr.getSelectedItem,
              onTap: (int index) {
                ctr.setSelectedItem(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: ctr.getSelectedItem == 0
                            ? const Color(0xff82BC00)
                            : Colors.white),
                    child: Icon(Icons.home_outlined,
                        color: ctr.getSelectedItem == 0
                            ? Colors.white
                            : Colors.black),
                  ),
                  label: "Inicio",
                  backgroundColor: const Color(0xff82BC00),
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: ctr.getSelectedItem == 1
                            ? const Color(0xff82BC00)
                            : Colors.white),
                    child: Icon(Icons.calendar_today_outlined,
                        color: ctr.getSelectedItem == 1
                            ? Colors.white
                            : Colors.black),
                  ),
                  label: "Reservas",
                  backgroundColor: Colors.black,
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: ctr.getSelectedItem == 2
                            ? const Color(0xff82BC00)
                            : Colors.white),
                    child: Icon(Icons.favorite_border_outlined,
                        color: ctr.getSelectedItem == 2
                            ? Colors.white
                            : Colors.black),
                  ),
                  label: "Favoritos",
                  backgroundColor: const Color(0xff82BC00),
                ),
              ]);
        },
      ),
      body: pages[ctr.getSelectedItem],
    );
  }
}
