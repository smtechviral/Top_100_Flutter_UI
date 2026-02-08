import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OverviewChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final String selectedPeriod;

  const OverviewChart({
    super.key,
    required this.data,
    required this.selectedPeriod,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildChart(isDark),
        ],
      ),
    );
  }

  Widget _buildChart(bool isDark) {
    final maxValue = data.map((e) => e['value'] as double).reduce(
          (a, b) => a > b ? a : b,
        );

    return SizedBox(
      height: 250,
      child: Column(
        children: [
          // Y-axis labels
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Y-axis values
                SizedBox(
                  width: 45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildYAxisLabel('\$100K', isDark),
                      _buildYAxisLabel('\$80K', isDark),
                      _buildYAxisLabel('\$60K', isDark),
                      _buildYAxisLabel('\$40K', isDark),
                      _buildYAxisLabel('\$20K', isDark),
                      const SizedBox(height: 0),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Chart bars
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: data.map((item) {
                          return _buildBar(
                            item['value'] as double,
                            maxValue,
                            constraints.maxHeight,
                            isDark,
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // X-axis labels
          Row(
            children: [
              const SizedBox(width: 57),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: data.map((item) {
                    return Text(
                      item['day'] as String,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[500],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildYAxisLabel(String label, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: Colors.grey[500],
        ),
      ),
    );
  }

  Widget _buildBar(double value, double maxValue, double maxHeight,
      bool isDark) {
    final heightPercentage = value / maxValue;
    final barHeight = maxHeight * heightPercentage;

    return Container(
      width: 28,
      height: barHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF5B7FFF),
            const Color(0xFF5B7FFF).withOpacity(0.7),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5B7FFF).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: const Color(0xFF5B7FFF).withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // 3D effect - left side darker
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
            ),
          ),
          // 3D effect - top highlight
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
