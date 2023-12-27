import "package:carpooling_app/components/textfield_component.dart";
import "package:carpooling_app/resources/color.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:url_launcher/url_launcher.dart";

class BookRidePage extends StatefulWidget {
  const BookRidePage({super.key});

  @override
  State<BookRidePage> createState() => _BookRidePageState();
}

class _BookRidePageState extends State<BookRidePage> {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextFieldComponent(
                hintText: "From", controller: fromController, obscure: false),
            const SizedBox(
              height: 15,
            ),
            TextFieldComponent(
              hintText: "To",
              controller: toController,
              obscure: false,
            ),
            const SizedBox(
              height: 30,
            ),
            StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("rides").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: blueColor,
                    ));
                  } else {
                    List<QueryDocumentSnapshot>? ridesList =
                        snapshot.data?.docs;

                    if (fromController.text.isEmpty &&
                        toController.text.isEmpty) {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: ridesList!.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> ride = ridesList[index]
                                  .data() as Map<String, dynamic>;

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Card(
                                  color: Colors.white,
                                  elevation: 1.2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "${ride["from"]} - ${ride["to"]}",
                                              style: const TextStyle(
                                                  fontFamily: "PoppinsBold",
                                                  fontSize: 25),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${ride["date"]}, ${ride["time"]}",
                                              style: const TextStyle(
                                                  fontFamily: "PoppinsRegular",
                                                  fontSize: 15),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                String call =
                                                    "tel:${ride["phone"]}";
                                                if (await canLaunchUrl(
                                                    Uri.parse(call))) {
                                                  await launchUrl(
                                                      Uri.parse(call));
                                                }
                                              },
                                              child: const Text(
                                                "Contact",
                                                style: TextStyle(
                                                    fontFamily: "PoppinsBold",
                                                    fontSize: 15,
                                                    color: blueColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: ridesList!.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> ride = ridesList[index]
                                  .data() as Map<String, dynamic>;

                              if (fromController.text == ride["from"] ||
                                  toController.text == ride["to"]) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 1.2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "${ride["from"]} - ${ride["to"]}",
                                                style: const TextStyle(
                                                    fontFamily: "PoppinsBold",
                                                    fontSize: 25),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${ride["date"]}, ${ride["time"]}",
                                                style: const TextStyle(
                                                    fontFamily:
                                                        "PoppinsRegular",
                                                    fontSize: 15),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  String call =
                                                      "tel:${ride["phone"]}";
                                                  if (await canLaunchUrl(
                                                      Uri.parse(call))) {
                                                    await launchUrl(
                                                        Uri.parse(call));
                                                  }
                                                },
                                                child: const Text(
                                                  "Contact",
                                                  style: TextStyle(
                                                      fontFamily: "PoppinsBold",
                                                      fontSize: 15,
                                                      color: blueColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }),
                      );
                    }
                  }
                })
          ],
        ),
      ),
    );
  }
}
