import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_language_app/constant/themes.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with SingleTickerProviderStateMixin {
  String _searchQuery = '';
  String? _selectedLevel;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  final TextEditingController _searchController = TextEditingController();

  final Map<String, List<Map<String, dynamic>>> _quizData = {
    'Beginner Quiz': [
      {
        'question': 'What is the ASL letter for a closed fist with thumb to side?',
        'options': ['A', 'B', 'C', 'D'],
        'answer': 'A',
      },
      {
        'question': 'Which sign represents the number 1 in ASL?',
        'options': ['Index finger up', 'Fist closed', 'Two fingers up', 'Open hand'],
        'answer': 'Index finger up',
      },
      {
        'question': 'What is the ASL sign for the letter "L"?',
        'options': ['Thumb and index form L', 'Pinky up', 'Fist closed', 'Two fingers crossed'],
        'answer': 'Thumb and index form L',
      },
      {
        'question': 'How do you sign the number 5 in ASL?',
        'options': ['All fingers spread', 'Index up', 'Fist with thumb up', 'Two fingers up'],
        'answer': 'All fingers spread',
      },
    ],
    'Intermediate Quiz': [
      {
        'question': 'What is the ASL sign for "Mother"?',
        'options': ['Hand near chin, fingers spread', 'Hand near forehead', 'Two hands together', 'Pointing thumb'],
        'answer': 'Hand near chin, fingers spread',
      },
      {
        'question': 'How do you sign "Thank You" in ASL?',
        'options': ['Hand to mouth, then out', 'Wave hand', 'Clap hands', 'Point to chest'],
        'answer': 'Hand to mouth, then out',
      },
      {
        'question': 'What is the ASL sign for "Please"?',
        'options': ['Flat hand on chest, circular', 'Hand to mouth', 'Two fingers up', 'Fist near chin'],
        'answer': 'Flat hand on chest, circular',
      },
      {
        'question': 'How do you sign "Hello" in ASL?',
        'options': ['Wave hand near forehead', 'Point to chest', 'Two hands clasp', 'Thumb up'],
        'answer': 'Wave hand near forehead',
      },
    ],
    'Advanced Quiz': [
      {
        'question': 'What is the BSL sign for "School"?',
        'options': ['Two hands flat near shoulders', 'Hand near temple', 'Crossed arms', 'Pointing finger'],
        'answer': 'Two hands flat near shoulders',
      },
      {
        'question': 'How do you express "I love you" in IS?',
        'options': ['Handshape with ILY', 'Two hands crossed', 'Point to heart', 'Wave both hands'],
        'answer': 'Handshape with ILY',
      },
      {
        'question': 'What is the BSL sign for "Good Morning"?',
        'options': ['Hand near forehead, rise up', 'Hand near chin', 'Two fingers up', 'Wave hand'],
        'answer': 'Hand near forehead, rise up',
      },
      {
        'question': 'How do you sign "Help" in ASL?',
        'options': ['Fist under open hand, lift', 'Two hands together', 'Point to chest', 'Wave hand'],
        'answer': 'Fist under open hand, lift',
      },
    ],
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

  void _showQuizDialog(String level, Map<String, dynamic> question, BuildContext context) {
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
            tag: 'quiz-$level',
              child: CircleAvatar(
                radius: 60,
                backgroundColor: AppTheme.accent,
                child: Text(
                  level[0],
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
              '$level - Sample Question',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: AppTheme.textDark,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              question['question'],
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: AppTheme.textDark.withOpacity(0.8),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            Column(
              children: (question['options'] as List<String>).map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    option,
                    style: GoogleFonts.poppins(
                      color: option == question['answer']
                          ? AppTheme.primary
                          : AppTheme.textDark.withOpacity(0.7),
                      fontSize: 14,
                      fontWeight: option == question['answer'] ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                );
              }).toList(),
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
            )],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredData = _searchQuery.isEmpty
        ? _quizData
        : Map.fromEntries(_quizData.entries.where((entry) =>
    entry.key.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        entry.value.any((question) =>
        question['question'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
            (question['options'] as List<String>).any((option) =>
                option.toLowerCase().contains(_searchQuery.toLowerCase())))));

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        elevation: 0,
        title: Text(
          'Quiz Yourself',
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
                    hintText: 'Search quizzes or questions...',
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
                // Level Filter Chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 12,
                    children: _quizData.keys.map((level) {
                      return ChoiceChip(
                        label: Text(
                          level,
                          style: GoogleFonts.poppins(
                            color: _selectedLevel == level ? Colors.white : AppTheme.textDark,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        selected: _selectedLevel == level,
                        selectedColor: AppTheme.primary,
                        backgroundColor: AppTheme.secondary.withOpacity(0.2),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        onSelected: (selected) {
                          setState(() {
                            _selectedLevel = selected ? level : null;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                // Quiz Sections
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.8,
                    children: (_selectedLevel == null ? filteredData.keys : [_selectedLevel!])
                        .map((level) {
                      return _buildQuizCard(level, filteredData[level]![0], context);
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

  Widget _buildQuizCard(String level, Map<String, dynamic> question, BuildContext context) {
    return GestureDetector(
      onTap: () => _showQuizDialog(level, question, context),
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
              tag: 'quiz-$level',
              child: CircleAvatar(
                backgroundColor: AppTheme.primary,
                radius: 30,
                child: Text(
                  level[0],
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
              level,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: AppTheme.textDark,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text(
                question['question'],
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