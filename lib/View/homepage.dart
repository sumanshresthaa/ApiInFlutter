import 'package:flutter/material.dart';
import 'package:revisionapp/Services/network_helper.dart';

import '../Services/model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<TrendingData>? trendingData;

  @override
  void initState() {
    // TODO: implement initState
    trendingData = getTrendingData();
    super.initState();
  }

  Future<TrendingData>? getTrendingData() async {
    NetworkHelper networkHelper = NetworkHelper();
    return await networkHelper.getTrendingData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff242A32),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () async {
                NetworkHelper networkHelper = NetworkHelper();
                await networkHelper.getTrendingData();
              },
              child: Text(
                'What do you want to watch?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              //margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Color(0xFF67676D)),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Color(0xFF67676D),
                  ),
                  fillColor: Color(0xFF3A3F47),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 21,
            ),
            Container(
              height: 350,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: FutureBuilder<TrendingData>(
                  future: trendingData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data?.results?.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            var imageData =
                                snapshot.data?.results?[index].posterPath;
                            String? movieName =
                                snapshot.data?.results?[index].originalTitle;

                            String? description =
                                snapshot.data?.results?[index].overview;

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return TrendingDetailsPage(
                                        imageData, description);
                                  }));
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16))),
                                      height: 225,
                                      width: 150,
                                      child: Image.network(
                                        'https://image.tmdb.org/t/p/w500$imageData',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      movieName ?? 'No Name',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      //shrimmer
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Now Playing',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        height: 225,
                        width: 150,
                        child: Text('Hello '),
                      ),
                    );
                  }),
            ),
          ],
        ),
      )),
    );
  }
}

class TrendingDetailsPage extends StatelessWidget {
  final imageNetwork;
  final description;
  //Constructor
  // TrendingDetailsPage(var imageNetwork, var description) {
  //   this.imageNetwork = imageNetwork;
  //   this.description = description;
  // }

  TrendingDetailsPage(this.imageNetwork, this.description);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trending'),
      ),
      body: Column(children: [
        Container(
          width: 500,
          height: 200,
          child: Image.network(
            'https://image.tmdb.org/t/p/w500$imageNetwork',
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(description ?? '')
      ]),
    );
  }
}
