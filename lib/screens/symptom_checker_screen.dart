// import 'package:flutter/material.dart';
// import '../models/condition.dart';
// import '/models/symptom.dart';
// import '/services/api_service.dart';
// import '/utils/constants.dart';
// import '/utils/styles.dart';
// import '/widgets/custom_app_bar.dart';
// import '/widgets/symptom_card.dart';
// import 'condition_detail_screen.dart';
//
// class SymptomCheckerScreen extends StatefulWidget {
//   const SymptomCheckerScreen({super.key});
//
//   @override
//   _SymptomCheckerScreenState createState() => _SymptomCheckerScreenState();
// }
//
// class _SymptomCheckerScreenState extends State<SymptomCheckerScreen> {
//   final ApiService _apiService = ApiService();
//   late Future<List<Symptom>> _symptomsFuture;
//   final List<Symptom> _selectedSymptoms = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _symptomsFuture = _apiService.getSymptoms();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'Symptom Checker',
//         actions: [
//           if (_selectedSymptoms.isNotEmpty)
//             IconButton(
//               icon: const Icon(Icons.check),
//               onPressed: () {
//                 // Analyze symptoms
//                 _analyzeSymptoms();
//               },
//             ),
//         ],
//       ),
//       body: FutureBuilder<List<Symptom>>(
//         future: _symptomsFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No symptoms found'));
//           } else {
//             return Column(
//               children: [
//                 if (_selectedSymptoms.isNotEmpty)
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     color: AppConstants.lightGray,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Selected Symptoms (${_selectedSymptoms.length})',
//                           style: Styles.subheadingStyle,
//                         ),
//                         const SizedBox(height: 8),
//                         Wrap(
//                           spacing: 8,
//                           children: _selectedSymptoms
//                               .map((symptom) => Chip(
//                             label: Text(symptom.name),
//                             onDeleted: () {
//                               setState(() {
//                                 _selectedSymptoms.remove(symptom);
//                               });
//                             },
//                           ))
//                               .toList(),
//                         ),
//                       ],
//                     ),
//                   ),
//                 Expanded(
//                   child: ListView.builder(
//                     padding: const EdgeInsets.all(16),
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (context, index) {
//                       final symptom = snapshot.data![index];
//                       return SymptomCard(
//                         name: symptom.name,
//                         category: symptom.category,
//                         severity: symptom.severity,
//                         onTap: () {
//                           setState(() {
//                             if (_selectedSymptoms.contains(symptom)) {
//                               _selectedSymptoms.remove(symptom);
//                             } else {
//                               _selectedSymptoms.add(symptom);
//                             }
//                           });
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             );
//           }
//         },
//       ),
//       floatingActionButton: _selectedSymptoms.isNotEmpty
//           ? FloatingActionButton.extended(
//         onPressed: () {
//           _analyzeSymptoms();
//         },
//         icon: const Icon(Icons.medical_services),
//         label: const Text('Analyze Symptoms'),
//         backgroundColor: AppConstants.primaryColor,
//       )
//           : null,
//     );
//   }
//
//   void _analyzeSymptoms() {
//     // Navigate to results screen with selected symptoms
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Possible Conditions'),
//           content: FutureBuilder<List<Condition>>(
//             future: _apiService.getConditionsForSymptom(_selectedSymptoms[0].id),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Text('Error: ${snapshot.error}');
//               } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                 return const Text('No conditions found');
//               } else {
//                 return SizedBox(
//                   width: double.maxFinite,
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (context, index) {
//                       final condition = snapshot.data![index];
//                       return ListTile(
//                         title: Text(condition.name),
//                         subtitle: Text(condition.category),
//                         onTap: () {
//                           Navigator.pop(context);
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   ConditionDetailScreen(condition: condition),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 );
//               }
//             },
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Close'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }