import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/setUpPage.dart';
import "package:flutter_application_1/main.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String city = "";
  String degrees = "";

  Future<String> _getCity() async {
    final prefs = await SharedPreferences.getInstance();

    // Try reading data from the counter key
    final storedCity = prefs.getString('city') ?? "";

    setState(() {
      city = storedCity;
    });

    print(storedCity);

    return storedCity;
  }

  void fetchWeather() async {
    String storedCity = await _getCity();

    final response = await http.get(
      Uri.parse(
          'https://weatherapi-com.p.rapidapi.com/forecast.json?q=$storedCity'),
      headers: {
        'X-RapidAPI-Key': 'db71704f19msh88d6864049e95f9p1d8246jsn7b4509734d9a',
        'X-RapidAPI-Host': 'weatherapi-com.p.rapidapi.com'
      },
    );
    if (response.statusCode == 200) {
      var weather = json.decode(response.body)['current']['temp_c'];
      var formattedWeather = weather.toString();
      setState(() {
        degrees = formattedWeather;
      });
    }
  }

  @override
  initState() {
    fetchWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: city != "" && degrees != ""
            ? Container(
                constraints: BoxConstraints.expand(),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://i.pinimg.com/564x/4e/22/57/4e2257ce54d1359137c6f15b0d16b3ec.jpg"),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin:
                                const EdgeInsets.only(top: 60.0, left: 40.0),
                            child: Row(
                              children: [
                                Text(
                                  city,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.normal),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.white70,
                                    size: 20.0,
                                  ),
                                )
                              ],
                            ))
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 30.0, left: 30.0),
                          child: Text(
                            "$degrees°",
                            style: const TextStyle(
                                fontSize: 140,
                                color: Colors.white70,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                        child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.white,
                              height: 250,
                              padding: EdgeInsets.only(top: 20),
                              alignment: Alignment.center,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            "Weather today",
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 50,
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30, right: 30),
                                              child: Column(
                                                children: [
                                                  Icon(Icons.sunny,
                                                      color: Colors
                                                          .yellow.shade700,
                                                      size: 40.0),
                                                  Text("05:00 AM",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors
                                                              .grey.shade400)),
                                                  const Text("16°",
                                                      style: TextStyle(
                                                          fontSize: 30,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold))
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30, right: 30),
                                              child: Column(
                                                children: [
                                                  Icon(Icons.cloud,
                                                      color:
                                                          Colors.grey.shade500,
                                                      size: 40.0),
                                                  Text("08:00 AM",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors
                                                              .grey.shade400)),
                                                  const Text("14°",
                                                      style: TextStyle(
                                                          fontSize: 30,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold))
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30, right: 30),
                                              child: Column(
                                                children: [
                                                  Icon(Icons.thunderstorm,
                                                      color:
                                                          Colors.grey.shade500,
                                                      size: 40.0),
                                                  Text("10:00 AM",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors
                                                              .grey.shade400)),
                                                  const Text("16°",
                                                      style: TextStyle(
                                                          fontSize: 30,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold))
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ]),
                            ),
                          )
                        ],
                      ),
                    ))
                  ],
                ))
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
