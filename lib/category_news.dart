import 'package:flutter/material.dart';
import 'package:flutter_news_app/datas/news_data.dart';
import 'package:flutter_news_app/home_page.dart';
import 'package:flutter_news_app/models/news_model.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryNews extends StatefulWidget {
  final String category;

  const CategoryNews({Key key, this.category}) : super(key: key);

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  bool _loading = true;

  List<NewsModel> articles = new List<NewsModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Br",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w800,
                color: Colors.blue[900],
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(1.0, 3.0),
                    blurRadius: 3.0,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            Text(
              "ita",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w800,
                color: Colors.white,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(1.0, 3.0),
                    blurRadius: 3.0,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            Text(
              "in",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w800,
                color: Colors.red,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(1.0, 3.0),
                    blurRadius: 3.0,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              "Express",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w800,
                color: Colors.white,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(1.0, 3.0),
                    blurRadius: 3.0,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Opacity(
            opacity: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.assessment_outlined),
            ),
          ),
        ],
      ),
      body: _loading
          ? Container(
              child: Center(
                  child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
              )),
            )
          : Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.category.toUpperCase() + " NEWS",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  NotificationListener<OverscrollIndicatorNotification>(
                    onNotification:
                        (OverscrollIndicatorNotification overscroll) {
                      overscroll.disallowGlow();
                      return;
                    },
                    child: Expanded(
                      child: Container(
                        child: ListView.builder(
                          itemCount: articles.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return BlogTile(
                              title: articles[index].title,
                              description: articles[index].description,
                              imageUrl: articles[index].urlToImage,
                              url: articles[index].url,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
