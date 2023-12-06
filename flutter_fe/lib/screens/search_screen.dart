import 'package:flutter/material.dart';
import 'package:flutter_fe/widgets/custom_bottom_app_bar.dart';

class SearchScreen extends StatefulWidget{
  static const routeName = '/search';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();

}

class _SearchScreenState extends State<SearchScreen>{

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: const CustomBottomAppBar(),
      body: Center(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(10.0),
              child:
                SearchBar(
                  elevation: MaterialStateProperty.all(20.0),
                  leading: const Icon(Icons.search),
                  backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 240, 240, 240)
                  ),
                  controller: textController,
                  hintText: "Are you searching for something?",
                  hintStyle: MaterialStateProperty.all(const TextStyle(color: Colors.grey)),
                  //TODO: erre is irni egy fuggvenyt hogy geteljen
                  onSubmitted:(value) {textController.clear();},
                ),
            ),
          ]
        ) ,
        )
    );
  }

  void search(){

  }
}

// class SearchScreen extends StatelessWidget{
//   static const routeName = '/search';

//   const SearchScreen({super.key});

//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       bottomNavigationBar: const CustomBottomAppBar(),
//       body: Container(
//         alignment: Alignment.center,
//         child: const Text(
//           'Search',
//           style: TextStyle(fontSize:24),
//         ),
//       ),
//     );
//   }
// }