// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/utils/colors.dart';
// import 'package:get/get.dart';

// class AuthButton extends StatelessWidget {
//   const AuthButton(
//       {super.key,
//       required this.label,
//       required this.onPressed,
//       this.loading = false,
//       required this.disabled,
//       this.icon,
//       required this.color,
//       required this.textColor});

//   final String label;
//   final VoidCallback onPressed;
//   final bool loading;
//   final disabled;
//   final IconData? icon;
//   final Color color;
//   final Color textColor;

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: MaterialButton(
//       disabledColor: AppColors.primaryColor.withOpacity(0.6),
//       onPressed: disabled ? null : onPressed,
//       minWidth: double.infinity,
//       height: 50,
//       color: disabled ? color.withOpacity(0.6) : color,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: loading
//           ? const Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("Processing",
//                     style: TextStyle(color: Colors.white, fontSize: 16)),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 SizedBox(
//                   width: 20,
//                   height: 20,
//                   child: CircularProgressIndicator(
//                     color: Colors.white,
//                     strokeWidth: 2,
//                   ),
//                 ),
//               ],
//             )
//           : Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 icon != null
//                     ? Padding(
//                         padding: const EdgeInsets.only(right: 5),
//                         child: Icon(
//                           icon,
//                           color: AppColors.primaryColor,
//                         ),
//                       )
//                     : const SizedBox.shrink(),
//                 Text(
//                   label,
//                   style: TextStyle(color: textColor, fontSize: 16),
//                 ),
//               ],
//             ),
//     ));
//   }
// }
