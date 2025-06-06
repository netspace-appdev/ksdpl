import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:ksdpl/common/helper.dart';

class ChipData {
  final String text;
  final bool isMandatory;

  ChipData({required this.text, this.isMandatory = false});

  ChipData copyWith({String? text, bool? isMandatory}) {
    return ChipData(
      text: text ?? this.text,
      isMandatory: isMandatory ?? this.isMandatory,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChipData && other.text == text && other.isMandatory == isMandatory;
  }

  @override
  int get hashCode => text.hashCode ^ isMandatory.hashCode;
}

class CustomOptionalChipTextField extends StatefulWidget {
  final List<ChipData> initialTags;
  final TextEditingController textController;
  final ValueChanged<List<ChipData>>? onChanged;
  final String? hintText;

  const CustomOptionalChipTextField({
    Key? key,
    this.initialTags = const [],
    required this.textController,
    this.onChanged,
    this.hintText,
  }) : super(key: key);

  @override
  State<CustomOptionalChipTextField> createState() => _CustomOptionalChipTextFieldState();
}

class _CustomOptionalChipTextFieldState extends State<CustomOptionalChipTextField> {
  late List<ChipData> _tags;

  @override
  void initState() {
    super.initState();
    _tags = [...widget.initialTags];
  }

  void _addTag(String value) {
    final trimmed = value.trim();
    if (trimmed.isNotEmpty && !_tags.any((tag) => tag.text == trimmed)) {
      setState(() {
        _tags.add(ChipData(text: trimmed, isMandatory: false));
      });
      widget.textController.clear();
      widget.onChanged?.call(_tags);
    }
  }

  void _removeTag(ChipData tag) {
    setState(() {
      _tags.remove(tag);
    });
    widget.onChanged?.call(_tags);
  }

  void _toggleMandatory(ChipData tag) {
    setState(() {
      final index = _tags.indexOf(tag);
      if (index != -1) {
        _tags[index] = tag.copyWith(isMandatory: !tag.isMandatory);
      }
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
        color: AppColor.appWhite,
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
                  ..._tags.map((tag) => _buildChip(tag)),
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

  Widget _buildChip(ChipData tag) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Checkbox
          Transform.scale(
            scale: 0.8,
            child: Checkbox(
              value: tag.isMandatory,
              onChanged: (bool? value) => _toggleMandatory(tag),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
          ),
          // Chip text and status
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tag.text,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 5,),
                  Text(
                    tag.isMandatory ? '(Mandatory)' : '(Optional)',
                    style: TextStyle(
                      fontSize: 12,
                      color: tag.isMandatory ? Colors.red : Colors.grey.shade600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Delete button
          GestureDetector(
            onTap: () => _removeTag(tag),
            child: Container(
              padding: const EdgeInsets.all(4),
              child: Icon(
                Icons.close,
                size: 16,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}

// Usage example:
class ExampleUsage extends StatefulWidget {
  @override
  _ExampleUsageState createState() => _ExampleUsageState();
}

class _ExampleUsageState extends State<ExampleUsage> {
  final TextEditingController _chipTextController = TextEditingController();
  List<ChipData> selectedTags = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Custom Optional Chip TextField')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomOptionalChipTextField(
              textController: _chipTextController,
              initialTags: selectedTags,
              hintText: 'Enter tags and press enter',
              onChanged: (tags) {
                print("Updated tags: $tags");
                setState(() {
                  selectedTags = tags;
                });
              },
            ),
            const SizedBox(height: 20),
            Text('Current Tags: ${selectedTags.length}'),
            ...selectedTags.map((tag) => ListTile(
              title: Text(tag.text),
              trailing: Text(tag.isMandatory ? 'Mandatory' : 'Optional'),
            )),
          ],
        ),
      ),
    );
  }
}
