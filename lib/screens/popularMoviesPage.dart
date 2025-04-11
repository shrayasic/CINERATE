import 'package:flutter/material.dart';
import '../services/popularmoviesapi.dart';
import '../screens/movieDetailsPage.dart';
import '../screens/journal.dart';
import '../screens/cinetubepage.dart';

class MovieScreen extends StatefulWidget {
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  Future<List<Movie>>? _moviesFuture;

  @override
  void initState() {
    super.initState();
    _moviesFuture = ImdbApiService.fetchMostPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181B20), // Set background color to #181B20
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Popular',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text('FILMS', style: TextStyle(color: Colors.green)),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to Cinetube page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CinetubePage()), // Navigate to CinetubePage
                  );
                },
                child: const Text('CINETUBE', style: TextStyle(color: Colors.white)),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('LISTS', style: TextStyle(color: Colors.white)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MovieArticlesPage()), // Navigate to MovieArticlesPage
                  );
                },
                child: const Text('JOURNAL', style: TextStyle(color: Colors.white)),
              ),

            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.grey[850],
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: const Text(
                      'PRO',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  const Expanded(
                    child: Text(
                      'Remove ads, add profile stats, activity and service filters, favorite streaming services, watchlist alerts and more by upgrading to Pro.',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Popular this week',
                style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder(
              future: _moviesFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, // Number of columns
                      childAspectRatio: 0.6, // Adjust the aspect ratio as needed
                      mainAxisSpacing: 8.0, // Spacing between rows
                      crossAxisSpacing: 8.0, // Spacing between columns
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetailsPage(
                                movieId: snapshot.data![index].id ?? '',
                              ),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            snapshot.data![index].primaryImage ?? '',
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.white));
                } else {
                  return const Center(child: CircularProgressIndicator(color: Colors.white));
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}