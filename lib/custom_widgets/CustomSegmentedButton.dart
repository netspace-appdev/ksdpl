import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksdpl/common/helper.dart';

class CustomSegmentedButton extends StatelessWidget {
  final void Function(String) onSelectionChanged;
  final String selectedValue;

  const CustomSegmentedButton({
    Key? key,
    required this.selectedValue,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<String>(
      style: SegmentedButton.styleFrom(
       // backgroundColor: Colors.grey[200],
       // foregroundColor: Colors.red,
        selectedForegroundColor: AppColor.buttonSelectedColor,
       // selectedBackgroundColor: Colors.green,
      ),
     selectedIcon: Icon(Icons.check),

      segments: const [
        ButtonSegment(
          value: 'clear_all',
          label: Text('Clear All'),
          icon: Icon(Icons.menu),
        ),
        ButtonSegment(
          value: 'select_all',
          label: Text('Select All'),
          icon: Icon(Icons.menu),
        ),
      ],
      selected: {selectedValue},
      onSelectionChanged: (newSelection) {
        if (newSelection.isNotEmpty) {
          onSelectionChanged(newSelection.first);
        }
      },
    );
  }
}
