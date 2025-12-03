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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Movie")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Title"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter title" : null,
              ),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: "Description"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter description" : null,
              ),
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(
                    labelText: "Image Path (assets/local)"),
              ),
              TextFormField(
                controller: _timeSlotsController,
                decoration: const InputDecoration(
                    labelText: "Time Slots (comma separated)"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter time slots" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text("Add Movie"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final movie = Movie(
                      title: _titleController.text,
                      description: _descController.text,
                      imagePath: _imageController.text,
                      timeSlots: _timeSlotsController.text
                          .split(",")
                          .map((e) => e.trim())
                          .toList(),
                    );
                    Navigator.pop(context, movie);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
