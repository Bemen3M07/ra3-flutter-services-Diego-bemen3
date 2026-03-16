import 'package:flutter/material.dart';
import '../model/cars.dart';
import '../services/service_cars.dart';
import 'dart:math';

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
              Text("Lista de coches disponibles",
                style: TextStyle(
                    fontSize: 24,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 7,
          width: 0,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cars.length,
          itemBuilder: (context, item){
            return _Cars(
              car: cars[item],
            );
          },
        )

      ],
    );

  }
}

class _Cars extends StatelessWidget {
  final CarsModel car;
  final Random random = Random();

  _Cars({Key? key, required this.car}) : super(key: key);

  final List<String> _carsImage = [
    "assets/images/cocheAzul.png",
    "assets/images/cocheBlanco.png",
    "assets/images/cocheRojo.png",
  ];

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

            /// IMAGEN COCHE
            Image.asset(
              _carsImage[random.nextInt(_carsImage.length)],
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

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Expanded(
                        child: Text(
                          '${car.year} ${car.make} ${car.model}',
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
        
                  Text(
                    "Tipo de coche: ${car.type}",
                    style: TextStyle(color: Colors.black, fontSize: 12),
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