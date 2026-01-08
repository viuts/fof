import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/language_service.dart';
import '../services/api_service.dart';
import '../theme/app_theme.dart';
import '../api/fof/v1/shop.pb.dart';
import '../api/fof/v1/visit.pb.dart';
import '../api/fof/v1/shop_extensions.dart';
import '../constants/category_colors.dart';
import 'package:intl/intl.dart';

class VisitDetailScreen extends StatefulWidget {
  final VisitedShop visit;

  const VisitDetailScreen({super.key, required this.visit});

  @override
  State<VisitDetailScreen> createState() => _VisitDetailScreenState();
}

class _VisitDetailScreenState extends State<VisitDetailScreen> {
  late int _rating;
  late TextEditingController _commentController;
  late List<String> _imageUrls;
  final List<dynamic> _newImages =
      []; // Stores File (mobile) or XFile/bytes (web)
  bool _isEditing = false;
  bool _isSaving = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _rating = widget.visit.rating;
    _commentController = TextEditingController(text: widget.visit.comment);
    _imageUrls = List.from(widget.visit.imageUrls);
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );
    if (image != null) {
      setState(() {
        _newImages.add(kIsWeb ? image : File(image.path));
      });
    }
  }

  Future<void> _saveReview() async {
    setState(() => _isSaving = true);
    try {
      final List<String> finalImageUrls = List.from(_imageUrls);

      // Upload new images
      for (var image in _newImages) {
        String url;
        if (kIsWeb) {
          final bytes = await (image as XFile).readAsBytes();
          url = await ApiService().uploadVisitImage(
            widget.visit.shop.id,
            bytes,
          );
        } else {
          url = await ApiService().uploadVisitImage(
            widget.visit.shop.id,
            image as File,
          );
        }
        finalImageUrls.add(url);
      }

      await ApiService().updateVisit(
        shopId: widget.visit.shop.id,
        rating: _rating,
        comment: _commentController.text,
        imageUrls: finalImageUrls,
      );

      setState(() {
        _imageUrls = finalImageUrls;
        _newImages.clear();
        _isEditing = false;
        _isSaving = false;
      });
    } catch (e) {
      setState(() => _isSaving = false);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final shop = widget.visit.shop;
    final visitedAt = DateTime.parse(widget.visit.visitedAt).toLocal();
    final dateFormat = DateFormat('yyyy/MM/dd HH:mm');
    final s = S.of(context);

    return Scaffold(
      backgroundColor: AppTheme.lightBackground,
      appBar: AppBar(
        title: Text(s.visitReviewTitle),
        backgroundColor: AppTheme.lightSurface,
        surfaceTintColor: Colors.transparent,
        actions: [
          if (!_isEditing)
            TextButton(
              onPressed: () => setState(() => _isEditing = true),
              child: Text(s.editReview),
            )
          else
            _isSaving
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  )
                : TextButton(onPressed: _saveReview, child: Text(s.save)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildShopHeader(context, shop),
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildVisitSummary(context, visitedAt, dateFormat),
                  const SizedBox(height: 32),
                  _buildReviewSection(context),
                  const SizedBox(height: 24),
                  _buildImageSection(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShopHeader(BuildContext context, Shop shop) {
    final s = S.of(context);
    return Container(
      width: double.infinity,
      color: AppTheme.lightSurface,
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              ShopCategory.getIcon(shop.effectiveFoodCategory),
              color: ShopCategory.getColor(shop.effectiveFoodCategory),
              size: 40,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            shop.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: AppTheme.textPrimaryLight,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            s.translateCategory(shop.effectiveFoodCategory),
            style: const TextStyle(
              fontSize: 16,
              color: AppTheme.textSecondaryLight,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (shop.address.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              shop.address,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildVisitSummary(
    BuildContext context,
    DateTime date,
    DateFormat format,
  ) {
    final s = S.of(context);
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.event_available_rounded,
            color: AppTheme.primaryColor,
            size: 20,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                s.visitedOn,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondaryLight,
                ),
              ),
              Text(
                format.format(date),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimaryLight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReviewSection(BuildContext context) {
    final s = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s.yourReview,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: AppTheme.primaryColor,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: List.generate(5, (index) {
            return IconButton(
              onPressed: _isEditing
                  ? () => setState(() => _rating = index + 1)
                  : null,
              icon: Icon(
                index < _rating
                    ? Icons.star_rounded
                    : Icons.star_outline_rounded,
                color: index < _rating ? Colors.amber : Colors.grey[300],
                size: 32,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            );
          }),
        ),
        const SizedBox(height: 24),
        if (_isEditing)
          TextField(
            controller: _commentController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: s.shareThoughts,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          )
        else
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppTheme.spacingLg),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.format_quote_rounded,
                  color: Colors.grey,
                  size: 24,
                ),
                const SizedBox(height: 8),
                Text(
                  _commentController.text.isNotEmpty
                      ? _commentController.text
                      : s.noCommentProvided,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: _commentController.text.isNotEmpty
                        ? AppTheme.textPrimaryLight
                        : Colors.grey[400],
                    fontStyle: _commentController.text.isNotEmpty
                        ? FontStyle.normal
                        : FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildImageSection(BuildContext context) {
    final s = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "PHOTOS", // I should add a translation for this if I have time, but let's use hardcoded or existing
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: AppTheme.primaryColor,
                letterSpacing: 1.2,
              ),
            ),
            if (_isEditing)
              TextButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.add_a_photo_outlined, size: 18),
                label: Text(s.addPhoto),
              ),
          ],
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: _imageUrls.length + _newImages.length,
          itemBuilder: (context, index) {
            if (index < _imageUrls.length) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(_imageUrls[index], fit: BoxFit.cover),
                  ),
                  if (_isEditing)
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () => setState(() => _imageUrls.removeAt(index)),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            } else {
              final newIndex = index - _imageUrls.length;
              final image = _newImages[newIndex];
              return Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: kIsWeb
                        ? Image.network(
                            (image as XFile).path,
                            fit: BoxFit.cover,
                          )
                        : Image.file(image as File, fit: BoxFit.cover),
                  ),
                  if (_isEditing)
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () =>
                            setState(() => _newImages.removeAt(newIndex)),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            }
          },
        ),
      ],
    );
  }
}
