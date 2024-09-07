import 'package:bmicalculator/constants.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int height = 150;
  int weight = 70;
  String gender = '';
  late double bmi = calculateBMI(height: height, weight: weight);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(height: 80),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5), 
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          gender = "Male";
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.orange.withAlpha(40),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: const Column(
                          children: [
                            Icon(Icons.male, size: 150),
                            Text('Male', style: TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          gender = "Female";
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.orange.withAlpha(40),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: const Column(
                          children: [
                            Icon(Icons.female, size: 150),
                            Text('Female', style: TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        const Text('Height', style: TextStyle(fontSize: 20)),
                        Text('$height', style: kInputLabelTextStyle),
                        Row(
                          children: [
                            FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  if (height > 0) height--;
                                  bmi = calculateBMI(
                                      height: height, weight: weight);
                                });
                              },
                              child: const Icon(Icons.remove),
                            ),
                            const SizedBox(width: 40),
                            FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  if (height < 250) height++;
                                  bmi = calculateBMI(
                                      height: height, weight: weight);
                                });
                              },
                              child: const Icon(Icons.add),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        const Text('Weight', style: TextStyle(fontSize: 20)),
                        Text('$weight', style: kInputLabelTextStyle),
                        Row(
                          children: [
                            FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  if (weight > 25) weight--;
                                  bmi = calculateBMI(
                                      height: height, weight: weight);
                                });
                              },
                              child: const Icon(Icons.remove),
                            ),
                            const SizedBox(width: 40),
                            FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  if (weight < 300) weight++;
                                  bmi = calculateBMI(
                                      height: height, weight: weight);
                                });
                              },
                              child: const Icon(Icons.add),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              Container(
                height: 200,
                width: 350,
                decoration: BoxDecoration(
                  color: gender == 'Male'
                      ? Colors.blue.withAlpha(50)
                      : Colors.pink.withAlpha(50),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('BMI', style: TextStyle(fontSize: 20)),
                    Text(bmi.toStringAsFixed(2),
                        style: kOutputLabelTextStyle.copyWith(
                            color:
                                gender == 'Male' ? Colors.blue : Colors.pink)),
                    Text(getResult(bmi),
                        style: kOutputLabelTextStyle.copyWith(
                            color:
                                gender == 'Male' ? Colors.blue : Colors.pink, fontSize: 35,), ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  double calculateBMI({required int height, required int weight}) {
    return (weight / (height * height)) * 10000;
  }

  static String getResult(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi < 24.9) {
      return 'Normal';
    } else if (bmi < 29.9) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }
}
