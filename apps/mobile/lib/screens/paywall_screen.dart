import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:provider/provider.dart';
import '../services/purchase_service.dart';
import '../services/language_service.dart';
import '../theme/app_theme.dart';

class PaywallScreen extends StatefulWidget {
  final bool isGate;
  const PaywallScreen({super.key, this.isGate = false});

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();

  static Future<void> show(BuildContext context, {bool isGate = false}) async {
    final purchaseService = Provider.of<PurchaseService>(
      context,
      listen: false,
    );
    if (purchaseService.isPro) return;

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaywallScreen(isGate: isGate),
        fullscreenDialog: true,
      ),
    );
  }
}

class _PaywallScreenState extends State<PaywallScreen> {
  Package? _selectedPackage;
  bool _isPurchasing = false;

  @override
  Widget build(BuildContext context) {
    final purchaseService = Provider.of<PurchaseService>(context);
    final offerings = purchaseService.offerings;
    final currentOffering = offerings?.current;

    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Stack(
        children: [
          // Background Aesthetic
          _buildBackground(),

          Column(
            children: [
              SafeArea(bottom: false, child: _buildHeader(context)),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  children: [
                    _buildHeroSection(),
                    const SizedBox(height: 32),
                    _buildFeaturesList(),
                    const SizedBox(height: 32),
                    if (currentOffering != null)
                      _buildPricingOptions(currentOffering)
                    else
                      const Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
              _buildFooter(purchaseService),
            ],
          ),

          if (_isPurchasing)
            Container(
              color: Colors.black.withValues(alpha: 0.5),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryColor,
            AppTheme.primaryColor,
            Color(0xFF1A1A35),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -100,
            right: -100,
            child: _buildBlurCircle(
              AppTheme.accentColor.withValues(alpha: 0.1),
              300,
            ),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: _buildBlurCircle(
              const Color(0xFFFF8A8E).withValues(alpha: 0.1),
              250,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlurCircle(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!widget.isGate)
            IconButton(
              icon: const Icon(Icons.close_rounded, color: Colors.white70),
              onPressed: () => Navigator.pop(context),
            )
          else
            const SizedBox(width: 48),
          Text(
            S.of(context).paywallTitle,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 12,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(width: 48), // Spacer
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: const Icon(
            Icons.explore_rounded,
            size: 64,
            color: AppTheme.accentColor,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          S.of(context).paywallHeroTitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          S.of(context).paywallHeroSubtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.6),
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturesList() => const SizedBox.shrink();

  Widget _buildPricingOptions(Offering offering) {
    final packages = offering.availablePackages;

    // Sort to show Monthly last
    final sortedPackages = List<Package>.from(packages)
      ..sort((a, b) {
        if (a.packageType == PackageType.monthly) return 1;
        if (b.packageType == PackageType.monthly) return -1;
        return 0;
      });

    // Default selection to yearly or first available
    _selectedPackage ??= packages.firstWhere(
      (p) => p.packageType == PackageType.annual,
      orElse: () => packages.first,
    );

    return Column(
      children: sortedPackages.map((p) {
        final isSelected = _selectedPackage == p;
        final isMonthly = p.packageType == PackageType.monthly;
        final isAnnual = p.packageType == PackageType.annual;
        final isLifetime = p.packageType == PackageType.lifetime;

        return GestureDetector(
          onTap: () => setState(() => _selectedPackage = p),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: EdgeInsets.all(isMonthly ? 16 : 20),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.white.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(20),
              gradient: isSelected && !isMonthly
                  ? LinearGradient(
                      colors: [
                        Colors.white.withValues(alpha: 0.15),
                        Colors.white.withValues(alpha: 0.05),
                      ],
                    )
                  : null,
              border: Border.all(
                color: isSelected
                    ? AppTheme.accentColor
                    : Colors.white.withValues(alpha: 0.1),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            _getPackageTitle(p),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isMonthly ? 14 : 16,
                              fontWeight: isMonthly
                                  ? FontWeight.w500
                                  : FontWeight.bold,
                            ),
                          ),
                          if (isAnnual) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.accentColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                S.of(context).paywallPlanBestValue,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                          if (isLifetime) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                S.of(context).paywallPlanPromoted,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (!isMonthly) ...[
                        const SizedBox(height: 4),
                        Text(
                          isAnnual
                              ? S.of(context).paywallPlanAnnualDesc
                              : S.of(context).paywallPlanLifetimeDesc,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Text(
                  p.storeProduct.priceString,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMonthly ? 16 : 18,
                    fontWeight: isMonthly ? FontWeight.w700 : FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  String _getPackageTitle(Package package) {
    switch (package.packageType) {
      case PackageType.monthly:
        return S.of(context).paywallPlanMonthly;
      case PackageType.annual:
        return S.of(context).paywallPlanAnnual;
      case PackageType.lifetime:
        return S.of(context).paywallPlanLifetime;
      default:
        return S.of(context).paywallPlanDefault;
    }
  }

  Widget _buildFooter(PurchaseService purchaseService) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(
        24,
        16,
        24,
        (bottomPadding > 0 ? bottomPadding : 16),
      ),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: _selectedPackage == null
                ? null
                : () => _handlePurchase(purchaseService),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.accentColor,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 54),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: Text(
              S.of(context).paywallContinueButton,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: 4),
          TextButton(
            onPressed: () => purchaseService.restorePurchases(),
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(vertical: 8),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              S.of(context).paywallRestoreButton,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.4),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (widget.isGate) ...[
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                // Show confirmation or just sign out
                // Assuming UserService or Auth provider has sign out
                // For now, just navigate back to login?
                // Need to find Auth provider.
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil('/login', (route) => false);
              },
              child: Text(
                S.of(context).paywallSignOutButton,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.3),
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _handlePurchase(PurchaseService service) async {
    setState(() => _isPurchasing = true);
    try {
      final success = await service.purchasePackage(_selectedPackage!);
      if (success && mounted) {
        Navigator.pop(context);
      }
    } finally {
      if (mounted) setState(() => _isPurchasing = false);
    }
  }
}
