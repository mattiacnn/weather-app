import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/pages/home.dart';

class SetUpPage extends StatefulWidget {
  const SetUpPage({super.key});

  @override
  State<SetUpPage> createState() => _SetUpPageState();
}

class _SetUpPageState extends State<SetUpPage> {
  List cities = [];
  List _foundCities = [];

  fetchCities() async {
    final response = await http.get(
      Uri.parse(
          'https://countries-cities.p.rapidapi.com/location/country/US/city/list?population=1000000'),
      headers: {
        'X-RapidAPI-Key': 'db71704f19msh88d6864049e95f9p1d8246jsn7b4509734d9a',
        'X-RapidAPI-Host': 'countries-cities.p.rapidapi.com'
      },
    );
    if (response.statusCode == 200) {
      var items = json.decode(response.body)['cities'];
      setState(() {
        cities = items;
        _foundCities = items;
      });
    }
  }

  // check if city exists
  Future _checkCity() async {
    final prefs = await SharedPreferences.getInstance();

    // Try reading data from the counter key
    final city = prefs.getString('city') ?? "";

    if (city != "") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } else {
      fetchCities();
    }
  }

  @override
  initState() {
    _foundCities = [];
    _checkCity();
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all the cities
      results = cities;
    } else {
      results = cities
          .where((city) =>
              city["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundCities = results;
    });
  }

  // save the default city to local storage
  void _saveCity(String cityName) async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

    // set value
    await prefs.setString('city', cityName);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://bst.icons8.com/wp-content/themes/icons8/app/uploads/2018/04/digital-art-city-illustration.jpg"),
                  fit: BoxFit.cover),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Hello, \nadd your city",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      autocorrect: false,
                      onChanged: (value) => _runFilter(value),
                      decoration: const InputDecoration(
                        labelText: 'Search',
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        labelStyle: TextStyle(color: Colors.black),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: _foundCities.isNotEmpty
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.white, spreadRadius: 3),
                                  ],
                                ),
                                padding: const EdgeInsets.all(10),
                                child: ListView.builder(
                                  itemCount: _foundCities.length,
                                  itemBuilder: (context, index) => Card(
                                    key: ValueKey(_foundCities[index]["id"]),
                                    color: Colors.white,
                                    elevation: 1,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5),
                                          bottomRight: Radius.circular(5),
                                          bottomLeft: Radius.circular(5)),
                                    ),
                                    child: ListTile(
                                      onTap: () => _saveCity(
                                          _foundCities[index]['name']),
                                      leading: const Icon(Icons.location_on,
                                          color: Colors.black, size: 30.0),
                                      title: Text(_foundCities[index]['name'],
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ),
                                ),
                              )
                            : const Center(
                                child: CircularProgressIndicator(),
                              ))
                  ],
                ),
              ),
            )));
  }
}
