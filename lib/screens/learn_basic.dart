import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_language_app/constant/themes.dart';

class LearnBasicsScreen extends StatefulWidget {
  const LearnBasicsScreen({Key? key}) : super(key: key);

  @override
  _LearnBasicsScreenState createState() => _LearnBasicsScreenState();
}

class _LearnBasicsScreenState extends State<LearnBasicsScreen> with SingleTickerProviderStateMixin {
  String _searchQuery = '';
  String? _selectedCategory;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  final TextEditingController _searchController = TextEditingController();

  final Map<String, Map<String, String>> _lessonData = {
    'Alphabet': {
      'A': 'Closed fist, thumb to side',
      'B': 'Flat hand, fingers together, thumb tucked',
      'C': 'Curved hand forming a C shape',
      'D': 'Index finger up, others folded',
      'E': 'Fingers crossed, thumb up',
      'F': 'Index and thumb form F, others folded',
      'G': 'Index and thumb extended, others folded',
      'H': 'Index and middle finger extended, parallel',
      'I': 'Pinky finger up, others folded',
      'J': 'Pinky finger up, curved motion',
      'K': 'Index and middle finger up, thumb between',
      'L': 'Thumb and index form L shape',
      'M': 'Three fingers over thumb',
      'N': 'Two fingers over thumb',
      'O': 'Fingers form circle with thumb',
      'P': 'Index and middle finger up, thumb on side',
      'Q': 'Index and thumb down, others folded',
      'R': 'Crossed index and middle fingers',
      'S': 'Fist with thumb over fingers',
      'T': 'Thumb under index finger',
      'U': 'Index and middle fingers up, together',
      'V': 'Index and middle fingers up, separated',
      'W': 'Three fingers up, spread',
      'X': 'Index finger hooked, others folded',
      'Y': 'Thumb and pinky extended',
      'Z': 'Index finger draws Z shape',
    },
    'Numbers': {
      '1': 'Index finger up, others folded',
      '2': 'Index and middle fingers up, separated',
      '3': 'Thumb holds pinky and ring, others up',
      '4': 'Four fingers up, thumb tucked',
      '5': 'All fingers spread, thumb out',
      '6': 'Thumb touches pinky, others up',
      '7': 'Thumb touches ring finger, others up',
      '8': 'Thumb touches middle finger, others up',
      '9': 'Thumb touches index, others folded',
      '10': 'Fist with thumb up, shake slightly',
    },
    'Common Phrases': {
      'Hello': 'Wave hand near forehead',
      'Thank You': 'Hand to mouth, then extend out',
      'Please': 'Flat hand on chest, circular motion',
      'Sorry': 'Fist near chin, fingers up',
      'I Love You': 'Index, pinky, and thumb extended',
      'Good': 'Thumb up, fingers folded',
      'Bad': 'Thumb down, fingers folded',
      'Help': 'Fist under open hand, lift up',
    },
    'Greetings': {
      'Hi': 'Wave hand near shoulder',
      'Good Morning': 'Hand near forehead, rise up',
      'Good Night': 'Hand near chin, lower down',
      'How Are You': 'Hands near chest, fingers wiggle',
      'Nice to Meet You': 'Hands clasp, then point to person',
      'Goodbye': 'Wave hand, palm open',
    },
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _showLessonDialog(String item, String description, String category, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppTheme.background,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Hero(
                  tag: 'lesson-$category-$item',
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: AppTheme.accent,
                    child: Text(
                      item[0],
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 48,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '$category - $item',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textDark,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: AppTheme.textDark.withOpacity(0.8),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    'Close',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredData = _searchQuery.isEmpty
        ? _lessonData
        : Map.fromEntries(_lessonData.entries.where((entry) =>
    entry.key.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        entry.value.keys.any((item) =>
        item.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            entry.value[item]!.toLowerCase().contains(_searchQuery.toLowerCase()))));

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        elevation: 0,
        title: Text(
          'Learn Basics',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
          tooltip: 'Back',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.accent,
        onPressed: () {
          FocusScope.of(context).requestFocus(FocusNode());
          _searchController.clear();
          setState(() {
            _searchQuery = '';
          });
        },
        child: const Icon(Icons.search, color: Colors.white),
        tooltip: 'Clear Search',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar
                TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search lessons or items...',
                    hintStyle: GoogleFonts.poppins(
                      color: AppTheme.textDark.withOpacity(0.6),
                    ),
                    prefixIcon: Icon(Icons.search, color: AppTheme.textDark),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                      icon: Icon(Icons.clear, color: AppTheme.textDark),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchQuery = '';
                        });
                      },
                    )
                        : null,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: AppTheme.accent, width: 3),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  ),
                  style: GoogleFonts.poppins(
                    color: AppTheme.textDark,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                // Category Filter Chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 12,
                    children: _lessonData.keys.map((category) {
                      return ChoiceChip(
                        label: Text(
                          category,
                          style: GoogleFonts.poppins(
                            color: _selectedCategory == category ? Colors.white : AppTheme.textDark,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        selected: _selectedCategory == category,
                        selectedColor: AppTheme.primary,
                        backgroundColor: AppTheme.secondary.withOpacity(0.2),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        onSelected: (selected) {
                          setState(() {
                            _selectedCategory = selected ? category : null;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                // Lesson Sections
                Expanded(
                  child: ListView(
                    children: (_selectedCategory == null
                        ? filteredData.keys
                        : [_selectedCategory!])
                        .map((category) {
                      return _buildLessonSection(category, context);
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLessonSection(String category, BuildContext context) {
    final lessons = _lessonData[category]!;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.primary.withOpacity(0.05), AppTheme.secondary.withOpacity(0.05)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: ExpansionTile(
          leading: Hero(
            tag: 'category-$category',
            child: CircleAvatar(
              backgroundColor: AppTheme.accent,
              radius: 28,
              child: Text(
                category[0],
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          title: Text(
            category,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              color: AppTheme.textDark,
              fontSize: 22,
            ),
          ),
          subtitle: Text(
            'Learn ${category.toLowerCase()}',
            style: GoogleFonts.poppins(
              color: AppTheme.textDark.withOpacity(0.6),
              fontSize: 14,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.6,
                children: lessons.entries.map((entry) {
                  return _buildLessonCard(entry.key, entry.value, category, context);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLessonCard(String item, String description, String category, BuildContext context) {
    return GestureDetector(
      onTap: () => _showLessonDialog(item, description, category, context),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppTheme.textDark.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: AppTheme.primary.withOpacity(0.2)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'lesson-$category-$item',
              child: CircleAvatar(
                backgroundColor: AppTheme.primary,
                radius: 30,
                child: Text(
                  item[0],
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              item,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: AppTheme.textDark,
                fontSize: 18,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                description,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  color: AppTheme.textDark.withOpacity(0.7),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}