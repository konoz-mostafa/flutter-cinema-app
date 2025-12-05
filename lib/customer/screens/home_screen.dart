// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import '../models/user.dart';
// import '../models/movie.dart';
// import '../services/app_state.dart';
// import 'movie_details_screen.dart';
// import 'login_screen.dart';

// class HomeScreen extends StatefulWidget {
//   final User user;

//   const HomeScreen({Key? key, required this.user}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   String _searchQuery = '';
//   List<Movie> _movies = [];
//   bool _loading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchMovies();
//   }

//   Future<void> _fetchMovies() async {
//     setState(() {
//       _loading = true;
//     });
//     final movies = await AppState.getMovies();
//     print('Fetched ${movies.length} movies'); // Debug
//     setState(() {
//       _movies = movies;
//       _loading = false;
//     });
//   }

//   List<Movie> get _filteredMovies {
//     if (_searchQuery.isEmpty) return _movies;
//     return _movies
//         .where(
//           (m) => m.title.toLowerCase().contains(_searchQuery.toLowerCase()),
//         )
//         .toList();
//   }

//   void _logout() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         title: const Text('Logout'),
//         content: const Text('Are you sure you want to logout?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancel', style: TextStyle(color: Colors.grey.shade600)),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               Navigator.pushReplacement(
//                 context,
//                 PageRouteBuilder(
//                   pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
//                   transitionsBuilder: (context, animation, secondaryAnimation, child) {
//                     return FadeTransition(opacity: animation, child: child);
//                   },
//                 ),
//               );
//             },
//             child: Text(
//               'Logout',
//               style: TextStyle(color: Colors.purple.shade700, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade200,
//       appBar: AppBar(
//         title: const Text("Customer App (Firebase)"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: _fetchMovies,
//             tooltip: 'Refresh',
//           ),
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: _logout,
//             tooltip: 'Logout',
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Search Bar
//           Container(
//             padding: const EdgeInsets.all(16),
//             color: Colors.white,
//             child: TextField(
//               onChanged: (value) {
//                 setState(() {
//                   _searchQuery = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 hintText: 'Search movies...',
//                 prefixIcon: const Icon(Icons.search),
//                 suffixIcon: _searchQuery.isNotEmpty
//                     ? IconButton(
//                         icon: const Icon(Icons.clear),
//                         onPressed: () {
//                           setState(() {
//                             _searchQuery = '';
//                           });
//                         },
//                       )
//                     : null,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey.shade100,
//               ),
//             ),
//           ),
//           // Movies List
//           Expanded(
//             child: _loading
//                 ? Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CircularProgressIndicator(
//                           valueColor: AlwaysStoppedAnimation<Color>(Colors.purple.shade600),
//                         ),
//                         const SizedBox(height: 16),
//                         Text(
//                           'Loading movies...',
//                           style: TextStyle(color: Colors.grey.shade600),
//                         ),
//                       ],
//                     ),
//                   )
//                 : _filteredMovies.isEmpty
//                     ? Center(
//                         child: Padding(
//                           padding: const EdgeInsets.all(40.0),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.all(24),
//                                 decoration: BoxDecoration(
//                                   color: Colors.purple.shade50,
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: Icon(
//                                   _searchQuery.isEmpty
//                                       ? Icons.movie_outlined
//                                       : Icons.search_off,
//                                   size: 64,
//                                   color: Colors.purple.shade300,
//                                 ),
//                               ),
//                               const SizedBox(height: 24),
//                               Text(
//                                 _searchQuery.isEmpty
//                                     ? 'No movies available'
//                                     : 'No movies found',
//                                 style: TextStyle(
//                                   fontSize: 22,
//                                   color: Colors.grey.shade800,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               Text(
//                                 _searchQuery.isEmpty
//                                     ? 'Check back later for new releases'
//                                     : 'Try a different search term',
//                                 style: TextStyle(
//                                   color: Colors.grey.shade600,
//                                   fontSize: 14,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                               if (_searchQuery.isEmpty) ...[
//                                 const SizedBox(height: 24),
//                                 ElevatedButton.icon(
//                                   onPressed: _fetchMovies,
//                                   icon: const Icon(Icons.refresh),
//                                   label: const Text('Refresh'),
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.purple.shade600,
//                                     foregroundColor: Colors.white,
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: 24,
//                                       vertical: 12,
//                                     ),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ],
//                           ),
//                         ),
//                       )
//                     : RefreshIndicator(
//                         onRefresh: () async {
//                           await _fetchMovies();
//                         },
//                         color: Colors.purple.shade600,
//                         child: ListView.builder(
//                           physics: const AlwaysScrollableScrollPhysics(),
//                           padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
//                           itemCount: _filteredMovies.length,
//                           itemBuilder: (context, index) {
//                             final movie = _filteredMovies[index];
//                             return _buildModernMovieCard(movie, index);
//                           },
//                         ),
//                       ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildModernMovieCard(Movie movie, int index) {
//     return Container(
//       margin: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => MovieDetailsScreen(user: widget.user, movie: movie),
//               ),
//             );
//           },
//           borderRadius: BorderRadius.circular(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Large Movie Poster
//               ClipRRect(
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   topRight: Radius.circular(20),
//                 ),
//                 child: movie.posterUrl.isNotEmpty
//                     ? CachedNetworkImage(
//                         imageUrl: movie.posterUrl,
//                         width: double.infinity,
//                         height: 250,
//                         fit: BoxFit.cover,
//                         placeholder: (context, url) => Container(
//                           width: double.infinity,
//                           height: 250,
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                               colors: [
//                                 Colors.indigo.shade400,
//                                 Colors.purple.shade400,
//                               ],
//                             ),
//                           ),
//                           child: const Center(
//                             child: CircularProgressIndicator(
//                               color: Colors.white,
//                               strokeWidth: 2,
//                             ),
//                           ),
//                         ),
//                         errorWidget: (context, url, error) => Container(
//                           width: double.infinity,
//                           height: 250,
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                               colors: [
//                                 Colors.indigo.shade400,
//                                 Colors.purple.shade400,
//                               ],
//                             ),
//                           ),
//                           child: const Icon(
//                             Icons.movie,
//                             color: Colors.white,
//                             size: 60,
//                           ),
//                         ),
//                       )
//                     : Container(
//                         width: double.infinity,
//                         height: 250,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                             colors: [
//                               Colors.indigo.shade400,
//                               Colors.purple.shade400,
//                             ],
//                           ),
//                         ),
//                         child: const Icon(
//                           Icons.movie,
//                           color: Colors.white,
//                           size: 60,
//                         ),
//                       ),
//               ),
//               // Movie Info
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       movie.title,
//                       style: const TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       movie.description,
//                       style: TextStyle(
//                         color: Colors.grey.shade600,
//                         fontSize: 14,
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 12),
//                     Row(
//                       children: [
//                         Icon(Icons.access_time, size: 16, color: Colors.grey.shade600),
//                         const SizedBox(width: 4),
//                         Text(
//                           '${movie.timeSlots.length} time slots',
//                           style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
//                         ),
//                         const SizedBox(width: 16),
//                         Icon(Icons.event_seat, size: 16, color: Colors.grey.shade600),
//                         const SizedBox(width: 4),
//                         Text(
//                           '${movie.totalSeats} seats',
//                           style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/user.dart';
import '../models/movie.dart';
import '../services/app_state.dart';
import 'movie_details_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';
  List<Movie> _movies = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    setState(() {
      _loading = true;
    });
    final movies = await AppState.getMovies();
    print('Fetched ${movies.length} movies'); // Debug
    setState(() {
      _movies = movies;
      _loading = false;
    });
  }

  List<Movie> get _filteredMovies {
    if (_searchQuery.isEmpty) return _movies;
    return _movies
        .where(
          (m) => m.title.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const LoginScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                ),
              );
            },
            child: Text(
              'Logout',
              style: TextStyle(
                color: Colors.purple.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF4A148C), // purple.shade800
                  // Color(0xFF1A237E), // indigo.shade900
                  Color(0xFF0D47A1), // blue.shade900
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          title: const Text(
            "Customer App",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              color: Colors.white,
              onPressed: _fetchMovies,
              tooltip: 'Refresh',
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              color: Colors.white,
              onPressed: _logout,
              tooltip: 'Logout',
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.transparent,
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search movies...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
            ),
          ),
          // Movies List
          Expanded(
            child: _loading
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.purple.shade600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Loading movies...',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  )
                : _filteredMovies.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.purple.shade50,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _searchQuery.isEmpty
                                  ? Icons.movie_outlined
                                  : Icons.search_off,
                              size: 64,
                              color: Colors.purple.shade300,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            _searchQuery.isEmpty
                                ? 'No movies available'
                                : 'No movies found',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _searchQuery.isEmpty
                                ? 'Check back later for new releases'
                                : 'Try a different search term',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          if (_searchQuery.isEmpty) ...[
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: _fetchMovies,
                              icon: const Icon(Icons.refresh),
                              label: const Text('Refresh'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple.shade600,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      await _fetchMovies();
                    },
                    color: Colors.purple.shade600,
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      itemCount: _filteredMovies.length,
                      itemBuilder: (context, index) {
                        final movie = _filteredMovies[index];
                        return _buildModernMovieCard(movie, index);
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernMovieCard(Movie movie, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MovieDetailsScreen(user: widget.user, movie: movie),
              ),
            );
          },
          borderRadius: BorderRadius.circular(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                child: movie.posterUrl.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: movie.posterUrl,
                        width: double.infinity,
                        height: 240,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          width: double.infinity,
                          height: 240,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.indigo.shade300,
                                Colors.purple.shade300,
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
                          width: double.infinity,
                          height: 240,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.indigo.shade300,
                                Colors.purple.shade300,
                              ],
                            ),
                          ),
                          child: const Icon(
                            Icons.movie,
                            color: Colors.white70,
                            size: 60,
                          ),
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        height: 240,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.indigo.shade300,
                              Colors.purple.shade300,
                            ],
                          ),
                        ),
                        child: const Icon(
                          Icons.movie,
                          color: Colors.white70,
                          size: 60,
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      movie.description,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: Colors.grey.shade500,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${movie.timeSlots.length} slots',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(
                          Icons.event_seat,
                          size: 16,
                          color: Colors.grey.shade500,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${movie.totalSeats} seats',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
