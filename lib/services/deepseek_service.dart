// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';

class DeepseekService {
  final String apiUrl = 'https://openrouter.ai/api/v1/chat/completions';
  final String apiKey = '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'; // <-- ¡Pon tu API Key aquí!

  Future<Map<String, dynamic>?> generarRutina(String nivel, String objetivo) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey', // <-- Autorización con API Key
          'HTTP-Referer': 'tu-pagina.com', // Requerido por OpenRouter
          'X-Title': 'Creador de Rutinas'
        },
        body: jsonEncode({
          "model": "deepseek/deepseek-r1:free", // Especificamos el modelo
          "messages": [
            {
              "role": "system",
              "content": "Eres un entrenador personal experto en fitness."
            },
            {
              "role": "user",
              "content": "Genera una rutina de ejercicio detallada para un atleta de nivel $nivel con el objetivo de $objetivo. La rutina debe incluir exactamente 5 ejercicios con series y repeticiones recomendadas. Solo responde con la rutina y nada más."
            }
          ],
          "max_tokens": 500
        }),
      );

      print("Código de respuesta: ${response.statusCode}");
      print("Respuesta de la API: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Error al obtener la rutina: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error en la solicitud: $e');
      return null;
    }
  }
}
