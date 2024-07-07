import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/colors.dart';

class Task extends StatelessWidget {
  const Task({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.1),
                offset: const Offset(0, 4),
                blurRadius: 10)
          ]),
      duration: const Duration(milliseconds: 600),
      child: ListTile(
        // check Icon
        leading: GestureDetector(
          onTap: () => {
            //
          },
          child: GestureDetector(
            onTap: () => {
              //
            },
            child: AnimatedContainer(
              duration: const Duration(seconds: 600),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: 0.8)),
              child: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),
        ),

        // Title
        title: const Padding(
          padding: EdgeInsets.only(bottom: 5, top: 3),
          child: Text(
            "Done",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ),

        // Task Description
        subtitle: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Description",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(bottom: 10, top: 10),
                child: Column(
                  children: [
                    Text(
                      "Date",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    Text(
                      "SubDate",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
