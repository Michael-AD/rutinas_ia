import 'package:get/get.dart';
import '../services/deepseek_service.dart';

class RoutineController extends GetxController {
  final DeepseekService deepseekService = DeepseekService();

  var selectedGoal = 'Perder peso'.obs;
  var daysPerWeek = 3.obs;
  
  var exercises = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  Future<void> fetchRoutine() async {
    isLoading.value = true;
    
    final data = await deepseekService.generarRutina(
      'Intermedio', 
      selectedGoal.value,
    );

    if (data != null && data.containsKey("choices")) {
      exercises.assignAll(parseExercises(data["choices"][0]["message"]["content"]));
    } else {
      Get.snackbar("Error", "No se pudo generar la rutina.");
    }

    isLoading.value = false;
  }

  List<Map<String, dynamic>> parseExercises(String responseText) {
    return responseText.split("\n").map((line) {
      final parts = line.split(" - ");
      return {
        "name": parts[0].trim(),
        "reps": parts.length > 1 ? parts[1].trim() : "Desconocido"
      };
    }).toList();
  }
}
