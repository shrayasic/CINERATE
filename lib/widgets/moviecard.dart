import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieArticleCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String url;

  const MovieArticleCard({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.url,
    Key? key,
  }) : super(key: key);

  void _launchURL() async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _launchURL,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Article Image
            SizedBox(
              width: double.infinity,
              height: 180,
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/placeholder.png', // Make sure you have this asset
                image: imageUrl,
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) => Container(
                  width: double.infinity,
                  height: 180,
                  color: Colors.grey[800],
                  child: const Icon(Icons.image, size: 50, color: Colors.grey),
                ),
              ),
            ),

            // Title & Description
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}