import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/routine_controller.dart';
import 'routine_screen.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RoutineController controller = Get.put(RoutineController());

    return Scaffold(
      appBar: AppBar(title: const Text('Configura tu Rutina')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Selecciona tu objetivo:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Obx(() => DropdownButton<String>(
                  value: controller.selectedGoal.value,
                  items: ['Perder peso', 'Ganar músculo', 'Mantenerse en forma']
                      .map((goal) => DropdownMenuItem(value: goal, child: Text(goal)))
                      .toList(),
                  onChanged: (value) => controller.selectedGoal.value = value!,
                )),
            const SizedBox(height: 20),
            const Text('Días por semana:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Obx(() => Slider(
                  value: controller.daysPerWeek.value.toDouble(),
                  min: 1,
                  max: 7,
                  divisions: 6,
                  label: '${controller.daysPerWeek.value} días',
                  onChanged: (value) => controller.daysPerWeek.value = value.toInt(),
                )),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await controller.fetchRoutine();
                  Get.to(() => RoutineScreen());
                },
                child: const Text('Generar Rutina'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
