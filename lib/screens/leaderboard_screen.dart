import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      final user = userProvider.user;
      final isBM = user.language == 'bm';
      final theme = Theme.of(context);

      // Mock leaderboard data — in a real app this would come from server
      final leaderboard = [
        {'name': 'Aisyah', 'xp': 1200},
        {'name': 'Rizal', 'xp': 980},
        {'name': 'You', 'xp': user.xp},
        {'name': 'Siti', 'xp': 450},
        {'name': 'Hasan', 'xp': 320},
      ];

      return Scaffold(
        appBar: AppBar(
          title: Text(isBM ? 'Papan Kedudukan' : 'Leaderboard'),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: leaderboard.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, i) {
            final item = leaderboard[i];
            final rank = i + 1;
            final isUser = item['name'] == 'You';
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: isUser ? theme.colorScheme.primary : null,
                child: Text('#$rank', style: const TextStyle(color: Colors.white)),
              ),
              title: Text(item['name'] as String),
              trailing: Text('${item['xp']} XP', style: const TextStyle(fontWeight: FontWeight.bold)),
              tileColor: isUser ? theme.colorScheme.primary.withOpacity(0.08) : null,
            );
          },
        ),
      );
    });
  }
}
