import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:ksdpl/common/helper.dart';
///old


///new 3
/*import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<Map<String, String>> items;
  final String hintText;
  final String? selectedValue;
  final Function(String?) onChanged;
  final bool isEnabled;

  const CustomDropdown({
    Key? key,
    required this.items,
    required this.onChanged,
    this.hintText = "Select an option",
    this.selectedValue,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, String>> filteredItems = [];
  OverlayEntry? overlayEntry;
  final LayerLink _layerLink = LayerLink();
  String? selectedItem;

  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
    selectedItem = widget.selectedValue;

    if (selectedItem != null) {
      final selectedMap = widget.items.firstWhere(
            (item) => item["id"] == selectedItem,
        orElse: () => {"id": "", "name": ""},
      );
      searchController.text = selectedMap["name"]!;
    }
  }

  void filterSearchResults(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredItems = widget.items;
      } else {
        filteredItems = widget.items
            .where((item) => item["name"]!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });

    _showOverlay();
  }

  void selectItem(String? value) {
    setState(() {
      selectedItem = value;
      final selectedMap = widget.items.firstWhere(
            (item) => item["id"] == value,
        orElse: () => {"id": "", "name": ""},
      );
      searchController.text = selectedMap["name"]!;
    });

    widget.onChanged(value);
    _removeOverlay();
  }

  void clearSelection() {
    setState(() {
      selectedItem = null;
      searchController.clear();
      filteredItems = widget.items;
    });

    widget.onChanged(null);
    _removeOverlay();
  }

  void _showOverlay() {
    _removeOverlay();

    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final position = renderBox.localToGlobal(Offset.zero);

    overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          _removeOverlay();
        },
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
                    constraints: BoxConstraints(maxHeight: 200),
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: filteredItems.isEmpty
                          ? [ListTile(title: Text("No item found"))]
                          : filteredItems.map((item) {
                        return ListTile(
                          title: Text(item["name"]!),
                          onTap: () => selectItem(item["id"]),
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (overlayEntry != null) {
          _removeOverlay();
          return false;
        }
        return true;
      },
      child: GestureDetector(
        onTap: _removeOverlay,
        child: CompositedTransformTarget(
          link: _layerLink,
          child: TextFormField(
            style: TextStyle(color: widget.isEnabled ? Colors.black : Colors.grey),
            controller: searchController,
            readOnly: !widget.isEnabled,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (searchController.text.isNotEmpty)
                    widget.isEnabled
                        ? IconButton(
                      icon: Icon(Icons.close, color: Colors.grey, size: 20),
                      onPressed: clearSelection,
                    )
                        : Container(),
                  IconButton(
                    icon: Icon(Icons.arrow_drop_down),
                    onPressed: widget.isEnabled ? _showOverlay : null,
                  ),
                ],
              ),
            ),
            onChanged: filterSearchResults,
            onTap: widget.isEnabled ? _showOverlay : null,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    _removeOverlay();
    super.dispose();
  }
}*/

///New 4
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T) getId;
  final String Function(T) getName;
  final String hintText;
  final T? selectedValue;
  final Function(T?) onChanged;
  final bool isEnabled;

  const CustomDropdown({
    Key? key,
    required this.items,
    required this.getId,
    required this.getName,
    required this.onChanged,
    this.hintText = "Select an option",
    this.selectedValue,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  _CustomDropdownState<T> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  TextEditingController searchController = TextEditingController();
  List<T> filteredItems = [];
  OverlayEntry? overlayEntry;
  final LayerLink _layerLink = LayerLink();
  T? selectedItem;

  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
    selectedItem = widget.selectedValue;
    if (selectedItem != null) {
      searchController.text = widget.getName(selectedItem!);
    }
  }

  void filterSearchResults(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredItems = widget.items;
      } else {
        filteredItems = widget.items
            .where((item) => widget.getName(item).toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
    _showOverlay();
  }

  void selectItem(T? value) {
    setState(() {
      selectedItem = value;
      searchController.text = value != null ? widget.getName(value) : "";
    });

    widget.onChanged(value);
    _removeOverlay();
  }

  void clearSelection() {
    setState(() {
      selectedItem = null;
      searchController.clear();
      filteredItems = widget.items;
    });

    widget.onChanged(null);
    _removeOverlay();
  }

  void _showOverlay() {
    _removeOverlay();

    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
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
                    constraints: BoxConstraints(maxHeight: 200),
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: filteredItems.isEmpty
                          ? [ListTile(title: Text("No item found"))]
                          : filteredItems.map((item) {
                        return ListTile(
                          title: Text(widget.getName(item)),
                          onTap: () => selectItem(item),
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (overlayEntry != null) {
          _removeOverlay();
          return false;
        }
        return true;
      },
      child: GestureDetector(
        onTap: _removeOverlay,
        child: CompositedTransformTarget(
          link: _layerLink,
          child: TextFormField(
            style: TextStyle(color: widget.isEnabled ? Colors.black : Colors.grey),
            controller: searchController,
            readOnly: !widget.isEnabled,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (searchController.text.isNotEmpty)
                    widget.isEnabled
                        ? IconButton(
                      icon: Icon(Icons.close, color: Colors.grey, size: 20),
                      onPressed: clearSelection,
                    )
                        : Container(),
                  IconButton(
                    icon: Icon(Icons.arrow_drop_down),
                    onPressed: widget.isEnabled ? _showOverlay : null,
                  ),
                ],
              ),
            ),
            onChanged: filterSearchResults,
            onTap: widget.isEnabled ? _showOverlay : null,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    _removeOverlay();
    super.dispose();
  }
}

