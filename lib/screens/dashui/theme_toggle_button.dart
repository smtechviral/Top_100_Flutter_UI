import 'package:flutter/material.dart';

class ThemeToggleButton extends StatefulWidget {
  final VoidCallback onToggle;

  const ThemeToggleButton({super.key, required this.onToggle});

  @override
  State<ThemeToggleButton> createState() => _ThemeToggleButtonState();
}

class _ThemeToggleButtonState extends State<ThemeToggleButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isDark = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isDark = !_isDark;
      if (_isDark) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
    widget.onToggle();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildThemeButton(
            Icons.wb_sunny_outlined,
            !isDark,
            () {
              if (isDark) _toggle();
            },
            isDark,
          ),
          _buildThemeButton(
            Icons.nightlight_outlined,
            isDark,
            () {
              if (!isDark) _toggle();
            },
            isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildThemeButton(
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
    bool isDark,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? const Color(0xFF3A3A3A) : Colors.grey[100])
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 18,
          color: isSelected
              ? (isDark ? Colors.white : Colors.black)
              : Colors.grey[400],
        ),
      ),
    );
  }
}
