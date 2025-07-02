import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_language_app/constant/themes.dart';

class SignDictionariesScreen extends StatefulWidget {
  const SignDictionariesScreen({Key? key}) : super(key: key);

  @override
  _SignDictionariesScreenState createState() => _SignDictionariesScreenState();
}

class _SignDictionariesScreenState extends State<SignDictionariesScreen>
    with SingleTickerProviderStateMixin {
  String _searchQuery = '';
  String? _selectedLanguage;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  final TextEditingController _searchController = TextEditingController();

  final Map<String, Map<String, String>> _dictionaryData = {
    'American Sign Language (ASL)': {
      'A': 'Open hand, fingers together, thumb to side',
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
    'British Sign Language (BSL)': {
      'A': 'Fist with thumb up',
      'B': 'Flat hand, fingers spread',
      'C': 'Hand forms C shape near chin',
      'D': 'Index finger points up near temple',
      'E': 'Two fingers near ear',
      'F': 'Index and middle finger touch forehead',
      'G': 'Fist near chin, thumb out',
      'H': 'Flat hands parallel near shoulders',
      'I': 'Index finger near eye',
      'J': 'Hand near chin, draws J',
      'K': 'Two fingers up, thumb on palm',
      'L': 'Hand forms L near cheek',
      'M': 'Three fingers on palm',
      'N': 'Two fingers on palm',
      'O': 'Circle near mouth',
      'P': 'Index finger near lips',
      'Q': 'Index and thumb form Q shape',
      'R': 'Two fingers near chin',
      'S': 'Fist near shoulder',
      'T': 'Index finger near throat',
      'U': 'Two fingers up near chin',
      'V': 'V shape near eyes',
      'W': 'Three fingers spread near face',
      'X': 'Index finger crosses mouth',
      'Y': 'Pinky and thumb out near chin',
      'Z': 'Two fingers draw Z near face',
    },
    'International Sign (IS)': {
      'A': 'Open hand, thumb to side',
      'B': 'Flat hand, fingers together',
      'C': 'Curved hand forming C',
      'D': 'Index finger up, others down',
      'E': 'All fingers slightly curled',
      'F': 'Index and thumb form circle',
      'G': 'Index points, thumb holds others',
      'H': 'Two fingers extended, horizontal',
      'I': 'Pinky up, near face',
      'J': 'Pinky draws J shape',
      'K': 'Two fingers up, thumb holds',
      'L': 'L shape near chest',
      'M': 'Three fingers over thumb',
      'N': 'Two fingers over thumb',
      'O': 'Fingers form O shape',
      'P': 'Index up, thumb to side',
      'Q': 'Index and thumb down',
      'R': 'Two fingers crossed',
      'S': 'Closed fist, thumb out',
      'T': 'Thumb under fingers',
      'U': 'Two fingers up, together',
      'V': 'Two fingers up, spread',
      'W': 'Three fingers spread',
      'X': 'Index finger hooked',
      'Y': 'Thumb and pinky out',
      'Z': 'Index draws Z in air',
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

  void _showSignDialog(String letter, String description, String language, BuildContext context) {
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
                  tag: 'sign-$language-$letter',
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: AppTheme.accent,
                    child: Text(
                      letter,
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
                  '$language - $letter',
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
        ? _dictionaryData
        : Map.fromEntries(_dictionaryData.entries.where((entry) =>
    entry.key.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        entry.value.keys.any((letter) =>
        letter.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            entry.value[letter]!.toLowerCase().contains(_searchQuery.toLowerCase()))));

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        elevation: 0,
        title: Text(
          'Sign Dictionaries',
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
                    hintText: 'Search signs or languages...',
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
                // Language Filter Chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 12,
                    children: _dictionaryData.keys.map((language) {
                      return ChoiceChip(
                        label: Text(
                          language,
                          style: GoogleFonts.poppins(
                            color: _selectedLanguage == language
                                ? Colors.white
                                : AppTheme.textDark,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        selected: _selectedLanguage == language,
                        selectedColor: AppTheme.primary,
                        backgroundColor: AppTheme.secondary.withOpacity(0.2),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        onSelected: (selected) {
                          setState(() {
                            _selectedLanguage = selected ? language : null;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                // Dictionary Sections
                Expanded(
                  child: ListView(
                    children: (_selectedLanguage == null
                        ? filteredData.keys
                        : [_selectedLanguage!])
                        .map((signLanguage) {
                      return _buildDictionarySection(signLanguage, context);
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

  Widget _buildDictionarySection(String title, BuildContext context) {
    final signs = _dictionaryData[title]!;
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
            tag: 'language-$title',
            child: CircleAvatar(
              backgroundColor: AppTheme.accent,
              radius: 28,
              child: Text(
                title[0],
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          title: Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              color: AppTheme.textDark,
              fontSize: 22,
            ),
          ),
          subtitle: Text(
            'A-Z Signs',
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
                children: signs.entries.map((entry) {
                  return _buildSignCard(entry.key, entry.value, title, context);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignCard(
      String letter, String description, String language, BuildContext context) {
    return GestureDetector(
      onTap: () => _showSignDialog(letter, description, language, context),
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
              tag: 'sign-$language-$letter',
              child: CircleAvatar(
                backgroundColor: AppTheme.primary,
                radius: 30,
                child: Text(
                  letter,
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
              letter,
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