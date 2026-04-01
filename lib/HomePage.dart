import 'package:flutter/material.dart';
import 'Cleaner_loginPage.dart';
import 'Supervisor_Login_Page.dart';
import 'Admin/admin_login_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const Color _purple = Color(0xFF440099);
  static const Color _lightPurple = Color(0xFFEDE0FF);
  static const Color _textPurple = Color(0xFF2a005e);
  static const Color _mutedPurple = Color(0xFF6a3aaa);
  static const Color _hintPurple = Color(0xFF9070bb);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // ── Purple header ─────────────────────────────────
          Container(
            width: double.infinity,
            color: _purple,
            padding: const EdgeInsets.only(
                top: 56, bottom: 28, left: 24, right: 24),
            child: Stack(
              children: [
                // Subtle geometric background circles
                Positioned(
                  right: -30,
                  top: -20,
                  child: Opacity(
                    opacity: 0.12,
                    child: Container(
                      width: 160,
                      height: 160,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: -40,
                  bottom: -30,
                  child: Opacity(
                    opacity: 0.08,
                    child: Container(
                      width: 130,
                      height: 130,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // Content
                Column(
                  children: [
                    // UoS Logo
                    // Image.asset(
                    //   'assets/images/Capture.png',
                    //   height: 70,
                    //   fit: BoxFit.contain,
                    // ),
                    const SizedBox(height: 12),
                    const Text(
                      'ESTATE FACILITIES MANAGEMENT',
                      style: TextStyle(
                        color: Color(0x99FFFFFF),
                        fontSize: 11,
                        letterSpacing: 2.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Cleaner illustration
                    Image.asset(
                      'assets/images/Capture.png',
                      height: 160,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ── Body ─────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome text
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: _textPurple,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Sign in to access your schedule and tasks',
                    style: TextStyle(
                      fontSize: 14,
                      color: _mutedPurple,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 50),


                  // Section label
                  const Text(
                    'CONTINUE AS',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: _hintPurple,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Supervisor button
                  _LoginButton(
                    label: 'Supervisor',
                    icon: Icons.supervisor_account_rounded,
                    filled: true,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => SupervisorLoginPage()),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Cleaner button
                  _LoginButton(
                    label: 'Cleaner',
                    icon: Icons.person_rounded,
                    filled: false,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CleanersLoginPage()),
                    ),
                  ),
                  const SizedBox(height: 50),

                  // Admin button
                  _LoginButton(
                    label: 'Admin Panel',
                    icon: Icons.admin_panel_settings_rounded,
                    filled: false,
                    isAdmin: true,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const AdminLoginScreen()),
                    ),
                  ),

                  const SizedBox(height: 32),
                  const Center(
                    child: Text(
                      '© University of Sheffield · Facilities & Estates',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFFB89ED8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool filled;
  final bool isAdmin;
  final VoidCallback onTap;

  const _LoginButton({
    required this.label,
    required this.icon,
    required this.filled,
    required this.onTap,
    this.isAdmin = false,
  });

  static const Color _purple = Color(0xFF440099);

  @override
  Widget build(BuildContext context) {
    final bgColor = filled
        ? _purple
        : isAdmin
        ? const Color(0xFFF5F0FF)
        : Colors.white;

    final fgColor = filled ? Colors.white : _purple;

    final borderColor = isAdmin
        ? const Color(0xFFD4C0F0)
        : _purple;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          side: filled
              ? BorderSide.none
              : BorderSide(color: borderColor, width: 1.5),
          padding: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 16),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14)),
          elevation: 0,
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: filled
                    ? Colors.white.withOpacity(0.15)
                    : const Color(0xFFEDE0FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon,
                  color: filled ? Colors.white : _purple,
                  size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: fgColor,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: filled
                  ? Colors.white.withOpacity(0.7)
                  : _purple,
            ),
          ],
        ),
      ),
    );
  }
}