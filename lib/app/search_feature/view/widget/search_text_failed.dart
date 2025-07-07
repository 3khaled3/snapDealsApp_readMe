import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';

/// A text field that debounces the search event.
///
/// The [onSearchChanged] callback is called with the search query after a
/// 1 second delay since the last search query change.
class DebouncedSearchTextField extends StatefulWidget {
  final void Function(String) onSearchChanged;

  /// Creates a debounced search text field.
  ///
  /// The [onSearchChanged] argument must not be null.
  const DebouncedSearchTextField({
    super.key,
    required this.onSearchChanged,
  });

  @override
  _DebouncedSearchTextFieldState createState() =>
      _DebouncedSearchTextFieldState();
}

///
/// This class debounces the search event and notifies the parent widget when
/// the user stops typing for a second.
class _DebouncedSearchTextFieldState extends State<DebouncedSearchTextField> {
  // The subject that receives the search query input.
  final _debounce = PublishSubject<String>();

  @override
  void initState() {
    super.initState();
    // Listens to the search query input stream and debounces it by waiting for
    // 1 second since the last input before notifying the parent widget.
    _debounce.stream
        .debounceTime(const Duration(milliseconds: 1000))
        .listen(widget.onSearchChanged);
  }

  @override
  void dispose() {
    // Closes the subject to release any resources.
    _debounce.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        // Adds the search query input to the subject.
        _debounce.add(value);
      },
      decoration: InputDecoration(
        hintText: context.tr.search,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
