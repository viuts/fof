import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../api/fof/v1/ranking.pb.dart';
import '../theme/app_theme.dart';
import '../api/fof/v1/shop.pbenum.dart';
import '../constants/category_colors.dart';
import '../l10n/app_localizations.dart';
import '../services/language_service.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  final ApiService _apiService = ApiService();
  bool _isLoading = true;
  List<RankingEntry> _entries = [];
  String _selectedType = 'AREA'; // AREA, LEVEL, VISIT, CATEGORY
  FoodCategory _selectedCategory = FoodCategory.FOOD_CATEGORY_RAMEN;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadRanking();
  }

  Future<void> _loadRanking() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      GetRankingResponse response;
      switch (_selectedType) {
        case 'AREA': // Area Coverage
          response = await _apiService.getAreaCoverageRanking();
          break;
        case 'LEVEL': // Level
          response = await _apiService.getLevelRanking();
          break;
        case 'VISIT': // Visit Count
          response = await _apiService.getVisitCountRanking();
          break;
        case 'CATEGORY': // Category Visit
          response = await _apiService.getCategoryVisitRanking(
            _selectedCategory.name,
          );
          break;
        default:
          response = await _apiService.getAreaCoverageRanking();
      }
      setState(() {
        _entries = response.entries;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  void _onTypeChanged(String type) {
    if (_selectedType == type) return;
    setState(() {
      _selectedType = type;
    });
    _loadRanking();
  }

  void _onCategoryChanged(FoodCategory category) {
    if (_selectedCategory == category) return;
    setState(() {
      _selectedCategory = category;
    });
    if (_selectedType == 'CATEGORY') {
      _loadRanking();
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppTheme.lightBackground,
      body: Column(
        children: [
          _buildTypeSelector(s),
          if (_selectedType == 'CATEGORY') _buildCategorySelector(s),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _errorMessage.isNotEmpty
                ? Center(child: Text(s.errorLabel(_errorMessage)))
                : _buildRankingList(s),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeSelector(AppLocalizations s) {
    return Container(
      color: AppTheme.lightSurface,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _buildTypeChip('AREA', Icons.map, s.rankingTypeArea),
            const SizedBox(width: 8),
            _buildTypeChip('LEVEL', Icons.star, s.rankingTypeLevel),
            const SizedBox(width: 8),
            _buildTypeChip('VISIT', Icons.store, s.rankingTypeVisits),
            const SizedBox(width: 8),
            _buildTypeChip('CATEGORY', Icons.category, s.rankingTypeCategory),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeChip(String type, IconData icon, String label) {
    final isSelected = _selectedType == type;
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: isSelected ? Colors.white : AppTheme.textSecondaryLight,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : AppTheme.textSecondaryLight,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
      selected: isSelected,
      onSelected: (_) => _onTypeChanged(type),
      backgroundColor: AppTheme.lightSurfaceVariant,
      selectedColor: AppTheme.primaryColor,
      checkmarkColor: Colors.white,
      showCheckmark: false,
      side: isSelected
          ? const BorderSide(color: Colors.transparent)
          : BorderSide(color: Colors.grey.withOpacity(0.2)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }

  Widget _buildCategorySelector(AppLocalizations s) {
    final sHelper = S(s);
    final categories = ShopCategory.allCategories
        .where((c) => c != FoodCategory.FOOD_CATEGORY_UNSPECIFIED)
        .toList();

    return Container(
      height: 50,
      color: AppTheme.lightSurface,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = _selectedCategory == cat;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ActionChip(
              avatar: Icon(
                ShopCategory.getIcon(cat),
                size: 16,
                color: isSelected
                    ? AppTheme.primaryColor
                    : AppTheme.textSecondaryLight,
              ),
              label: Text(
                sHelper.translateCategory(cat),
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected
                      ? AppTheme.primaryColor
                      : AppTheme.textSecondaryLight,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              onPressed: () => _onCategoryChanged(cat),
              backgroundColor: isSelected
                  ? AppTheme.primaryColor.withOpacity(0.1)
                  : AppTheme.lightSurfaceVariant,
              side: BorderSide(
                color: isSelected ? AppTheme.primaryColor : Colors.transparent,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRankingList(AppLocalizations s) {
    if (_entries.isEmpty) {
      return Center(
        child: Text(s.noVisitsYet),
      ); // Use existing key or new "No data" key
    }

    return RefreshIndicator(
      onRefresh: _loadRanking,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _entries.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final entry = _entries[index];
          return _buildRankingItem(entry, index, s);
        },
      ),
    );
  }

  Widget _buildRankingItem(RankingEntry entry, int index, AppLocalizations s) {
    final isTop3 = entry.rank <= 3;
    Color? rankColor;
    if (entry.rank == 1)
      rankColor = AppTheme.tierGold;
    else if (entry.rank == 2)
      rankColor = AppTheme.tierSilver;
    else if (entry.rank == 3)
      rankColor = AppTheme.tierBronze;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.lightSurface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: entry.rank == 1
            ? Border.all(color: AppTheme.tierGold.withOpacity(0.5), width: 2)
            : null,
      ),
      child: Row(
        children: [
          // Rank Badge
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isTop3 ? rankColor?.withOpacity(0.1) : Colors.transparent,
            ),
            child: Text(
              '${entry.rank}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: isTop3 ? rankColor : AppTheme.textSecondaryLight,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Avatar
          CircleAvatar(
            radius: 24,
            backgroundImage: entry.profileImage.isNotEmpty
                ? NetworkImage(entry.profileImage)
                : null,
            backgroundColor: Colors.grey[200],
            child: entry.profileImage.isEmpty
                ? const Icon(Icons.person, color: Colors.grey)
                : null,
          ),
          const SizedBox(width: 12),

          // Name and Level
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.displayName.isNotEmpty
                      ? entry.displayName
                      : entry.username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppTheme.textPrimaryLight,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  s.levelLabel(entry.level),
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),

          // Score
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatScore(entry.score),
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: AppTheme.primaryColor,
                ),
              ),
              Text(
                _getScoreLabel(s),
                style: const TextStyle(
                  fontSize: 10,
                  color: AppTheme.textSecondaryLight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatScore(double score) {
    if (_selectedType == 'AREA') {
      if (score >= 1000000) {
        return '${(score / 1000000).toStringAsFixed(2)} km²';
      }
      return '${score.toStringAsFixed(0)} m²';
    } else if (_selectedType == 'LEVEL') {
      return '${score.toInt()}';
    } else {
      return '${score.toInt()}';
    }
  }

  String _getScoreLabel(AppLocalizations s) {
    switch (_selectedType) {
      case 'AREA':
        return s.rankingLabelClearedArea;
      case 'LEVEL':
        return s.rankingLabelLevel;
      case 'VISIT':
        return s.rankingLabelShopsVisited;
      case 'CATEGORY':
        return s.rankingLabelVisits;
      default:
        return s.rankingLabelPoints;
    }
  }
}
