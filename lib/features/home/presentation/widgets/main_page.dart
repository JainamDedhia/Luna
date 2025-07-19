/// 🏠 **MAIN HOME PAGE**
/// 
/// 🎯 **Purpose**: Main dashboard with location, weather remedies, and Luna branding
/// 🏗️ **Architecture**: Home Feature - Presentation Layer
/// 🔗 **Dependencies**: Location services, weather API, remedy provider
/// 📝 **Usage**: Primary home screen content within HomeShell
/// 
/// 📅 **Created**: 2025
/// 👤 **Team**: Luna Development Team

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

// 🔄 Shared Components
import '../../../../shared/providers/providers.dart';
import '../../../../shared/widgets/widgets.dart';

// 🌍 Localization
import '../../../../l10n/app_localizations.dart';

/// 🏠 **Main Page Widget**
/// 
/// Features:
/// - 📍 Location display with refresh
/// - 🌤️ Weather-based remedy suggestions
/// - 🌙 Animated Luna logo and branding
/// - 🎨 Beautiful animations and transitions
/// 
/// **Components**:
/// - LocationBar: Shows current location with refresh
/// - AnimatedLogo: Luna branding with animations
/// - RemedyCard: Weather-based health suggestions
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 📍 **Location Bar**
            const LocationBar(),
            const SizedBox(height: 40),
            
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  
                  // 🌙 **Luna Logo with Animations**
                  const _AnimatedLogo(),
                  const SizedBox(height: 16),
                  
                  // 📝 **Animated Subtitle**
                  const _AnimatedSubtitle(),
                  const SizedBox(height: 20),
                  
                  // 💊 **Health Remedy Display**
                  Consumer<RemedyProvider>(
                    builder: (context, remedyProvider, child) {
                      if (remedyProvider.remedy.isNotEmpty) {
                        return AnimatedCard(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.lightbulb_outline,
                                color: themeProvider.primaryColor,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  remedyProvider.remedy,
                                  style: TextStyle(
                                    color: themeProvider.primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    height: 1.4,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 🌙 **Animated Luna Logo**
/// 
/// Beautiful animated logo with pulsing and rotation effects
class _AnimatedLogo extends StatefulWidget {
  const _AnimatedLogo();

  @override
  State<_AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<_AnimatedLogo>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    
    // 💓 **Pulse Animation Controller**
    _pulseController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    
    // 🔄 **Rotation Animation Controller**
    _rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    // 🎨 **Animation Definitions**
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return AnimatedBuilder(
      animation: Listenable.merge([_pulseAnimation, _rotationAnimation]),
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              // 🌙 **Luna Text with Gradient**
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    themeProvider.primaryColor,
                    themeProvider.primaryColor.withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: const Text(
                  'Luna',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 3,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              const SizedBox(height: 12),
              
              // 🎨 **Animated Glow Circle with Logo**
              Transform.rotate(
                angle: _rotationAnimation.value * 2 * pi,
                child: Container(
                  width: 240,
                  height: 240,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        themeProvider.primaryColor.withOpacity(0.3 * _pulseAnimation.value),
                        themeProvider.primaryColor.withOpacity(0.1 * _pulseAnimation.value),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: themeProvider.primaryColor,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: themeProvider.primaryColor.withOpacity(0.5),
                            blurRadius: 20 * _pulseAnimation.value,
                            spreadRadius: 5 * _pulseAnimation.value,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/Luna.png',
                          height: 100,
                          width: 100,
                          color: themeProvider.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// 📝 **Animated Subtitle**
/// 
/// Typewriter effect subtitle text
class _AnimatedSubtitle extends StatelessWidget {
  const _AnimatedSubtitle();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return TypingTextAnimation(
      text: 'Feeling Unwell or Just Curious',
      style: TextStyle(
        fontSize: 16,
        color: themeProvider.secondaryTextColor,
        fontStyle: FontStyle.italic,
      ),
      duration: const Duration(milliseconds: 100),
    );
  }
}

/// 📍 **Location Bar Widget**
/// 
/// Displays current location with refresh functionality and weather-based remedies
class LocationBar extends StatefulWidget {
  const LocationBar({super.key});

  @override
  State<LocationBar> createState() => _LocationBarState();
}

class _LocationBarState extends State<LocationBar> {
  // 📍 **State Variables**
  String _locationText = '';
  bool _isLoading = false;

  // 💊 **Weather-Based Remedy Database**
  final Map<String, List<String>> _remedyMap = {
    'clear': [
      "Drink coconut water to stay cool.",
      "Apply aloe vera gel to soothe sun-exposed skin.",
      "Use rose water as a toner to refresh your face.",
      "Consume cucumber or watermelon slices to stay hydrated.",
      "Wear cotton clothes to allow skin to breathe.",
    ],
    'clouds': [
      "Do light yoga or stretching indoors.",
      "Drink warm ginger tea to uplift mood.",
      "Eat soups with turmeric and garlic.",
      "Practice pranayama to reduce lethargy.",
      "Take light meals to improve digestion.",
    ],
    'rain': [
      "Drink tulsi-ginger tea to prevent cold.",
      "Avoid raw foods to prevent indigestion.",
      "Use clove oil if you feel cold symptoms.",
      "Keep feet dry and warm to avoid infection.",
      "Drink ajwain (carom seed) water after meals.",
    ],
    'default': [
      "Drink warm water with lemon every morning.",
      "Avoid processed sugar & fried food.",
      "Do daily abhyanga with sesame oil.",
      "Use triphala powder before bed.",
      "Practice deep breathing daily.",
    ],
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final l10n = AppLocalizations.of(context)!;
      setState(() => _locationText = l10n.locationFetching);
      _refreshLocation();
    });
  }

  /// 📍 **Refresh Location**
  /// 
  /// Get current location and fetch weather-based remedy
  Future<void> _refreshLocation() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      _isLoading = true;
    });

    // 🔐 **Check Location Permissions**
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      setState(() {
        _locationText = l10n.locationDenied;
        _isLoading = false;
      });
      return;
    }

    try {
      // 📍 **Get Current Position**
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
      );
      
      // 🏠 **Get Address from Coordinates**
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      String? address;
      String? city;
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        city = placemark.locality;
        address = [
          if (placemark.street?.isNotEmpty ?? false) placemark.street,
          if (placemark.subLocality?.isNotEmpty ?? false) placemark.subLocality,
          if (placemark.locality?.isNotEmpty ?? false) placemark.locality,
          if (placemark.administrativeArea?.isNotEmpty ?? false) placemark.administrativeArea,
          if (placemark.postalCode?.isNotEmpty ?? false) placemark.postalCode,
        ].where((s) => s != null && s!.trim().isNotEmpty).join(', ');
      }

      setState(() {
        _locationText = address?.isNotEmpty == true
            ? address!
            : 'Lat: ${position.latitude.toStringAsFixed(6)}, Lon: ${position.longitude.toStringAsFixed(6)}';
      });

      // 🌤️ **Fetch Weather-Based Remedy**
      if (city != null) {
        await _fetchWeatherRemedy(city);
      }
    } catch (_) {
      setState(() => _locationText = l10n.locationUnavailable);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  /// 🌤️ **Fetch Weather-Based Remedy**
  /// 
  /// Get weather condition and set appropriate Ayurvedic remedy
  Future<void> _fetchWeatherRemedy(String city) async {
    const apiKey = '2da60aa52aed4523dbca6d31deb340c9';
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

    try {
      final client = HttpClient();
      final request = await client.getUrl(Uri.parse(url));
      final response = await request.close();

      if (response.statusCode == 200) {
        final responseBody = await response.transform(utf8.decoder).join();
        final data = jsonDecode(responseBody);
        final condition = data['weather'][0]['main'].toString().toLowerCase();

        // 💊 **Get Remedy Based on Weather**
        final remedies = _remedyMap[condition] ?? _remedyMap['default']!;
        remedies.shuffle(); // Random remedy each time
        
        // 🔄 **Update Remedy Provider**
        Provider.of<RemedyProvider>(context, listen: false)
            .setRemedy(remedies.first);
      }
    } catch (e) {
      // 🔄 **Set Default Remedy on Error**
      final defaultRemedies = _remedyMap['default']!;
      defaultRemedies.shuffle();
      Provider.of<RemedyProvider>(context, listen: false)
          .setRemedy(defaultRemedies.first);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return Column(
      children: [
        AnimatedCard(
          padding: const EdgeInsets.only(right: 4),
          child: Row(
            children: [
              // 🔄 **Refresh Button**
              IconButton(
                onPressed: _isLoading ? null : _refreshLocation,
                icon: _isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFF9AFF00),
                          ),
                        ),
                      )
                    : Icon(Icons.refresh, color: themeProvider.primaryColor),
              ),
              
              // 📍 **Location Text**
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(right: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _locationText,
                      style: TextStyle(
                        fontSize: 15, 
                        color: themeProvider.textColor
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}