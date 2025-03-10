import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/routine_controller.dart';

class RoutineScreen extends StatelessWidget {
  RoutineScreen({super.key});

  final RoutineController routineController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tu Rutina")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (routineController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (routineController.exercises.isEmpty) {
            return const Center(child: Text("No se generó ninguna rutina."));
          }
          return ListView.builder(
            itemCount: routineController.exercises.length,
            itemBuilder: (context, index) {
              final exercise = routineController.exercises[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text(exercise["name"] ?? "Ejercicio"),
                  subtitle: Text("Repeticiones: ${exercise["reps"] ?? "-"}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.info_outline),
                    onPressed: () {
                      Get.snackbar("Detalles", exercise["description"] ?? "No hay información adicional.");
                    },
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
