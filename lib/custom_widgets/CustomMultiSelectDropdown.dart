import 'package:flutter/material.dart';

class MultiSelectDropdown<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T) getId;
  final String Function(T) getName;
  final String hintText;
  final List<T> selectedValues;
  final Function(List<T>) onChanged;
  final bool isEnabled;
  final VoidCallback? onClear;

  const MultiSelectDropdown({
    Key? key,
    required this.items,
    required this.getId,
    required this.getName,
    required this.selectedValues,
    required this.onChanged,
    this.hintText = "Select options",
    this.isEnabled = true,
    this.onClear,
  }) : super(key: key);

  @override
  _MultiSelectDropdownState<T> createState() => _MultiSelectDropdownState<T>();
}

class _MultiSelectDropdownState<T> extends State<MultiSelectDropdown<T>> {
  OverlayEntry? overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _fieldKey = GlobalKey();

  List<T> selectedItems = [];
  List<T> filteredItems = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedItems = widget.selectedValues;
    filteredItems = widget.items;
  }

  void _showOverlay() {
    _removeOverlay();
    final overlay = Overlay.of(context);
    final renderBox = _fieldKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final position = renderBox.localToGlobal(Offset.zero);

    overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _removeOverlay,
        child: Stack(
          children: [
            Positioned(
              width: size.width,
              left: position.dx,
              top: position.dy + size.height + 5,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0, size.height + 5),
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(8),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 250),
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: filteredItems.isEmpty
                          ? [ListTile(title: Text("No item found"))]
                          : filteredItems.map((item) {
                        final isChecked = selectedItems.contains(item);
                        return CheckboxListTile(
                          title: Text(widget.getName(item)),
                          value: isChecked,
                          onChanged: (bool? selected) {
                            setState(() {
                              if (selected == true) {
                                selectedItems.add(item);
                              } else {
                                selectedItems.remove(item);
                              }
                            });
                            widget.onChanged(selectedItems);
                            _showOverlay(); // refresh overlay
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    overlay?.insert(overlayEntry!);
  }

  void _removeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  void _clearSelection() {
    setState(() {
      selectedItems.clear();
    });
    widget.onChanged([]);
    widget.onClear?.call();
    _removeOverlay();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: widget.isEnabled ? _showOverlay : null,
        child: Container(
          key: _fieldKey,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
            color: widget.isEnabled ? Colors.white : Colors.grey.shade200,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (selectedItems.isEmpty)
                Text(
                  widget.hintText,
                  style: TextStyle(color: Colors.grey),
                ),
              if (selectedItems.isNotEmpty)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 6,
                    children: selectedItems.map((item) {
                      return InputChip(
                        label: Text(widget.getName(item)),
                        onDeleted: widget.isEnabled
                            ? () {
                          setState(() {
                            selectedItems.remove(item);
                          });
                          widget.onChanged(selectedItems);
                        }
                            : null,
                      );
                    }).toList(),
                  ),
                ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.arrow_drop_down),
                  onPressed: widget.isEnabled ? _showOverlay : null,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }
}
