import 'package:flutter/material.dart';

class CustomChipTextField extends StatefulWidget {
  final List<String> initialTags;
  final TextEditingController textController;
  final ValueChanged<List<String>>? onChanged;
  final String? hintText;

  const CustomChipTextField({
    Key? key,
    this.initialTags = const [],
    required this.textController,
    this.onChanged,
    this.hintText,
  }) : super(key: key);

  @override
  State<CustomChipTextField> createState() => _ChipTextFieldState();
}

class _ChipTextFieldState extends State<CustomChipTextField> {
  late List<String> _tags;

  @override
  void initState() {
    super.initState();
    _tags = [...widget.initialTags];
  }

  void _addTag(String value) {
    final trimmed = value.trim();
    if (trimmed.isNotEmpty && !_tags.contains(trimmed)) {
      setState(() {
        _tags.add(trimmed);
      });
      widget.textController.clear();
      widget.onChanged?.call(_tags);
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
    widget.onChanged?.call(_tags);
  }

  void _clearAll() {
    setState(() {
      _tags.clear();
    });
    widget.textController.clear();
    widget.onChanged?.call(_tags);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 8,
                runSpacing: 4,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  ..._tags.map((tag) => Chip(
                    label: Text(tag),
                    deleteIcon: const Icon(Icons.close, size: 18),
                    onDeleted: () => _removeTag(tag),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  )),
                  ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
                    child: IntrinsicWidth(
                      child: TextField(
                        controller: widget.textController,
                        onSubmitted: _addTag,
                        decoration: InputDecoration(
                          hintText: _tags.isEmpty ? widget.hintText ?? 'Enter and press enter' : null,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_tags.isNotEmpty || widget.textController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: _clearAll,
              tooltip: "Clear all",
            ),
        ],
      ),
    );
  }
}
