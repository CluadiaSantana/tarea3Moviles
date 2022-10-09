import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Search extends StatelessWidget {
  const Search({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        itemCount: 8,
        itemBuilder: (context, index) {
          return Container(
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: (() {}),
                    icon: Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.white,
                      child: Image.asset(
                        "assets/file.jpg",
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    iconSize: 120),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.white,
                      child: Container(
                        color: Colors.white,
                        height: 10,
                        width: 150,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.white,
                      child: Container(
                        color: Colors.white,
                        height: 10,
                        width: 150,
                      )),
                ),
              ],
            )),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
      ),
    );
  }
}
