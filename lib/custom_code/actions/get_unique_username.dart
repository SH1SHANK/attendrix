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

import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> getUniqueUsername() async {
  /// MODIFY CODE ONLY BELOW THIS LINE

  final adjectives = [
    'vibing',
    'chaotic',
    'noob',
    'lazy',
    'based',
    'wired',
    'fomo',
    'drippy',
    'salty',
    'caffeinated',
    'lofi',
    'spooky',
    'hyper',
    'edgy',
    'yeeted',
    'offline',
    'skippy',
    'woke',
    'ghosted',
    'slay',
    'sussy',
    'lost',
    'sleepdeprived',
    'procrastinating',
    'mid',
    'cancelled',
    'lit',
    'mood',
    'quirky',
    'wild',
    'unstoppable',
    'chill',
    'freaky',
    'emo',
    'vibing',
    'shook',
    'grunge',
    'unstoppable',
    'clout',
    'majestic',
    'underrated',
    'wavy'
  ];

  final nouns = [
    'rizzler',
    'goblin',
    'taco',
    'zombie',
    'dude',
    'slacker',
    'nugget',
    'meme',
    'vortex',
    'chad',
    'boba',
    'waffle',
    'lecture',
    'wifi',
    'toaster',
    'senpai',
    'energy',
    'groupchat',
    'hoodie',
    'playlist',
    'notes',
    'vibe',
    'airdrop',
    'assignment',
    'beanbag',
    'timetable',
    'gizmo',
    'shadow',
    'wizard',
    'snitch',
    'dobby',
    'slytherin',
    'granger',
    'potterhead',
    'hermione',
    'hufflepuff',
    'ravenclaw',
    'marauder',
    'wand',
    'grimm',
    'stranger',
    'hopper',
    'demogorgon',
    'eleven',
    'lucas',
    'will',
    'nancy',
    'steve',
    'enola',
    'wednesday',
    'addams',
    'chucky',
    'freddy',
    'slasher',
    'voldemort',
    'lucifer',
    'spike',
    'hopper',
    'demogorgon',
    'starfire',
    'rick',
    'morty',
    'katniss',
    'mockingjay',
    'dumbledore',
    'mystic',
    'hawkins',
    'upside-down',
    'sherlock',
    'matrix',
    'avatar',
    'gollum',
    'ringbearer',
    'hobbit',
    'frodo',
    'naruto',
    'kage',
    'sasuke',
    'uchiha',
    'bender'
  ];

  final firestore = FirebaseFirestore.instance;

  for (int attempt = 0; attempt < 10; attempt++) {
    final now = DateTime.now().millisecondsSinceEpoch + attempt;
    final adjective = adjectives[now % adjectives.length];
    final noun = nouns[(now ~/ 1000) % nouns.length];
    final number = now % 1000;
    final candidate = '$adjective$noun$number';

    // Check Firestore for existing username
    final query = await firestore
        .collection('users')
        .where('username', isEqualTo: candidate)
        .limit(1)
        .get();

    if (query.docs.isEmpty) {
      return candidate;
    }
  }

  // Fallback if all 10 candidates exist
  final fallback = 'user${DateTime.now().millisecondsSinceEpoch % 10000}';
  return fallback;

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
