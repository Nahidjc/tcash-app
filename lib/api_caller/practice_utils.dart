// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:rnd_flutter_app/model/todos_model.dart';

// class TodoUtils {
//   Future<TodoModel> getTodos() async {
//     List<TodoModel> todosData = [];
//     try {
//       // var response = await http.get(
//       //     Uri.parse('https://e-commerce-service-node.onrender.com/todo/all'));
//       // var request = http.Request('GET',
//       //     Uri.parse('https://e-commerce-service-node.onrender/todo/all'));
//       // http.StreamedResponse response = await request.send();

//       String url = 'https://e-commerce-service-node.onrender.com/todo/all';
//       final response = await http.get(Uri.parse(url));

//       if (response.statusCode == 200) {
//         var responseData = json.decode(response.body);
//         var rawTodos = responseData['todos'];
//         List<dynamic> data = jsonDecode(rawTodos);
//         data.forEach((element) {
//           TodoModel todoModel = TodoModel.fromJson(element);
//           todosData.add(todoModel);
//         });
//         return todosData;
//       } else {
//         return [];
//       }
//     } catch (e) {
//       throw Exception('Error');
//     }
//   }
// }



      // if (response.statusCode == 200) {
      //   // var rawTodos = await response.stream.bytesToString();
      //   // var rawTodos = response.body;
      //   // var todoList = rawTodos['todos'];

      // } else {
      //   throw Exception('Error');
      // }