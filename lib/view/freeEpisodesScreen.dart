import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/constants.dart';
import '../model/carouselModel.dart';
import '../widgets/textWidget.dart';
import 'moviedetailPage.dart';

class FreeEpisodesScreen extends StatefulWidget {
  const FreeEpisodesScreen({super.key});

  @override
  State<FreeEpisodesScreen> createState() => _FreeEpisodesScreenState();
}

class _FreeEpisodesScreenState extends State<FreeEpisodesScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double deviceheight = MediaQuery.of(context).size.height;
    double devicewidth = MediaQuery.of(context).size.width;

    Future<void> printval() async {
      print("updating value");
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          //2
          SliverAppBar(
            backgroundColor: backgroundColor,
            stretch: true,
            expandedHeight: deviceheight * 0.7,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    'NHV',
                    textScaleFactor: 1,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'SUBSCRIBE NOW',
                    textScaleFactor: 0.5,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'SO. MUCH. FREE.',
                    textScaleFactor: 0.35,
                    style: TextStyle(color: Colors.white),
                  ),
                  // SizedBox(height: 5),
                  Text(
                    'Plans start at only \$4.99/month',
                    textScaleFactor: 0.4,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              stretchModes: const [StretchMode.zoomBackground],
              background: Image.asset(
                'assets/image.png',
                fit: BoxFit.cover,
              ),
              collapseMode: CollapseMode.parallax,
            ),
          ),
          //3
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: TextWidget(text: "Continue Watching"),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 169,
                      child: Row(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: continueWatchinglist.length,
                                // shrinkWrap: true,
                                itemBuilder: (BuildContext context, index) {
                                  return GestureDetector(
                                    onTap: () => Get.to(MovieDetail(
                                      movieId: 2,
                                    )),
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      height: 169,
                                      width: devicewidth * 0.5,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  continueWatchinglist[index]
                                                      .imgurl),
                                              fit: BoxFit.fill)),
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
