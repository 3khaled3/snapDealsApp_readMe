// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: CustomTabBarPage());
//   }
// }

// class CustomTabBarPage extends StatefulWidget {
//   @override
//   _CustomTabBarPageState createState() => _CustomTabBarPageState();
// }

// class _CustomTabBarPageState extends State<CustomTabBarPage> {
//   int selectedIndex = 0;

//   final List<String> tabs = ["Overview", "Lessons", "Reviews"];

//   final List<Widget> tabContents = [
//     Center(child: Text("Overview Content", style: TextStyle(fontSize: 18))),
//     Center(child: Text("Lessons Content", style: TextStyle(fontSize: 18))),
//     Center(child: Text("Reviews Content", style: TextStyle(fontSize: 18))),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Custom TabBar"),
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: Column(
//         children: [
//           /// Custom TabBar
//           Container(
//             margin: EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.deepPurple.shade50,
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Row(
//               children: List.generate(tabs.length, (index) {
//                 bool isSelected = index == selectedIndex;
//                 return Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         selectedIndex = index;
//                       });
//                     },
//                     child: AnimatedContainer(
//                       duration: Duration(milliseconds: 300),
//                       padding: EdgeInsets.symmetric(vertical: 12),
//                       decoration: BoxDecoration(
//                         color:
//                             isSelected ? Colors.deepPurple : Colors.transparent,
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: Center(
//                         child: Text(
//                           tabs[index],
//                           style: TextStyle(
//                             color:
//                                 isSelected ? Colors.white : Colors.deepPurple,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               }),
//             ),
//           ),

//           /// Tab Content
//           Expanded(
//             child: AnimatedSwitcher(
//               duration: Duration(milliseconds: 300),
//               child: tabContents[selectedIndex],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
