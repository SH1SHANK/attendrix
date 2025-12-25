// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

// Enhanced time-based greeting system with 4-hour intervals
class _PersonalizedGreetings {
  // Time periods divided into 4-hour segments for more precise personalization
  static const _timePeriods = {
    'early_morning': [4, 5, 6, 7], // 4 AM - 7:59 AM
    'morning': [8, 9, 10, 11], // 8 AM - 11:59 AM
    'midday': [12, 13, 14, 15], // 12 PM - 3:59 PM
    'afternoon': [16, 17, 18, 19], // 4 PM - 7:59 PM
    'evening': [20, 21, 22, 23], // 8 PM - 11:59 PM
    'night': [0, 1, 2, 3], // 12 AM - 3:59 AM
  };

  // Authentic, conversational primary greetings[1][2]
  static const _primaryGreetings = {
    'early_morning_sunny': [
      'Rise and shine, {name}! ☀️',
      'Good morning, {name}! What a beautiful start! 🌅',
      'Morning sunshine, {name}! 🌞',
      'Early bird {name}! Love the energy! ✨'
    ],
    'early_morning_cloudy': [
      'Good morning, {name}! Cozy vibes today! ☁️',
      'Morning {name}! Perfect weather for productivity! 🌥️',
      'Hey {name}! Gentle morning ahead! ☁️',
      'Morning, {name}! Soft skies, strong possibilities! 🌤️'
    ],
    'early_morning_rainy': [
      'Good morning, {name}! Fresh start with fresh rain! 🌧️',
      'Morning {name}! Cozy rainy day energy! ☔',
      'Hey {name}! Perfect morning for indoor victories! 🌦️',
      'Morning, {name}! Rain brings renewal! 🌧️'
    ],
    'early_morning_default': [
      'Good morning, {name}! Ready to seize the day! 🌟',
      'Morning {name}! Your day is full of potential! ✨',
      'Hey {name}! What an amazing morning to be alive! 💫',
      'Morning, {name}! Today feels special already! 🚀'
    ],
    'morning_sunny': [
      'Good morning, {name}! The sun is shining just for you! ☀️',
      'Morning {name}! Perfect weather for perfect plans! 🌞',
      'Hey {name}! This sunshine matches your bright spirit! ✨',
      'Morning, {name}! Golden hour, golden opportunities! 🔆'
    ],
    'morning_cloudy': [
      'Good morning, {name}! Peaceful skies for focused work! ☁️',
      'Morning {name}! These clouds are creating your perfect bubble! 🌥️',
      'Hey {name}! Gentle morning for gentle progress! ☁️',
      'Morning, {name}! Soft light, sharp focus! 🌤️'
    ],
    'morning_rainy': [
      'Good morning, {name}! Rain sounds like applause for your day! 🌧️',
      'Morning {name}! Cozy weather for big achievements! ☔',
      'Hey {name}! Fresh rain, fresh possibilities! 🌦️',
      'Morning, {name}! Let the rain wash yesterday away! 🌧️'
    ],
    'morning_default': [
      'Good morning, {name}! Ready to make today count! 🌟',
      'Morning {name}! Your potential is unlimited today! ✨',
      'Hey {name}! Something amazing is waiting for you! 💫',
      'Morning, {name}! Today is your canvas to paint! 🎨'
    ],
    'midday_sunny': [
      'Good afternoon, {name}! Hope your day is going smoothly! ☀️',
      'Afternoon {name}! This sunshine is energizing! 🌞',
      'Hey {name}! Perfect midday for a perfect person! ✨',
      'Afternoon, {name}! The sun is celebrating you! 🔆'
    ],
    'midday_cloudy': [
      'Good afternoon, {name}! Peaceful vibes for the rest of your day! ☁️',
      'Afternoon {name}! These clouds are keeping you comfortable! 🌥️',
      'Hey {name}! Gentle afternoon energy coming your way! ☁️',
      'Afternoon, {name}! Soft skies, strong momentum! 🌤️'
    ],
    'midday_rainy': [
      'Good afternoon, {name}! Rain is bringing fresh energy! 🌧️',
      'Afternoon {name}! Perfect weather for indoor focus! ☔',
      'Hey {name}! Let this rain refresh your spirit! 🌦️',
      'Afternoon, {name}! Rainy days make victories sweeter! 🌧️'
    ],
    'midday_default': [
      'Good afternoon, {name}! Hope your day is treating you well! 🌟',
      'Afternoon {name}! You\'re halfway to an amazing day! ✨',
      'Hey {name}! The day is still full of possibilities! 💫',
      'Afternoon, {name}! Keep that momentum going! 🚀'
    ],
    'afternoon_sunny': [
      'Good afternoon, {name}! This golden hour is yours! ☀️',
      'Afternoon {name}! Beautiful weather for beautiful plans! 🌞',
      'Hey {name}! The sun is setting the stage for your success! ✨',
      'Afternoon, {name}! Golden light, golden opportunities! 🔆'
    ],
    'afternoon_cloudy': [
      'Good afternoon, {name}! These clouds are creating magic! ☁️',
      'Afternoon {name}! Perfect atmosphere for reflection! 🌥️',
      'Hey {name}! Gentle afternoon vibes just for you! ☁️',
      'Afternoon, {name}! Soft skies, strong finish ahead! 🌤️'
    ],
    'afternoon_rainy': [
      'Good afternoon, {name}! Rain is washing away all worries! 🌧️',
      'Afternoon {name}! Cozy weather for cozy achievements! ☔',
      'Hey {name}! This rain is nature\'s way of refreshing you! 🌦️',
      'Afternoon, {name}! Let the rain inspire your creativity! 🌧️'
    ],
    'afternoon_default': [
      'Good afternoon, {name}! Time to make the rest of your day amazing! 🌟',
      'Afternoon {name}! You\'re doing great, keep going! ✨',
      'Hey {name}! The afternoon is full of promise! 💫',
      'Afternoon, {name}! Your best moments are still ahead! 🚀'
    ],
    'evening_sunny': [
      'Good evening, {name}! What a beautiful way to end the day! 🌅',
      'Evening {name}! This sunset is celebrating your day! 🌇',
      'Hey {name}! Golden hour matches your golden spirit! ✨',
      'Evening, {name}! Time to relax and reflect! 🌟'
    ],
    'evening_cloudy': [
      'Good evening, {name}! Peaceful skies for a peaceful evening! ☁️',
      'Evening {name}! These gentle clouds are wrapping up your day! 🌥️',
      'Hey {name}! Soft evening vibes coming your way! ☁️',
      'Evening, {name}! Time to unwind under these calm skies! 🌤️'
    ],
    'evening_rainy': [
      'Good evening, {name}! Rain sounds perfect for relaxation! 🌧️',
      'Evening {name}! Cozy weather for a cozy night in! ☔',
      'Hey {name}! Let this rain wash away the day\'s stress! 🌦️',
      'Evening, {name}! Perfect weather for reflection and rest! 🌧️'
    ],
    'evening_default': [
      'Good evening, {name}! Time to celebrate today\'s victories! 🌟',
      'Evening {name}! You\'ve earned this moment of peace! ✨',
      'Hey {name}! What a day it\'s been - time to unwind! 💫',
      'Evening, {name}! Reflect on today, dream about tomorrow! 🌙'
    ],
    'night_any': [
      'Good night, {name}! Hope you had an amazing day! 🌙',
      'Night {name}! Time to rest and recharge! ✨',
      'Hey {name}! Sweet dreams and peaceful sleep ahead! 💫',
      'Night, {name}! Tomorrow is going to be even better! 🌟',
      'Good night, {name}! You\'ve earned this rest! 😴',
      'Night {name}! Let your dreams be as wonderful as you are! 🌙'
    ]
  };

  // More natural, conversational secondary messages[1][5]
  static const _secondaryMessages = {
    'early_morning': [
      'You\'re up early - that\'s the spirit of a champion! 🏆',
      'Early mornings are when magic happens, and you\'re here for it! ✨',
      'Starting strong today, I can feel your determination! 💪',
      'The world is quiet, but your potential is loud and clear! 🚀'
    ],
    'morning': [
      'Your morning energy is contagious - keep spreading those good vibes! 😊',
      'Something tells me today is going to be absolutely incredible for you! 🌟',
      'You\'ve got that morning glow that says "I\'m ready for anything!" ✨',
      'The way you tackle mornings shows you\'re built for greatness! 💫'
    ],
    'midday': [
      'Midday check-in: you\'re doing amazing, keep that momentum going! 🔥',
      'The sun is at its peak, and so are you - what perfect timing! ☀️',
      'Halfway through the day and you\'re already winning! 🏆',
      'Your afternoon energy is exactly what the world needs right now! ✨'
    ],
    'afternoon': [
      'Afternoons are for reflection and action - you\'re mastering both! 🎯',
      'The golden hour is here, and you\'re absolutely glowing! ✨',
      'Your afternoon presence brings such positive energy to everything! 🌟',
      'This is your time to shine, and shine you absolutely do! 💫'
    ],
    'evening': [
      'Evenings are for gratitude, and I\'m grateful you\'re here! 🙏',
      'Time to unwind, but your impact on today will last forever! 🌅',
      'You\'ve made today better just by being you - that\'s powerful! ✨',
      'As the day winds down, your light continues to shine bright! 🌟'
    ],
    'night': [
      'Rest well - tomorrow is lucky to have you coming its way! 🌙',
      'Sweet dreams are made of days like the one you just lived! 💭',
      'Your day is done, but your story is just getting started! 📖',
      'Sleep tight knowing you made today count in every way! ✨'
    ]
  };

  static String _getTimePeriod(int hour) {
    for (final entry in _timePeriods.entries) {
      if (entry.value.contains(hour)) {
        return entry.key;
      }
    }
    return 'morning'; // fallback
  }

  static String getPrimary(String condition, int hour, String name) {
    final random = Random();
    final timePeriod = _getTimePeriod(hour);

    // Special handling for night period (no weather differentiation)
    if (timePeriod == 'night') {
      final templates = _primaryGreetings['night_any']!;
      return templates[random.nextInt(templates.length)]
          .replaceAll('{name}', name);
    }

    final key = '${timePeriod}_${condition}';
    final templates =
        _primaryGreetings[key] ?? _primaryGreetings['${timePeriod}_default']!;
    return templates[random.nextInt(templates.length)]
        .replaceAll('{name}', name);
  }

  static String getSecondary(int hour) {
    final random = Random();
    final timePeriod = _getTimePeriod(hour);
    final templates = _secondaryMessages[timePeriod]!;
    return templates[random.nextInt(templates.length)];
  }
}

// Weather condition mapping (same as before)
class _WeatherConditions {
  static const _conditions = {
    0: 'sunny',
    1: 'cloudy',
    2: 'cloudy',
    3: 'cloudy',
    45: 'cloudy',
    48: 'cloudy',
    51: 'rainy',
    53: 'rainy',
    55: 'rainy',
    61: 'rainy',
    63: 'rainy',
    65: 'rainy',
    71: 'rainy',
    73: 'rainy',
    75: 'rainy',
    80: 'rainy',
    81: 'rainy',
    82: 'rainy',
    95: 'stormy',
    96: 'stormy',
    99: 'stormy'
  };

  static String getCondition(int code) => _conditions[code] ?? 'default';
}

// Singleton HTTP client for connection reuse
final _httpClient = http.Client();

// Weather API URL for Karimnagar, Telangana, India
const _weatherApiUrl =
    'https://api.open-meteo.com/v1/forecast?latitude=18.4386&longitude=79.1288&current_weather=true';

Future<UserGreetingMessageStruct> generateGreetingMessage(
  String userName,
  bool includeWeather,
) async {
  // Input validation with fast fallback
  final name = userName.trim();
  if (name.isEmpty) {
    return _createFallbackGreeting('there');
  }

  try {
    String weatherCondition = 'default';

    // Fetch weather data with aggressive timeout if requested
    if (includeWeather) {
      weatherCondition = await _fetchWeatherCondition().timeout(
          const Duration(milliseconds: 1000),
          onTimeout: () => 'default');
    }

    // Generate messages using enhanced time-based templates
    final hour = DateTime.now().hour;
    final primaryMessage =
        _PersonalizedGreetings.getPrimary(weatherCondition, hour, name);
    final secondaryMessage = _PersonalizedGreetings.getSecondary(hour);

    return UserGreetingMessageStruct(
      primaryMessage: primaryMessage,
      secondaryMessage: secondaryMessage,
    );
  } catch (e) {
    // Fast fallback on any error
    return _createFallbackGreeting(name);
  }
}

/// Fetches weather condition from API (optimized for speed)
Future<String> _fetchWeatherCondition() async {
  try {
    final response = await _httpClient
        .get(Uri.parse(_weatherApiUrl))
        .timeout(const Duration(milliseconds: 1000));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final weatherCode = data['current_weather']?['weathercode'] as int?;

      if (weatherCode != null) {
        return _WeatherConditions.getCondition(weatherCode);
      }
    }
  } catch (e) {
    // Silently handle errors and return default
  }

  return 'default';
}

/// Creates fallback greeting when all else fails
UserGreetingMessageStruct _createFallbackGreeting(String name) {
  final random = Random();
  final hour = DateTime.now().hour;

  // Time-aware fallback greetings
  final fallbackPrimary = {
    'early_morning': ['Good morning, $name! 🌅', 'Rise and shine, $name! ☀️'],
    'morning': ['Good morning, $name! ✨', 'Morning sunshine, $name! 🌞'],
    'midday': [
      'Good afternoon, $name! 🌟',
      'Hey $name! Hope your day is great! ✨'
    ],
    'afternoon': ['Good afternoon, $name! 🌅', 'Afternoon, $name! ✨'],
    'evening': ['Good evening, $name! 🌙', 'Evening, $name! Time to unwind! ✨'],
    'night': ['Good night, $name! 🌙', 'Night, $name! Sweet dreams! ✨']
  };

  final fallbackSecondary = [
    'Ready to make today absolutely amazing! 🚀',
    'Your potential is unlimited - unlock it today! ⚡',
    'Amazing opportunities are waiting for you! ✨',
    'You\'re going to do incredible things today! 🌟'
  ];

  final timePeriod = _PersonalizedGreetings._getTimePeriod(hour);
  final primaryOptions =
      fallbackPrimary[timePeriod] ?? fallbackPrimary['morning']!;

  return UserGreetingMessageStruct(
    primaryMessage: primaryOptions[random.nextInt(primaryOptions.length)],
    secondaryMessage:
        fallbackSecondary[random.nextInt(fallbackSecondary.length)],
  );
}
