import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoreTiles extends StatelessWidget {
  final String itemName;
  final String imagePath;
  final color;
  final bool isFavourite;
  void Function()? onPressed;
  void Function()? onTapped;

  StoreTiles({
    super.key,
    required this.itemName,
    required this.imagePath,
    required this.color,
    required this.onPressed,
    required this.onTapped,
    required this.isFavourite,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color[400],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // item image
            GestureDetector(
              onTap: onTapped,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Image.network(
                  imagePath,
                  height: 64,
                ),
              ),
            ),

            // item name
            Text(
              itemName,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                GestureDetector(
                  onTap: (){
                    onPressed!();
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.yellow.shade500,
                    ),

                    child: Icon(
                      isFavourite?Icons.favorite:Icons.favorite_outline_rounded,
                      size: 24,
                      color: Colors.pinkAccent[100],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onTapped,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.yellow.shade500,
                    ),
                    child: Image.asset(
                      "assets/images/map.png",
                      height: 24,
                      width: 24,
                      fit:BoxFit.scaleDown,
                      color: Colors.pinkAccent[100],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
