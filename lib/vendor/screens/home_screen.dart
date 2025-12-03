import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import 'add_movie_screen.dart';
import 'movie_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> movies = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vendor App (Local)"),
      ),
      body: movies.isEmpty
          ? const Center(child: Text("No movies added yet"))
          : ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return ListTile(
                  leading: movie.imagePath.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            movie.imagePath,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          width: 70,
                          height: 70,
                          color: Colors.grey[300],
                          child: const Icon(Icons.movie),
                        ),
                  title: Text(movie.title),
                  subtitle: Text(movie.description),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MovieDetailsScreen(movie: movie),
                      ),
                    );
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        movies.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final newMovie = await Navigator.push<Movie?>(
            context,
            MaterialPageRoute(builder: (_) => const AddMovieScreen()),
          );
          if (newMovie != null) {
            setState(() {
              movies.add(newMovie);
            });
          }
        },
      ),
    );
  }
}
