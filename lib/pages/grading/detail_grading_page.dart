// import 'package:fish/pages/grading/detail_grading_controller.dart';
// import 'package:fish/widgets/drawer_inventaris_list.dart';
// import 'package:flutter/material.dart';
// import 'package:fish/theme.dart';
// import 'package:get/get.dart';
//
// import '../../widgets/new_Menu_widget.dart';
//
// class DetailGradingPage extends StatefulWidget {
//   const DetailGradingPage({Key? key}) : super(key: key);
//
//   @override
//   State<DetailGradingPage> createState() => _DetailGradingPageState();
// }
//
// class _DetailGradingPageState extends State<DetailGradingPage> {
//   var isMenuTapped = false.obs;
//   @override
//   Widget build(BuildContext context) {
//     var scaffoldKey = GlobalKey<ScaffoldState>();
//
//     final GradingDetailController controller =
//         Get.put(GradingDetailController());
//
//     Widget gradingDataRecap() {
//       return Container(
//         margin: EdgeInsets.only(
//             top: defaultSpace, right: defaultMargin, left: defaultMargin),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "kolam ${controller.pond.alias}",
//                   style: primaryTextStyle.copyWith(
//                     fontSize: 18,
//                     fontWeight: heavy,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       );
//     }
//
//     Widget detail() {
//       return Container(
//         width: double.infinity,
//         margin: EdgeInsets.only(
//             top: defaultSpace, right: defaultMargin, left: defaultMargin),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Masa Budidaya",
//                   style: primaryTextStyle.copyWith(
//                     fontSize: 14,
//                     fontWeight: medium,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                 ),
//                 if (controller.activation.getStringDeactivationDate() == "-")
//                   Text(
//                     "${controller.activation.getStringActivationDate()} sampai ${DateTime.now().toString().split(" ")[0]}",
//                     style: secondaryTextStyle.copyWith(
//                       fontSize: 13,
//                       fontWeight: medium,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 1,
//                   ),
//                 if (controller.activation.getStringDeactivationDate() != "-")
//                   Text(
//                   "${controller.activation.getStringActivationDate()} sampai ${controller.activation.getStringDeactivationDate()}",
//                   style: secondaryTextStyle.copyWith(
//                     fontSize: 13,
//                     fontWeight: medium,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Oversize",
//                           style: primaryTextStyle.copyWith(
//                             fontSize: 14,
//                             fontWeight: medium,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 1,
//                         ),
//                         Text(
//                           "> ${controller.fishGrading.avgFishWeight! * controller.activation.consOver!} gram",
//                           style: secondaryTextStyle.copyWith(
//                             fontSize: 13,
//                             fontWeight: medium,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 1,
//                         ),
//                       ],
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           width: 40,
//                         ),
//                       ],
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Oversize",
//                           style: primaryTextStyle.copyWith(
//                             fontSize: 14,
//                             fontWeight: medium,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 1,
//                         ),
//                         Text(
//                           "> ${controller.fishGrading.avgFishWeight! * controller.activation.consUnder!} gram",
//                           style: secondaryTextStyle.copyWith(
//                             fontSize: 13,
//                             fontWeight: medium,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 1,
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       );
//     }
//
//     Widget titleRecap() {
//       return Container(
//         margin: EdgeInsets.only(
//             top: defaultSpace, right: defaultMargin, left: defaultMargin),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Data Grading",
//                   style: primaryTextStyle.copyWith(
//                     fontSize: 18,
//                     fontWeight: heavy,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       );
//     }
//
//     Widget dataGrading() {
//       return Container(
//         width: double.infinity,
//         margin: EdgeInsets.only(
//             top: defaultSpace, right: defaultMargin, left: defaultMargin),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Tanggal",
//                   style: primaryTextStyle.copyWith(
//                     fontSize: 14,
//                     fontWeight: medium,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                 ),
//                 Text(
//                   "${controller.fishGrading.getDate()}",
//                   style: secondaryTextStyle.copyWith(
//                     fontSize: 13,
//                     fontWeight: medium,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       );
//     }
//
//     Widget detailGrading() {
//       return Container(
//         width: double.infinity,
//         margin: EdgeInsets.only(
//             top: defaultSpace, right: defaultMargin, left: defaultMargin),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Jenis Ikan",
//                   style: primaryTextStyle.copyWith(
//                     fontSize: 14,
//                     fontWeight: medium,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                 ),
//                 Text(
//                   controller.fishGrading.fishType!,
//                   style: secondaryTextStyle.copyWith(
//                     fontSize: 13,
//                     fontWeight: medium,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   "Panjang rata rata",
//                   style: primaryTextStyle.copyWith(
//                     fontSize: 14,
//                     fontWeight: medium,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                 ),
//                 Text(
//                   "${controller.fishGrading.avgFishLong ?? 0} cm",
//                   style: secondaryTextStyle.copyWith(
//                     fontSize: 13,
//                     fontWeight: medium,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   "Jumlah Undersize",
//                   style: primaryTextStyle.copyWith(
//                     fontSize: 14,
//                     fontWeight: medium,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                 ),
//                 Text(
//                   "${controller.fishGrading.undersizeFish} Ekor",
//                   style: secondaryTextStyle.copyWith(
//                     fontSize: 13,
//                     fontWeight: medium,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                 ),
//               ],
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Jumlah Sample",
//                   style: primaryTextStyle.copyWith(
//                     fontSize: 14,
//                     fontWeight: medium,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                 ),
//                 Text(
//                   "${controller.fishGrading.samplingAmount}/100 Ekor",
//                   style: secondaryTextStyle.copyWith(
//                     fontSize: 13,
//                     fontWeight: medium,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   "Bobot rata rata",
//                   style: primaryTextStyle.copyWith(
//                     fontSize: 14,
//                     fontWeight: medium,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                 ),
//                 Text(
//                   "${controller.fishGrading.avgFishWeight} gram",
//                   style: secondaryTextStyle.copyWith(
//                     fontSize: 13,
//                     fontWeight: medium,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   "Jumlah Oversize",
//                   style: primaryTextStyle.copyWith(
//                     fontSize: 14,
//                     fontWeight: medium,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                 ),
//                 Text(
//                   "${controller.fishGrading.oversizeFish} Ekor",
//                   style: secondaryTextStyle.copyWith(
//                     fontSize: 13,
//                     fontWeight: medium,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       );
//     }
//
//     return Obx(() {
//       if (controller.isLoading.value == false) {
//         return Scaffold(
//           key: scaffoldKey,
//           appBar: AppBar(
//             backgroundColor: backgroundColor2,
//             title: const Text("Detail Rekap Grading"),
//             actions: [
//               IconButton(
//                 onPressed: () {
//                   // scaffoldKey.currentState?.openEndDrawer();
//                   setState(() {
//                     isMenuTapped.value = !isMenuTapped.value;
//                   });
//                 },
//                 icon: Icon(Icons.card_travel_rounded),
//               )
//             ],
//           ),
//           endDrawer: DrawerInvetarisList(),
//           backgroundColor: backgroundColor1,
//           body: ListView(
//             children: [
//               if (isMenuTapped.value)
//                 Column(
//                   children: [
//                     newMenu(),
//                     SizedBox(height: 10,),
//                   ],
//                 ),
//               gradingDataRecap(),
//               detail(),
//               titleRecap(),
//               dataGrading(),
//               detailGrading(),
//               SizedBox(
//                 height: 10,
//               )
//             ],
//           ),
//         );
//       } else {
//         return Center(
//           child: CircularProgressIndicator(
//             color: secondaryColor,
//           ),
//         );
//       }
//     });
//   }
// }
