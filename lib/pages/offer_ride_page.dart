import 'package:carpooling_app/components/button_component.dart';
import 'package:carpooling_app/components/textfield_component.dart';
import 'package:carpooling_app/resources/color.dart';
import 'package:carpooling_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OfferRidePage extends StatefulWidget {
  const OfferRidePage({super.key});

  @override
  State<OfferRidePage> createState() => _OfferRidePageState();
}

class _OfferRidePageState extends State<OfferRidePage> {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  DateTime datetime = DateTime.now();
  TimeOfDay timeOfDay = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                height: 15,
              ),
              TextFieldComponent(
                hintText: "Contact Number",
                controller: contactNumberController,
                obscure: false,
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Date of departure: ",
                style: TextStyle(fontFamily: "PoppinsBold"),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    datetime.toString().substring(0, 10),
                    style: const TextStyle(fontFamily: "PoppinsRegular"),
                  ),
                  IconButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2023),
                        lastDate: DateTime(2024),
                      ).then((value) {
                        setState(() {
                          datetime = value!;
                        });
                      });
                    },
                    icon: const Icon(
                      Icons.calendar_month,
                      color: blueColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Time of departure: ",
                style: TextStyle(fontFamily: "PoppinsBold"),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    timeOfDay.format(context).toString(),
                    style: const TextStyle(fontFamily: "PoppinsRegular"),
                  ),
                  IconButton(
                    onPressed: () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      ).then((value) {
                        setState(() {
                          timeOfDay = value!;
                        });
                      });
                    },
                    icon: const Icon(
                      Icons.timelapse_sharp,
                      color: blueColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              GestureDetector(
                  onTap: () {
                    Provider.of<AuthService>(context, listen: false)
                        .registerRide(
                      FirebaseAuth.instance.currentUser!.uid,
                      fromController.text.toLowerCase(),
                      toController.text.toLowerCase(),
                      contactNumberController.text,
                      timeOfDay.format(context).toString(),
                      datetime.toString().substring(0, 10),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text("Ride Added! (Visible to all other users)")));
                  },
                  child: const ButtonComponent(text: "Register Ride"))
            ],
          ),
        ),
      ),
    );
  }
}
