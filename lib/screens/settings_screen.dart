import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        final user = userProvider.user;
        final isBM = user.language == 'bm';
        final theme = Theme.of(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              isBM ? 'Tetapan' : 'Settings',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // ── Profile Section ──────────────────────────────
              _SectionHeader(title: isBM ? 'Profil' : 'Profile'),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: theme.colorScheme.primaryContainer,
                    child: Text(
                      user.name.isEmpty ? 'C' : user.name[0].toUpperCase(),
                      style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(user.name.isEmpty ? 'Coder' : user.name),
                  subtitle: Text(isBM ? 'Ketik untuk tukar nama' : 'Tap to change name'),
                  trailing: const Icon(Icons.edit_outlined),
                  onTap: () => _showChangeNameDialog(context, isBM, userProvider),
                ),
              ),
              const SizedBox(height: 16),

              // ── Appearance ───────────────────────────────────
              _SectionHeader(title: isBM ? 'Paparan' : 'Appearance'),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                child: Column(
                  children: [
                    SwitchListTile(
                      secondary: const Icon(Icons.dark_mode_outlined),
                      title: Text(isBM ? 'Mod Gelap' : 'Dark Mode'),
                      subtitle: Text(
                          isBM ? 'Tukar tema aplikasi' : 'Toggle app theme'),
                      value: user.isDarkMode,
                      onChanged: (_) => userProvider.toggleDarkMode(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // ── Language ─────────────────────────────────────
              _SectionHeader(title: isBM ? 'Bahasa' : 'Language'),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                child: Column(
                  children: [
                    RadioListTile<String>(
                      title: const Text('🇲🇾  Bahasa Malaysia'),
                      subtitle: const Text('Soalan dalam BM'),
                      value: 'bm',
                      groupValue: user.language,
                      onChanged: (v) {
                        if (v != null) userProvider.setLanguage(v);
                      },
                    ),
                    const Divider(height: 1),
                    RadioListTile<String>(
                      title: const Text('🇬🇧  English'),
                      subtitle: const Text('Questions in English'),
                      value: 'en',
                      groupValue: user.language,
                      onChanged: (v) {
                        if (v != null) userProvider.setLanguage(v);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // ── Data ─────────────────────────────────────────
              _SectionHeader(title: isBM ? 'Data' : 'Data'),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                child: ListTile(
                  leading:
                      const Icon(Icons.refresh, color: Colors.red),
                  title: Text(
                    isBM ? 'Set Semula Kemajuan' : 'Reset Progress',
                    style: const TextStyle(color: Colors.red),
                  ),
                  subtitle: Text(
                    isBM
                        ? 'Padam semua XP, pelajaran & streak'
                        : 'Delete all XP, lessons & streak',
                  ),
                  onTap: () => _showResetDialog(context, isBM, userProvider),
                ),
              ),
              const SizedBox(height: 24),

              // ── About ─────────────────────────────────────────
              Center(
                child: Column(
                  children: [
                    Text(
                      'CODE30',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: theme.colorScheme.primary,
                        letterSpacing: 2,
                      ),
                    ),
                    Text(
                      'v1.0.0',
                      style: theme.textTheme.bodySmall?.copyWith(
                          color:
                              theme.colorScheme.onSurface.withOpacity(0.5)),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isBM
                          ? 'Belajar Coding. Setiap Hari.'
                          : 'Learn Coding. Every Day.',
                      style: theme.textTheme.bodySmall?.copyWith(
                          color:
                              theme.colorScheme.onSurface.withOpacity(0.5)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  void _showChangeNameDialog(
      BuildContext context, bool isBM, UserProvider userProvider) {
    final controller =
        TextEditingController(text: userProvider.name);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isBM ? 'Tukar Nama' : 'Change Name'),
        content: TextField(
          controller: controller,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            hintText: isBM ? 'Nama baharu' : 'New name',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(isBM ? 'Batal' : 'Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              userProvider.setName(controller.text);
              Navigator.pop(ctx);
            },
            child: Text(isBM ? 'Simpan' : 'Save'),
          ),
        ],
      ),
    );
  }

  void _showResetDialog(
      BuildContext context, bool isBM, UserProvider userProvider) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isBM ? '⚠️ Set Semula Kemajuan?' : '⚠️ Reset Progress?'),
        content: Text(
          isBM
              ? 'Ini akan memadam SEMUA XP, pelajaran selesai, streak, dan pencapaian anda. Tindakan ini tidak boleh dibatalkan!'
              : 'This will delete ALL your XP, completed lessons, streak, and achievements. This action cannot be undone!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(isBM ? 'Batal' : 'Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await userProvider.resetProgress();
              if (ctx.mounted) Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white),
            child: Text(isBM ? 'Set Semula' : 'Reset'),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
      ),
    );
  }
}
