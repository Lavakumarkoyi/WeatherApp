// class searchApi {
//   static Future<void> getPlaceSuggestions(String query) async {
//     if (query.isEmpty) {
//       setState(() {
//         _placeSuggestions = [];
//       });
//       return;
//     }

//     final url =
//         'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$_apiKey&components=country:us'; // You can adjust the country code or add more parameters as needed.

//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       final json = jsonDecode(response.body);
//       setState(() {
//         _placeSuggestions = json['predictions'];
//       });
//       print(json);
//     } else {
//       throw Exception('Failed to load place suggestions');
//     }
//   }
// }
