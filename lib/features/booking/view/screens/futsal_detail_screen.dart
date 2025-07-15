import 'package:flutter/material.dart';
import 'package:futsalmate/common/colors.dart';
import 'package:futsalmate/features/booking/model/available_time_converter.dart';
import 'package:futsalmate/features/booking/model/futsal_detail_item_model.dart';
import 'package:futsalmate/features/booking/view/widgets/booking_widget.dart';

class FutsalDetailScreen extends StatelessWidget {
  final FutsalDetailItemModel futsalDetail;
  const FutsalDetailScreen({super.key, required this.futsalDetail});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text("Futsal Details", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: CommonColors.primaryColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            futsalDetail.imgeUrl,
            height: height * 0.3,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(futsalDetail.name),
                Text("Location: Shankhamul"),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Fee: Rs.${futsalDetail.fee}"),
                    Text("Rating: 4.1"),
                  ],
                ),
                SizedBox(height: 10),
                Text("Availability:"),
                Text("Today"),

                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: futsalDetail.availability.length,
                    itemBuilder: (context, index) {
                      bool isAvailable = futsalDetail.availability[index] == "1"
                          ? true
                          : false;
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                            color: isAvailable ? Colors.grey : Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              AvailableTimeConverter.availableTime[index],
                              style: TextStyle(
                                color: isAvailable
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Text("Tomorrow"),

                // SizedBox(
                //   height: 40,
                //   child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     itemCount: 6,
                //     itemBuilder: (context, index) {
                //       return Padding(
                //         padding: EdgeInsets.symmetric(horizontal: 10),
                //         child: Container(
                //           padding: EdgeInsets.symmetric(
                //             horizontal: 10,
                //             vertical: 4,
                //           ),
                //           decoration: BoxDecoration(
                //             border: Border.all(color: Colors.grey),
                //             borderRadius: BorderRadius.circular(10),
                //           ),
                //           child: Center(child: Text("7 A.M. - 8 A.M.")),
                //         ),
                //       );
                //     },
                //   ),
                // ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return BookingWidget(futsalDetail: futsalDetail);
                        },
                      );
                    },
                    child: Text("Book"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
