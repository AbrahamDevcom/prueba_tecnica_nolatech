import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica_nolatech/app/domain/models/reservation_mdl.dart';
import 'package:prueba_tecnica_nolatech/app/ui/global_controller/global_controller.dart';
import 'package:prueba_tecnica_nolatech/app/ui/pages/bookings/controller/bookings_controller.dart';

import '../../../domain/models/courts_mdl.dart';
import '../../../utils/utils.dart';
import '../../../utils/custom_colors.dart';
import '../../global_widgets/probability_rain.dart';

class BookingsPage extends StatelessWidget {
  static const routerPage = "/bookings";
  const BookingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingsController>(builder: (context, ctr, child) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(32, 32, 32, 8),
        child: Column(children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: primary,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  color: white,
                ),
                const Text(
                  "Programar Reserva",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: white,
                  ),
                )
              ].divide(const SizedBox(
                width: 8,
              )),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          const Row(
            children: [
              Text(
                "Mis Reservas",
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
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final data = snapshot.data;
                return Expanded(
                  child: RefreshIndicator.adaptive(
                    onRefresh: () => ctr.getReservations(),
                    child: ListView.separated(
                      itemCount: data!.length,
                      separatorBuilder: (_, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (_, index) {
                        Reservation reservation = data[index];
                        Court court = GlobalController()
                            .courts
                            .firstWhere((e) => e.id == reservation.courtId);
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
                                  "assets/cancha_${court.id}.png",
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
                                        Text(court.name),
                                        ProbabilityRain(
                                          percentage: reservation.chanceOfRain,
                                        ),
                                      ],
                                    ),
                                    Text("Cancha: ${reservation.courtType}"),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_today_outlined,
                                          size: 16,
                                        ),
                                        Text(reservation.date),
                                      ].divide(const SizedBox(
                                        width: 4,
                                      )),
                                    ),
                                    Row(
                                      children: [
                                        const Text("Reservado por: "),
                                        Text(GlobalController()
                                            .currentUser
                                            .name),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.access_time_rounded,
                                          size: 16,
                                        ),
                                        Text("${reservation.duration} hora(s)"),
                                        const Text(" | "),
                                        Text(
                                            "\$${reservation.duration * court.price}")
                                      ].divide(SizedBox(
                                        width: 4,
                                      )),
                                    ),
                                  ],
                                ),
                              )
                            ].divide(const SizedBox(width: 8)),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }),
        ]),
      );
    });
  }
}
