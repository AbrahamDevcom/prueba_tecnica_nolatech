import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica_nolatech/app/ui/global_controller/global_controller.dart';
import 'package:prueba_tecnica_nolatech/app/ui/pages/favorites/controller/favorites_controller.dart';

import '../../../utils/utils.dart';
import '../../../utils/custom_colors.dart';
import '../reservation/reservation_page.dart';

class FavoritesPage extends StatelessWidget {
  static const routerPage = "/favorites";
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctr = Provider.of<FavoritesController>(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 24, 32, 8),
      child: Column(
        children: [
          const Row(
            children: [
              Text(
                "Mis Canchas Favoritas",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          FutureBuilder(
              future: ctr.getReservations(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final data = snapshot.data;
                return Expanded(
                  child: ListView.separated(
                    itemCount: data!.length,
                    separatorBuilder: (_, index) => const SizedBox(height: 12),
                    itemBuilder: (_, index) {
                      final favorite = GlobalController()
                          .courts
                          .firstWhere((e) => e.id == data[index].courtId);

                      return Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          border: Border.all(color: borderColor, width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                "assets/cancha_${favorite.id}.png",
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        favorite.name,
                                        style: titleStyleCard(),
                                      ),
                                    ],
                                  ),
                                  Text("Cancha: ${favorite.type}"),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.access_time_rounded,
                                        size: 16,
                                      ),
                                      const Text("1 Hora"),
                                      const Text("|"),
                                      Text("\$${favorite.price}")
                                    ].divide(const SizedBox(
                                      width: 4,
                                    )),
                                  ),
                                  DefaultButton(
                                    label: "Reservar",
                                    callback: () {
                                      Navigator.pushNamed(
                                          context, ReservationPage.routerPage,
                                          arguments: favorite);
                                    },
                                  ),
                                ].divide(const SizedBox(
                                  height: 4,
                                )),
                              ),
                            )
                          ].divide(const SizedBox(width: 8)),
                        ),
                      );
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }
}
