import 'package:flutter/material.dart';
import '../models/movie_model.dart';

class AddMovieScreen extends StatefulWidget {
  final Movie? movieToEdit; // If provided, we're in edit mode

  const AddMovieScreen({super.key, this.movieToEdit});

  @override
  State<AddMovieScreen> createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends State<AddMovieScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _imageController = TextEditingController();
  final _timeSlotController = TextEditingController();
  List<String> _timeSlots = [];
  bool get isEditMode => widget.movieToEdit != null;

  @override
  void initState() {
    super.initState();
    if (isEditMode) {
      _titleController.text = widget.movieToEdit!.title;
      _descController.text = widget.movieToEdit!.description;
      _imageController.text = widget.movieToEdit!.imagePath;
      _timeSlots = List<String>.from(widget.movieToEdit!.timeSlots);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _imageController.dispose();
    _timeSlotController.dispose();
    super.dispose();
  }

  void _addTimeSlot() {
    final timeSlot = _timeSlotController.text.trim();
    if (timeSlot.isNotEmpty && !_timeSlots.contains(timeSlot)) {
      setState(() {
        _timeSlots.add(timeSlot);
        _timeSlotController.clear();
      });
    }
  }

  void _removeTimeSlot(int index) {
    setState(() {
      _timeSlots.removeAt(index);
    });
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
        title: Text(isEditMode ? 'Edit Movie' : 'Add New Movie'),
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
                      Text(
                        isEditMode ? 'Edit Movie Details' : 'Create New Movie',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isEditMode ? 'Update the details below' : 'Fill in the details below',
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
                // Time Slots Section
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.schedule, color: Colors.indigo.shade700, size: 20),
                          const SizedBox(width: 8),
                          const Text(
                            'Time Slots',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Time Slot Input and Add Button
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _timeSlotController,
                              decoration: InputDecoration(
                                hintText: 'e.g., 10:00 AM',
                                prefixIcon: Icon(Icons.access_time, color: Colors.indigo.shade700),
                                filled: true,
                                fillColor: Colors.grey.shade50,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.grey.shade300),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.grey.shade300),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.indigo.shade700, width: 2),
                                ),
                              ),
                              style: const TextStyle(fontSize: 16),
                              onFieldSubmitted: (_) => _addTimeSlot(),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.indigo.shade600,
                                  Colors.purple.shade600,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.indigo.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: IconButton(
                              onPressed: _addTimeSlot,
                              icon: const Icon(Icons.add, color: Colors.white),
                              tooltip: 'Add Time Slot',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (_timeSlots.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'No time slots added yet. Add at least one time slot.',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        )
                      else
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: List.generate(_timeSlots.length, (index) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.indigo.shade600,
                                    Colors.purple.shade600,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.indigo.withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.schedule, color: Colors.white, size: 16),
                                  const SizedBox(width: 6),
                                  Text(
                                    _timeSlots[index],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () => _removeTimeSlot(index),
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Submit Button with gradient
                SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_timeSlots.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please add at least one time slot'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

final movie = Movie(
  id: UniqueKey().toString(), // او أي id يناسبك
  title: _titleController.text.trim(),
  description: _descController.text.trim(),
  imagePath: _imageController.text.trim(),
  timeSlots: List<String>.from(_timeSlots),
  totalSeats: isEditMode ? widget.movieToEdit!.totalSeats : 47,
  bookings: isEditMode
      ? Map<String, List<int>>.from(widget.movieToEdit!.bookings)
      : {for (var slot in _timeSlots) slot: []},
);

                        Navigator.pop(context, movie);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.indigo.shade700, Colors.purple.shade700],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(isEditMode ? Icons.save : Icons.add_circle_outline, size: 24),
                            const SizedBox(width: 8),
                            Text(
                              isEditMode ? 'Update Movie' : 'Add Movie',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
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
