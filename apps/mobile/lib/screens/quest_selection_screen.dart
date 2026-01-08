import 'package:flutter/material.dart';
import '../services/language_service.dart';
import '../services/api_service.dart';
import '../services/location_service.dart';
import '../api/fof/v1/shop.pb.dart';
import '../constants/category_colors.dart';

class QuestSelectionScreen extends StatefulWidget {
  final Function(Shop) onStartQuest;

  const QuestSelectionScreen({super.key, required this.onStartQuest});

  @override
  State<QuestSelectionScreen> createState() => _QuestSelectionScreenState();
}

class _QuestSelectionScreenState extends State<QuestSelectionScreen> {
  FoodCategory _selectedCategory = FoodCategory.FOOD_CATEGORY_RAMEN;
  double _distance = 1000; // Meters
  final _keywordController = TextEditingController();
  QuestRatingFilter _selectedRating =
      QuestRatingFilter.QUEST_RATING_FILTER_UNSPECIFIED;
  bool _openNow = true;

  @override
  void dispose() {
    _keywordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset:
          false, // Prevent FAB moving up awkwardly, simple layout
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

            // 1. Horizontal Genre Selection
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
            const SizedBox(height: 16),
            SizedBox(
              height: 120,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                scrollDirection: Axis.horizontal,
                itemCount: FoodCategory.values.length - 1,
                itemBuilder: (context, index) {
                  final category = FoodCategory.values[index + 1];
                  final isSelected = _selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: SizedBox(
                      width: 90,
                      child: _buildCategoryItem(category, isSelected),
                    ),
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
                thumbShape: const RoundSliderThumbShape(
                  enabledThumbRadius: 10.0,
                ),
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

            // 3. Rating Filter
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).questRating,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildRatingChip(
                        QuestRatingFilter.QUEST_RATING_FILTER_EXCELLENT,
                        S.of(context).questRatingExcellent,
                      ),
                      _buildRatingChip(
                        QuestRatingFilter.QUEST_RATING_FILTER_AVERAGE,
                        S.of(context).questRatingAverage,
                      ),
                      _buildRatingChip(
                        QuestRatingFilter.QUEST_RATING_FILTER_MIXED,
                        S.of(context).questRatingMixed,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 4. Open Now Toggle
            SwitchListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              title: Text(
                S.of(context).questOpenNow,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              value: _openNow,
              activeColor: Colors.black,
              onChanged: (val) => setState(() => _openNow = val),
            ),

            const SizedBox(height: 24),

            // 5. Free Text Input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    S.of(context).questSpecific,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
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
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),

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

  Widget _buildCategoryItem(FoodCategory category, bool isSelected) {
    final color = ShopCategory.getColor(category);
    final icon = ShopCategory.getIcon(category);
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = category),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : Colors.grey[200]!,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? Colors.white : color, size: 28),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                S.of(context).translateCategory(category),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingChip(QuestRatingFilter filter, String label) {
    final isSelected = _selectedRating == filter;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          if (isSelected) {
            _selectedRating = QuestRatingFilter.QUEST_RATING_FILTER_UNSPECIFIED;
          } else {
            _selectedRating = filter;
          }
        });
      },
      selectedColor: Colors.black,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black87,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      side: isSelected ? null : BorderSide(color: Colors.grey[300]!),
    );
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 200, left: 16, right: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: const Color(0xFF333333),
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
              _showToast(S.of(context).errorLocationUnavailable);
              return;
            }

            // Calculate Open Time
            int? openAtTime;
            if (_openNow) {
              openAtTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
            }

            // Call API with quest parameters
            try {
              final apiService = ApiService();
              final response = await apiService.getQuestShop(
                lat: position.latitude,
                lng: position.longitude,
                radius: _distance,
                categories: [_selectedCategory.name],
                keyword: _keywordController.text.trim(),
                ratingFilter: _selectedRating,
                openAtTime: openAtTime,
                exclusiveIndependent: true,
              );

              if (response.hasShop()) {
                widget.onStartQuest(response.shop);
              } else {
                if (mounted) {
                  _showNoShopsDialog();
                }
              }
            } catch (e) {
              if (mounted) {
                if (e.toString().contains('404')) {
                  _showNoShopsDialog();
                } else {
                  _showToast(S.of(context).errorLabel(e.toString()));
                }
              }
            }
          },
          borderRadius: BorderRadius.circular(28),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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

  void _showNoShopsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('😢'), // Simple emoji title or localized "Sorry"
        content: Text(
          S.of(context).errorNoShopsFound,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              S.of(context).close,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
