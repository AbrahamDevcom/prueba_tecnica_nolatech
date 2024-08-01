import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica_nolatech/app/domain/models/reservation_mdl.dart';
import 'package:prueba_tecnica_nolatech/app/ui/global_controller/global_controller.dart';
import 'package:prueba_tecnica_nolatech/app/ui/pages/home/controller/home_controller.dart';
import 'package:prueba_tecnica_nolatech/app/utils/utils.dart';

import '../../../domain/models/courts_mdl.dart';
import '../../../utils/custom_colors.dart';
import '../../global_widgets/probability_rain.dart';
import '../reservation/reservation_page.dart';

class HomePage extends StatelessWidget {
  static const routerPage = "/home";
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 24, 0, 8),
            child: Text(
              "Hola ${GlobalController().currentUser.name}",
              style: tittleStyles(),
            ),
          ),
          const Divider(
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 8, 0, 8),
            child: Text(
              "Canchas",
              style: tittleStyles(),
            ),
          ),
          Consumer<HomeController>(builder: (context, ctr, child) {
            return Container(
              margin: const EdgeInsets.fromLTRB(24, 8, 0, 8),
              height: 300,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: GlobalController().courts.length,
                separatorBuilder: (context, index) => const SizedBox(
                  width: 8,
                ),
                itemBuilder: (context, index) {
                  final court = GlobalController().courts[index];
                  final formatter = DateFormat("dd MMMM y", "es");
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: borderColor, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: MediaQuery.sizeOf(context).width * .68,
                    child: Column(
                      children: [
                        Image.asset("assets/cancha_${index + 1}.png"),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      court.name,
                                      style: titleStyleCard(),
                                    ),
                                    ProbabilityRain(
                                      percentage: ctr.rainPercentage ?? 0,
                                    ),
                                  ],
                                ),
                                Text("Cancha: ${court.type}"),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_today_outlined,
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(formatter.format(DateTime.now()))
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text("Disponible"),
                                    const Icon(
                                      Icons.circle,
                                      size: 8,
                                    ),
                                    const Icon(
                                      Icons.access_time_rounded,
                                      size: 16,
                                    ),
                                    Text(
                                        "${court.initAvailable} a ${court.endAvailable}")
                                  ].divide(const SizedBox(
                                    width: 4,
                                  )),
                                ),
                                DefaultButton(
                                  label: "Reservar",
                                  callback: () {
                                    Navigator.pushNamed(
                                        context, ReservationPage.routerPage,
                                        arguments: court);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }),
          const Divider(
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              "Reservas programadas",
              style: tittleStyles(),
            ),
          ),
          Consumer<HomeController>(
            builder: (context, ctr, child) {
              return FutureBuilder(
                  future: ctr.getReservations(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final data = snapshot.data;
                    return RefreshIndicator.adaptive(
                      onRefresh: () => ctr.getReservations(),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data!.length,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 8,
                        ),
                        itemBuilder: (context, index) {
                          Reservation reservation = data[index];
                          Court court = GlobalController()
                              .courts
                              .firstWhere((e) => e.id == reservation.courtId);
                          return Container(
                            decoration: const BoxDecoration(
                              color: Color(0xffF4F7FC),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
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
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        court.name,
                                        style: titleStyleCard(),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.calendar_today,
                                            size: 16,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(reservation.date)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text("Reservardo por: "),
                                          const Icon(Icons.person),
                                          Text(GlobalController()
                                              .currentUser
                                              .name)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.access_time_rounded,
                                            size: 16,
                                          ),
                                          Text(
                                              "${reservation.duration} hora(s)"),
                                          const Text(" | "),
                                          Text(
                                              "\$${reservation.duration * court.price}")
                                        ].divide(const SizedBox(
                                          width: 4,
                                        )),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
