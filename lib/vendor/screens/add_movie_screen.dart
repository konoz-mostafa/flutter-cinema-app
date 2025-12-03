import 'package:flutter/material.dart';
import '../models/movie_model.dart';

class AddMovieScreen extends StatefulWidget {
  const AddMovieScreen({super.key});

  @override
  State<AddMovieScreen> createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends State<AddMovieScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _imageController = TextEditingController();
  final _timeSlotsController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _imageController.dispose();
    _timeSlotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.indigo.shade700,
                Colors.purple.shade700,
              ],
            ),
          ),
        ),
        title: const Text('Add New Movie'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.indigo.shade700,
                        Colors.purple.shade700,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.indigo.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.movie_creation,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Create New Movie',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Fill in the details below',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Title Field
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Movie Title',
                    hintText: 'Enter movie title',
                    prefixIcon: Icon(Icons.title, color: Colors.indigo.shade700),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? "Please enter a title" : null,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                // Description Field
                TextFormField(
                  controller: _descController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter movie description',
                    prefixIcon: Icon(Icons.description, color: Colors.indigo.shade700),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  maxLines: 4,
                  validator: (value) =>
                      value == null || value.isEmpty ? "Please enter a description" : null,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                // Poster URL Field
                TextFormField(
                  controller: _imageController,
                  decoration: InputDecoration(
                    labelText: 'Poster URL',
                    hintText: 'https://images.unsplash.com/...',
                    prefixIcon: Icon(Icons.image, color: Colors.indigo.shade700),
                    filled: true,
                    fillColor: Colors.white,
                    helperText: 'Enter a valid image URL from the internet',
                    helperStyle: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                // Time Slots Field
                TextFormField(
                  controller: _timeSlotsController,
                  decoration: InputDecoration(
                    labelText: 'Time Slots',
                    hintText: '10:00 AM, 2:00 PM, 6:00 PM, 10:00 PM',
                    prefixIcon: Icon(Icons.schedule, color: Colors.indigo.shade700),
                    filled: true,
                    fillColor: Colors.white,
                    helperText: 'Separate multiple times with commas',
                    helperStyle: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? "Please enter at least one time slot" : null,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 30),
                // Submit Button
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.indigo.shade700,
                        Colors.purple.shade700,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.indigo.withOpacity(0.4),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final movie = Movie(
                          title: _titleController.text.trim(),
                          description: _descController.text.trim(),
                          imagePath: _imageController.text.trim(),
                          timeSlots: _timeSlotsController.text
                              .split(",")
                              .map((e) => e.trim())
                              .where((e) => e.isNotEmpty)
                              .toList(),
                        );
                        Navigator.pop(context, movie);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_circle_outline, size: 24),
                        SizedBox(width: 8),
                        Text(
                          'Add Movie',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
