import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/category_news.dart';
import 'package:flutter_news_app/datas/category_data.dart';
import 'package:flutter_news_app/datas/news_data.dart';
import 'package:flutter_news_app/models/category_model.dart';
import 'package:flutter_news_app/models/news_model.dart';
import 'package:flutter_news_app/news_view.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = List<CategoryModel>();
  List<NewsModel> articles = List<NewsModel>();

  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
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
        elevation: 12,
      ),
      body: _loading
          ? Container(
              child: Center(
                  child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
              )),
            )
          : NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowGlow();
                return;
              },
              child: Container(
                child: Column(
                  children: [
                    // Categories
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                      height: 90,
                      child: ListView.builder(
                        itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CategoryTile(
                            imageUrl: categories[index].imageUrl,
                            categoryName: categories[index].categoryName,
                          );
                        },
                      ),
                    ),

                    // News
                    Expanded(
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
                  ],
                ),
              ),
            ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final imageUrl, categoryName;

  CategoryTile({this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(
                    category: categoryName.toString().toLowerCase())));
      },
      child: Container(
        margin: EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 120,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black38,
              ),
              child: Text(
                categoryName,
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
            ),
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, description, url;

  BlogTile({this.imageUrl, this.title, this.description, this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewsView(
                      newsUrl: url,
                    )));
      },
      child: Container(
        child: Column(
          children: [
            Divider(
              thickness: 4,
              indent: 16,
              endIndent: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(imageUrl)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black38),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    title,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w800,
                      color: Colors.red,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(1.0, 3.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black38),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(description,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(1.0, 3.0),
                            blurRadius: 3.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
