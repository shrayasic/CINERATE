import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dart_rss/dart_rss.dart';
import 'package:html/parser.dart';
import '../../widgets/moviecard.dart';

class MovieArticlesPage extends StatefulWidget {
  @override
  _MovieArticlesPageState createState() => _MovieArticlesPageState();
}

class _MovieArticlesPageState extends State<MovieArticlesPage> {
  List<RssItem> _articles = [];

  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  // Fetch RSS feed from Screen Rant
  Future<void> fetchArticles() async {
    try {
      final response = await http.get(Uri.parse('https://screenrant.com/feed/'));
      if (response.statusCode == 200) {
        final feed = RssFeed.parse(response.body);
        setState(() {
          _articles = feed.items;
        });
      } else {
        print("Failed to load RSS feed: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching articles: $e");
    }
  }

  // Extract the first image from the article's description
  String extractImage(RssItem article) {
    if (article.media?.contents?.isNotEmpty ?? false) {
      return article.media!.contents!.first.url ?? '';
    } else if (article.enclosure?.url != null) {
      return article.enclosure!.url!;
    }

    // Try to extract image from description as fallback
    var document = parse(article.description ?? '');
    var imgTag = document.getElementsByTagName('img');
    return imgTag.isNotEmpty ? imgTag.first.attributes['src'] ?? '' : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Articles"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: _articles.isEmpty
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _articles.length,
        itemBuilder: (context, index) {
          var article = _articles[index];
          String imageUrl = extractImage(article);

          // Extract clean text description
          String cleanDescription = "";
          try {
            var document = parse(article.description ?? "");
            cleanDescription = document.body?.text ?? "No Description";
          } catch (e) {
            cleanDescription = "No Description";
          }

          return MovieArticleCard(
            title: article.title ?? "No Title",
            description: cleanDescription,
            imageUrl: imageUrl.isNotEmpty ? imageUrl : "https://via.placeholder.com/200",
            url: article.link ?? "#",
          );
        },
      ),
    );
  }
}