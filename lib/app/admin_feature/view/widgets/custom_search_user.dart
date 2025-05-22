import 'package:flutter/material.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';

class SearchUserByIdWidget extends StatefulWidget {
  final Future<void> Function(String userId) onSearch;
  final VoidCallback onClearSearch;

  const SearchUserByIdWidget({
    super.key,
    required this.onSearch,
    required this.onClearSearch,
  });

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

  void _handleClearSearch() {
    _controller.clear();
    widget.onClearSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText:context.tr.search_user_label ,
              border: const OutlineInputBorder(),
              suffixIcon: _controller.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: _handleClearSearch,
                    )
                  : null,
            ),
            onChanged: (_) => setState(() {}), // لتحديث زر المسح تلقائيًا
          ),
        ),
        12.pw,
        ElevatedButton.icon(
          onPressed: _isLoading ? null : _handleSearch,
          icon: _isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.search),
          label: Text(_isLoading ? context.tr.searching : context.tr.search),
        ),
      ],
    );
  }
}
