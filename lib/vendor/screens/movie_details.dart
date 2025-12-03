import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import 'seats_view_screen.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            movie.imagePath.isNotEmpty
                ? Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(movie.imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[300],
                    ),
                    child: const Center(child: Icon(Icons.movie, size: 50)),
                  ),
            const SizedBox(height: 16),
            Text(movie.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            const Text(
              "Time Slots:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 10,
              children: movie.timeSlots
                  .map((slot) => Chip(label: Text(slot)))
                  .toList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SeatsViewScreen(movie: movie),
                  ),
                );
              },
              child: const Text("View Seats"),
            ),
          ],
        ),
      ),
    );
  }
}
