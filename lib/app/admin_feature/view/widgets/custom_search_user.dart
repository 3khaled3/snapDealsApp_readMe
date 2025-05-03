import 'package:flutter/material.dart';

class SearchUserByIdWidget extends StatefulWidget {
  final Future<void> Function(String userId) onSearch;

  const SearchUserByIdWidget({super.key, required this.onSearch});

  @override
  State<SearchUserByIdWidget> createState() => _SearchUserByIdWidgetState();
}

class _SearchUserByIdWidgetState extends State<SearchUserByIdWidget> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleSearch() async {
    final userId = _controller.text.trim();
    if (userId.isEmpty) return;

    setState(() => _isLoading = true);
    await widget.onSearch(userId);
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            labelText: 'Enter User ID',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: _isLoading ? null : _handleSearch,
          icon: _isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.search),
          label: Text(_isLoading ? 'Searching...' : 'Search'),
        ),
      ],
    );
  }
}
