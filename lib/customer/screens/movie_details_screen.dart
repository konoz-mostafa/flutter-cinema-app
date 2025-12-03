import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:cached_network_image/cached_network_image.dart';
=======
>>>>>>> f099a548568129d8536f635149133ad46a1f80fe
import '../models/user.dart';
import '../models/movie.dart';
import 'seat_selection_screen.dart';

class MovieDetailsScreen extends StatefulWidget {
  final User user;
  final Movie movie;

  const MovieDetailsScreen({Key? key, required this.user, required this.movie})
<<<<<<< HEAD
      : super(key: key);
=======
    : super(key: key);
>>>>>>> f099a548568129d8536f635149133ad46a1f80fe

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  String? _selectedTimeSlot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      body: CustomScrollView(
        slivers: [
          // Modern App Bar with Image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  widget.movie.posterUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: widget.movie.posterUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.purple.shade400,
                                  Colors.indigo.shade400,
                                  Colors.blue.shade400,
                                ],
                              ),
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.purple.shade400,
                                  Colors.indigo.shade400,
                                  Colors.blue.shade400,
                                ],
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.movie_rounded,
                                size: 120,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.purple.shade400,
                                Colors.indigo.shade400,
                                Colors.blue.shade400,
                              ],
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.movie_rounded,
                              size: 120,
                              color: Colors.white,
                            ),
                          ),
                        ),
                  // Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              title: Text(
                widget.movie.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ),
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      widget.movie.description,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Time Slots Section
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.purple.shade600,
                              Colors.indigo.shade600,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Select Time Slot',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
=======
      appBar: AppBar(
        title: Text(widget.movie.title),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple.shade400, Colors.blue.shade400],
                ),
              ),
              child: Center(
                child: Text(
                  widget.movie.emoji,
                  style: const TextStyle(fontSize: 100),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movie.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Select Time Slot',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
>>>>>>> f099a548568129d8536f635149133ad46a1f80fe
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: widget.movie.timeSlots.map((slot) {
                      final isSelected = _selectedTimeSlot == slot;
<<<<<<< HEAD
                      return GestureDetector(
=======
                      return InkWell(
>>>>>>> f099a548568129d8536f635149133ad46a1f80fe
                        onTap: () {
                          setState(() {
                            _selectedTimeSlot = slot;
                          });
                        },
<<<<<<< HEAD
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
=======
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
>>>>>>> f099a548568129d8536f635149133ad46a1f80fe
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
<<<<<<< HEAD
                                ? Colors.purple.shade600
                                : Colors.white,
                            border: Border.all(
                              color: isSelected
                                  ? Colors.purple.shade600
                                  : Colors.grey.shade300,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: Colors.purple.withOpacity(0.3),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                : [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
=======
                                ? Colors.purple.shade50
                                : Colors.white,
                            border: Border.all(
                              color: isSelected
                                  ? Colors.purple
                                  : Colors.grey.shade300,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
>>>>>>> f099a548568129d8536f635149133ad46a1f80fe
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
<<<<<<< HEAD
                                Icons.schedule_rounded,
                                color: isSelected ? Colors.white : Colors.purple.shade600,
                                size: 20,
=======
                                Icons.access_time,
                                color: isSelected ? Colors.purple : Colors.grey,
>>>>>>> f099a548568129d8536f635149133ad46a1f80fe
                              ),
                              const SizedBox(width: 8),
                              Text(
                                slot,
                                style: TextStyle(
<<<<<<< HEAD
                                  color: isSelected ? Colors.white : Colors.grey.shade800,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w600,
                                  fontSize: 15,
=======
                                  color: isSelected
                                      ? Colors.purple
                                      : Colors.black,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
>>>>>>> f099a548568129d8536f635149133ad46a1f80fe
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  if (_selectedTimeSlot != null) ...[
<<<<<<< HEAD
                    const SizedBox(height: 32),
                    Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.purple.shade600,
                            Colors.indigo.shade600,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withOpacity(0.4),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
=======
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
>>>>>>> f099a548568129d8536f635149133ad46a1f80fe
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
<<<<<<< HEAD
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) =>
                                  SeatSelectionScreen(
=======
                            MaterialPageRoute(
                              builder: (context) => SeatSelectionScreen(
>>>>>>> f099a548568129d8536f635149133ad46a1f80fe
                                user: widget.user,
                                movie: widget.movie,
                                timeSlot: _selectedTimeSlot!,
                              ),
<<<<<<< HEAD
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                return SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(1.0, 0.0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                );
                              },
=======
>>>>>>> f099a548568129d8536f635149133ad46a1f80fe
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
<<<<<<< HEAD
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Continue to Seat Selection',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward_rounded, size: 20),
                          ],
=======
                          backgroundColor: Colors.purple,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Continue to Seat Selection',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
>>>>>>> f099a548568129d8536f635149133ad46a1f80fe
                        ),
                      ),
                    ),
                  ],
<<<<<<< HEAD
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
=======
                ],
              ),
            ),
          ],
        ),
>>>>>>> f099a548568129d8536f635149133ad46a1f80fe
      ),
    );
  }
}
<<<<<<< HEAD
=======

// import 'package:flutter/material.dart';
// import '../models/user.dart';
// import '../models/movie.dart';
// import 'seat_selection_screen.dart';

// class MovieDetailsScreen extends StatefulWidget {
//   final User user;
//   final Movie movie;

//   const MovieDetailsScreen({Key? key, required this.user, required this.movie})
//       : super(key: key);

//   @override
//   State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
// }

// class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
//   String? _selectedTimeSlot;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.movie.title),
//         backgroundColor: Colors.purple,
//         foregroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Poster Image بدل Emoji
//             Container(
//               height: 200,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: NetworkImage(widget.movie.posterUrl),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.movie.description,
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(height: 24),
//                   Text(
//                     'Select Time Slot',
//                     style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                           fontWeight: FontWeight.bold,
//                         ),
//                   ),
//                   const SizedBox(height: 16),
//                   Wrap(
//                     spacing: 12,
//                     runSpacing: 12,
//                     children: widget.movie.timeSlots.map((slot) {
//                       final isSelected = _selectedTimeSlot == slot;
//                       return InkWell(
//                         onTap: () {
//                           setState(() {
//                             _selectedTimeSlot = slot;
//                           });
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 20,
//                             vertical: 16,
//                           ),
//                           decoration: BoxDecoration(
//                             color: isSelected
//                                 ? Colors.purple.shade50
//                                 : Colors.white,
//                             border: Border.all(
//                               color: isSelected
//                                   ? Colors.purple
//                                   : Colors.grey.shade300,
//                               width: 2,
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(
//                                 Icons.access_time,
//                                 color: isSelected ? Colors.purple : Colors.grey,
//                               ),
//                               const SizedBox(width: 8),
//                               Text(
//                                 slot,
//                                 style: TextStyle(
//                                   color:
//                                       isSelected ? Colors.purple : Colors.black,
//                                   fontWeight: isSelected
//                                       ? FontWeight.bold
//                                       : FontWeight.normal,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                   if (_selectedTimeSlot != null) ...[
//                     const SizedBox(height: 24),
//                     SizedBox(
//                       width: double.infinity,
//                       height: 50,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => SeatSelectionScreen(
//                                 user: widget.user,
//                                 movie: widget.movie,
//                                 timeSlot: _selectedTimeSlot!,
//                               ),
//                             ),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.purple,
//                           foregroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         child: const Text(
//                           'Continue to Seat Selection',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
>>>>>>> f099a548568129d8536f635149133ad46a1f80fe
