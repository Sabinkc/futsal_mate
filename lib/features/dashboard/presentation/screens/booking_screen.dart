import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futsalmate/common/colors.dart';
import 'package:futsalmate/features/booking/controller/booking_controller.dart';
import 'package:futsalmate/features/booking/view/screens/futsal_detail_screen.dart';

class BookingScreen extends ConsumerStatefulWidget {
  const BookingScreen({super.key});

  @override
  ConsumerState<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final futsalRefR = ref.read(futsalDetailController);
      await futsalRefR.fetchFutsalDetails();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final futsalRef = ref.watch(futsalDetailController);

    return Scaffold(
      appBar: AppBar(
        title: Text("Bookings", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: CommonColors.primaryColor,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {},
              child: Text("Filter", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
      body: futsalRef.isFetchFutsalLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: CommonColors.primaryColor,
              ),
            )
          : ListView.builder(
              itemCount: futsalRef.futsalDetails.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => FutsalDetailScreen(
                            futsalDetail: futsalRef.futsalDetails[index],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        spacing: 10,
                        children: [
                          Image.network(
                            futsalRef.futsalDetails[index].imgeUrl,
                            height: 120,
                            width: 120,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(futsalRef.futsalDetails[index].name),
                              Text(
                                "Located at: ${futsalRef.futsalDetails[index].location}",
                              ),
                              Text(
                                "Fee: Rs.${futsalRef.futsalDetails[index].fee}",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
