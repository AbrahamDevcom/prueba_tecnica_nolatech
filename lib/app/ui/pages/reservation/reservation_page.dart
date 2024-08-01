import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica_nolatech/app/domain/models/courts_mdl.dart';
import 'package:prueba_tecnica_nolatech/app/ui/global_controller/global_controller.dart';
import 'package:prueba_tecnica_nolatech/app/ui/pages/reservation/controller/reservation_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../utils/constants.dart';
import '../../../utils/custom_colors.dart';
import '../../../utils/utils.dart';
import '../../global_widgets/button_like.dart';
import 'widgets/images_slider.dart';

class ReservationPage extends StatelessWidget {
  static const routerPage = "/reservation";
  const ReservationPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final data =
        (ModalRoute.of(context)?.settings.arguments ?? Court.empty()) as Court;
    final ctr = Provider.of<ReservationController>(context);
    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy/MM/dd').format(now);
    final pageCtr = PageController();
    ctr.generateStartTime(data.initAvailable, data.endAvailable);
    return Scaffold(
      backgroundColor: white,
      body: Column(
        children: [
          SizedBox(
            height: 250,
            child: Stack(children: [
              PageView(
                controller: pageCtr,
                children: List.generate(
                  3,
                  (index) => SizedBox.expand(
                      child: Image.asset(
                    "assets/header_court_${index + 1}.jpg",
                    fit: BoxFit.cover,
                  )),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, 0.65),
                child: SmoothPageIndicator(
                  controller: pageCtr,
                  count: 3,
                  axisDirection: Axis.horizontal,
                  onDotClicked: (i) {
                    pageCtr.animateToPage(
                      i,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                  effect: const ExpandingDotsEffect(
                    expansionFactor: 2,
                    spacing: 8,
                    radius: 16,
                    dotWidth: 10,
                    dotHeight: 10,
                    dotColor: white,
                    activeDotColor: primary,
                    paintStyle: PaintingStyle.fill,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 48, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        // ctr.dispose();
                        Navigator.pop(context);
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          // ignore: prefer_const_constructors
                          Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: white,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        ctr.toggleFavorite(data.id);
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          Icon(
                            ctr.isFavorite(data.id)
                                ? Icons.favorite
                                : Icons.favorite_border_rounded,
                            color: white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data.name),
                            Text("Cancha: ${data.type}"),
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
                                    "${data.initAvailable} a ${data.endAvailable}")
                              ].divide(const SizedBox(
                                width: 4,
                              )),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.place_outlined,
                                  size: 18,
                                ),
                                Text(data.location),
                              ],
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width * .5,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 0),
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: bgDropdown, width: 1.5),
                              ),
                              child: DropdownButtonFormField(
                                isExpanded: true,
                                isDense: true,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black,
                                  size: 24,
                                ),
                                hint: const Text("Agregar instructor",
                                    style: TextStyle(
                                      fontSize: 12,
                                    )),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                items: ctr.listInstructors.map((e) {
                                  return DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  ctr.instructorSelected = value ?? "";
                                },
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("\$${data.price}"),
                            const Text("Por hora"),
                            Row(
                              children: [
                                Image.asset("assets/icons/lluvia.png"),
                                Text("${ctr.rainValue ?? 0}%"),
                              ].divide(const SizedBox(width: 4)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(32),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: bgReservation,
                    ),
                    child: Form(
                      key: ctr.formKey,
                      child: Column(
                        children: [
                          const Align(
                            alignment: AlignmentDirectional(-1, 0),
                            child: Text(
                              "Establecer fecha y hora",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 0),
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(8)),
                            child: TextFormField(
                              controller: ctr.textDateController,
                              keyboardType: TextInputType.none,
                              decoration: InputDecoration(
                                hintText: formattedDate,
                                labelText: "Fecha",
                                labelStyle: const TextStyle(
                                    fontSize: 14, color: Colors.black),
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Por favor selecciona una fecha de reserva';
                                }
                                return null;
                              },
                              onTap: () async {
                                final datePicked = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(2024, 09, 01),
                                  lastDate: DateTime(2050),
                                );
                                final formatter = DateFormat("yyyy-MM-dd");
                                if (datePicked != null) {
                                  ctr.dateSelected = datePicked;
                                  ctr.textValue = formatter.format(DateTime(
                                    datePicked.year,
                                    datePicked.month,
                                    datePicked.day,
                                  ));
                                  final difference = datePicked.difference(now);
                                  if (difference.inDays > 0) {
                                    ctr.getRainPercentage(
                                        ctr.textDateController.text,
                                        latitudeHome,
                                        longitudeHome);
                                  } else {
                                    ctr.checkWeather(
                                        ctr.textDateController.text,
                                        latitudeHome,
                                        longitudeHome);
                                  }
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 0),
                                  decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: DropdownButtonFormField(
                                    isExpanded: true,
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                    decoration: const InputDecoration(
                                      labelText: "Hora de inicio",
                                      labelStyle: TextStyle(
                                          fontSize: 10, color: Colors.black),
                                      border: InputBorder.none,
                                    ),
                                    items: ctr.hoursInit.map((e) {
                                      return DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      ctr.generateEndTime(
                                          value.toString(), data.endAvailable);
                                      ctr.initSelected = value.toString();
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Falta hora de inicio';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 0),
                                  decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: ctr.hoursEnd.isEmpty
                                      ? const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            "Selecciona una hora de inicio",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        )
                                      : DropdownButtonFormField(
                                          isExpanded: true,
                                          icon: const Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: Colors.black,
                                            size: 24,
                                          ),
                                          decoration: const InputDecoration(
                                            labelText: "Hora de fin",
                                            labelStyle: TextStyle(
                                                fontSize: 10,
                                                color: Colors.black),
                                            border: InputBorder.none,
                                          ),
                                          items: ctr.hoursEnd.map((e) {
                                            return DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            ctr.endSelected = value.toString();
                                            ctr.calculateDuration(
                                                ctr.initSelected,
                                                value.toString());
                                          },
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Falta hora de fin';
                                            }
                                            return null;
                                          },
                                        ),
                                ),
                              ),
                            ].divide(const SizedBox(width: 8)),
                          ),
                          const SizedBox(height: 16),
                          const Align(
                            alignment: AlignmentDirectional(-1, 0),
                            child: Text(
                              "Agregar un comentario",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextFormField(
                              controller: ctr.commentController,
                              maxLines: 4,
                              decoration: const InputDecoration(
                                enabledBorder: InputBorder.none,
                                hintText: "Agregar un comentario",
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          DefaultButton(
                            label: "Reservar",
                            callback: () async {
                              if (ctr.formKey.currentState!.validate()) {
                                final confirmationResponse =
                                    await showAdaptiveDialog<bool>(
                                          context: context,
                                          builder: (_) {
                                            return AlertDialog.adaptive(
                                              content: const Text(
                                                  '¿Quieres realizar esta reserva?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, false),
                                                  child: const Text('Cancelar'),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, true),
                                                  child:
                                                      const Text('Confirmar'),
                                                ),
                                              ],
                                            );
                                          },
                                        ) ??
                                        false;
                                if (confirmationResponse) {
                                  ctr.saveReservation(
                                    userId: GlobalController().currentUser.id,
                                    date: ctr.textDateController.text,
                                    timeInit: ctr.initSelected,
                                    timeFinal: ctr.endSelected,
                                    duration: ctr.bookingDuration,
                                    instructor: ctr.instructorSelected,
                                    courtId: data.id,
                                    courtType: data.type,
                                    chanceOfRain: ctr.rainValue,
                                    comment: ctr.commentController.text,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Reserva realizada con exito",
                                      ),
                                    ),
                                  );
                                  Navigator.pop(context);
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    this.callback,
    required this.label,
  });
  final void Function()? callback;
  final String label;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: primary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: white,
              ),
            )
          ].divide(const SizedBox(
            width: 8,
          )),
        ),
      ),
    );
  }
}
