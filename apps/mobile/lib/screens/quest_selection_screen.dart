import 'package:flutter/material.dart';
import '../services/language_service.dart';
import '../services/api_service.dart';
import '../services/location_service.dart';
import '../api/fof/v1/fof.pb.dart';
import 'dart:math';

class QuestSelectionScreen extends StatefulWidget {
  final Function(Shop) onStartQuest;
  
  const QuestSelectionScreen({
    super.key,
    required this.onStartQuest,
  });

  @override
  State<QuestSelectionScreen> createState() => _QuestSelectionScreenState();
}

class _QuestSelectionScreenState extends State<QuestSelectionScreen> {
  String _selectedCategory = 'RAMEN';
  double _distance = 1000; // Meters
  final _keywordController = TextEditingController();

  final List<Map<String, dynamic>> _categories = [
    {'label': 'RAMEN', 'icon': Icons.ramen_dining, 'color': const Color(0xFFD32F2F)},
    {'label': 'CAFE', 'icon': Icons.local_cafe, 'color': const Color(0xFF388E3C)},
    {'label': 'SUSHI', 'icon': Icons.set_meal, 'color': const Color(0xFF1976D2)},
    {'label': 'BURGER', 'icon': Icons.lunch_dining, 'color': const Color(0xFFFFA000)},
    {'label': 'PUB', 'icon': Icons.local_bar, 'color': const Color(0xFF303F9F)},
    {'label': 'TACOS', 'icon': Icons.local_pizza, 'color': const Color(0xFFE64A19)},
  ];

  @override
  void dispose() {
    _keywordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false, // Prevent FAB moving up awkwardly, simple layout
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                S.of(context).questTitle,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.1,
                  height: 1.1,
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // 1. Horizontal Genre Scroll
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                S.of(context).questCraving,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 100,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected = _selectedCategory == cat['label'];
                  return _buildCategoryItem(
                    cat['label'] as String,
                    cat['icon'] as IconData,
                    cat['color'] as Color,
                    isSelected,
                  );
                },
              ),
            ),

            const SizedBox(height: 32),

            // 2. Distance Slider
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).questDistance,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  Text(
                    '${(_distance / 1000).toStringAsFixed(1)} km',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.black87,
                inactiveTrackColor: Colors.black12,
                thumbColor: Colors.black87,
                overlayColor: Colors.black.withValues(alpha: 0.1),
                trackHeight: 4.0,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
              ),
              child: Slider(
                value: _distance,
                min: 500,
                max: 5000,
                divisions: 9, // 500m steps (0.5, 1.0, 1.5 ... 5.0)
                onChanged: (val) => setState(() => _distance = val),
              ),
            ),

            const SizedBox(height: 24),

            // 3. Free Text Input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                S.of(context).questSpecific,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: TextField(
                  controller: _keywordController,
                  decoration: InputDecoration(
                    hintText: S.of(context).questHint,
                    hintStyle: const TextStyle(color: Colors.black38),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                  style: const TextStyle(color: Colors.black87, fontSize: 16),
                ),
              ),
            ),

            const Spacer(),

            // 4. Action Button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: _buildSurpriseButton(context),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String label, IconData icon, Color color, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 100, // Fixed width for consistent horizontal layout
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : color,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              S.of(context).translateCategory(label),
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSurpriseButton(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFF212121), // Dark button for contrast
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            final locationService = LocationService();
            final position = locationService.currentPosition;
            
            if (position == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(S.of(context).errorLocationUnavailable)),
              );
              return;
            }

            // Call API with quest parameters
            try {
              final apiService = ApiService();
              final result = await apiService.getNearbyShops(
                position.latitude,
                position.longitude,
                _distance,
              );
              
              // Filter by selected category (client-side for now)
              final filtered = result.shops
                  .where((shop) => shop.category.toLowerCase() == _selectedCategory.toLowerCase())
                  .where((shop) => !shop.isVisited) // Exclude visited shops
                  .toList();
              
              // Filter by keyword if provided
              final keyword = _keywordController.text.trim().toLowerCase();
              final finalShops = keyword.isEmpty
                  ? filtered
                  : filtered.where((shop) => shop.name.toLowerCase().contains(keyword)).toList();
              
              if (finalShops.isEmpty) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(S.of(context).errorNoShopsFound)),
                  );
                }
                return;
              }
              
              // Randomly select one shop
              final random = Random();
              final selectedShop = finalShops[random.nextInt(finalShops.length)];
              
              // Start the quest by calling the callback
              widget.onStartQuest(selectedShop);
              
            } catch (e) {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $e')),
                );
              }
            }
          },
          borderRadius: BorderRadius.circular(28),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.casino, color: Colors.white),
              const SizedBox(width: 12),
              Text(
                S.of(context).questButton,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
