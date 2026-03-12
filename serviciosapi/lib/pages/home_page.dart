import 'package:flutter/material.dart';
import 'dart:convert';
import '../model/cars.dart';
import '../services/service_cars.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var carHttpService = CarHttpService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SingleChildScrollView(
                child: Column(
                  children:  [
                    FutureBuilder<List<CarsModel>>(
                        future: carHttpService.getCars() ,
                        builder: (context, snapshot) {
                          if(snapshot.hasError){
                            return const Center(
                              child: Text("error"),
                            );
                          }

                          if(snapshot.connectionState == ConnectionState.done){
                            return ListCars(
                              cars: snapshot.data!,
                            );
                          }else{
                            return const CircularProgressIndicator();
                          }
                        }
                    ),
                  ],
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}

class ListCars extends StatelessWidget {
  final List<CarsModel> cars;

  const ListCars({Key? key,
    required this.cars
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 56,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const[
              Text("All Cars",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold
                ),
              ),
              Icon(Icons.filter_list_alt)
            ],
          ),
        ),
        const SizedBox(
          height: 10,
          width: 0,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cars.length,
          itemBuilder: (context, item){
            return ContainerCar(
              car: cars[item],
            );
          },
        )

      ],
    );

  }
}

class _Cars extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [

            /// IMAGEN BUS
            Image.asset(
              "assets/images/car.png",
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),

            const SizedBox(width: 10),

            /// INFORMACIÓN
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// LINEA + BADGE
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      /// LINEA (izquierda)
                      Expanded(
                        child: Text(
                          'Coche nombre',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      const SizedBox(width: 8),

                    ],
                  ),

                  const SizedBox(height: 4),

                  /// TIEMPOS
        
                  const Text(
                    "precio",
                    style: TextStyle(color: Colors.orange, fontSize: 12),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}