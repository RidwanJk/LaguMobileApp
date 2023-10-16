import 'package:flutter/material.dart';
import 'package:myapp/widgets/custom_widged.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        color: const Color.fromARGB(255, 19, 5, 49),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Text(
                  "Search",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontFamily: "Inter-Bold",
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(child: SearchBox(), width: 333),
                      InkWell(
                        onTap: () {
                          print("Search");
                        },
                        child: Icon(
                          Icons.mic,
                          color: Colors.white, // Set the color to white
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            Container(
              child: Flexible(child: GridViewSearch()),
            ),
          ],
        ),
      ),
    );
  }
}
