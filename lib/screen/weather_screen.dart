import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/model/weather.dart';
import '/widget/additional_weather_info.dart';
import '../widget/weather_info.dart';
import '/provider/weather_api_client.dart';

class WheatherScreen extends StatefulWidget {
  @override
  State<WheatherScreen> createState() => _WheatherScreenState();
}

class _WheatherScreenState extends State<WheatherScreen> {
  final cityController = TextEditingController();

  InputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
  );
  Future<Weather> weatherProvider(String info) {
    return Provider.of<WeatherApiClient>(context, listen: false)
        .getWeather(info);
  }

  Weather? futureWeather;
  bool isLoading = false;
  void getWeather(String city) async {
    setState(() => isLoading = true);
    try {
      futureWeather = await weatherProvider(city);
    } catch (_) {
      setState(() => isLoading = false);
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Wheather App',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        elevation: 1,
        centerTitle: true,
        // backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Search by City',
                        labelStyle: Theme.of(context).textTheme.bodySmall,
                        enabledBorder: border,
                        focusedBorder: border,
                      ),
                      controller: cityController,
                      onSubmitted: (info) {
                        if (info.trim().isEmpty) {
                          return;
                        }
                        setState(() {
                          getWeather(info);
                        });
                      },
                      onTapOutside: (_) =>
                          FocusManager.instance.primaryFocus!.unfocus(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          onPressed: () => getWeather(cityController.text),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            minimumSize: const Size(80, 58),
                          ),
                          child: const Icon(Icons.search),
                        ),
                ],
              ),
            ),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
            else
              futureWeather != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        WeatherInfo(weather: futureWeather),
                        const SizedBox(height: 20),
                        AdditionalWeatherInfo(weather: futureWeather),
                      ],
                    )
                  : Column(
                      children: [
                        Center(
                          child: Image.asset(
                            'assets/images/no_data.jpeg',
                            height: 400,
                          ),
                        ),
                        const Text(
                          'No Data!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
          ],
        ),
      ),
    );
  }
}
