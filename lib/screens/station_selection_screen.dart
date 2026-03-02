import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../data/metro_data_provider.dart';
import '../models/station.dart';

class StationSelectionScreen extends StatefulWidget {
  final String title;
  const StationSelectionScreen({super.key, required this.title});

  @override
  State<StationSelectionScreen> createState() => _StationSelectionScreenState();
}

class _StationSelectionScreenState extends State<StationSelectionScreen> {
  final _searchController = TextEditingController();
  String _selectedLineFilter = 'all';
  List<Station> _filteredStations = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateStations();
    });
  }

  void _updateStations() {
    final provider = context.read<MetroDataProvider>();
    setState(() {
      var stations = provider.getUniqueStations();
      
      // Apply line filter
      if (_selectedLineFilter != 'all') {
        stations = provider.getStationsForLine(_selectedLineFilter);
      }

      // Apply search
      final query = _searchController.text.toLowerCase();
      if (query.isNotEmpty) {
        stations = stations.where((s) =>
          s.name.toLowerCase().contains(query) ||
          s.nameHindi.contains(query) ||
          s.lineName.toLowerCase().contains(query)
        ).toList();
      }

      _filteredStations = stations;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = context.read<MetroDataProvider>();
    final lines = dataProvider.lines;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => _updateStations(),
              style: const TextStyle(color: AppTheme.textPrimary),
              decoration: InputDecoration(
                hintText: 'Search station name...',
                prefixIcon: const Icon(Icons.search_rounded, color: AppTheme.textMuted),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded, color: AppTheme.textMuted),
                        onPressed: () {
                          _searchController.clear();
                          _updateStations();
                        },
                      )
                    : null,
              ),
            ),
          ),

          // Line filter chips
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildLineChip('all', 'All Lines', AppTheme.accent),
                const SizedBox(width: 8),
                ...lines.map((line) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: _buildLineChip(line.id, line.name, line.color),
                )),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Station count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Row(
              children: [
                Text(
                  '${_filteredStations.length} stations',
                  style: const TextStyle(color: AppTheme.textMuted, fontSize: 13),
                ),
              ],
            ),
          ),

          // Station list
          Expanded(
            child: _filteredStations.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search_off_rounded, color: AppTheme.textMuted, size: 48),
                        const SizedBox(height: 12),
                        const Text('No stations found', style: TextStyle(color: AppTheme.textMuted)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                    itemCount: _filteredStations.length,
                    itemBuilder: (context, index) {
                      final station = _filteredStations[index];
                      return _buildStationTile(station);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildLineChip(String lineId, String name, Color color) {
    final isSelected = _selectedLineFilter == lineId;
    return GestureDetector(
      onTap: () {
        setState(() => _selectedLineFilter = lineId);
        _updateStations();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.2) : AppTheme.surfaceDark,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? color : AppTheme.divider,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Text(
          name,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected ? color : AppTheme.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildStationTile(Station station) {
    final lineColor = AppTheme.getLineColor(station.lineColor);

    return GestureDetector(
      onTap: () => Navigator.pop(context, station),
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: AppTheme.surfaceDark,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppTheme.divider),
        ),
        child: Row(
          children: [
            // Line color indicator
            Container(
              width: 6,
              height: 40,
              decoration: BoxDecoration(
                color: lineColor,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    station.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: lineColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          station.lineName,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: lineColor,
                          ),
                        ),
                      ),
                      if (station.isInterchange) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppTheme.warning.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            '⇔ Interchange',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppTheme.warning),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            if (station.nameHindi.isNotEmpty)
              Text(
                station.nameHindi,
                style: const TextStyle(fontSize: 12, color: AppTheme.textMuted),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
