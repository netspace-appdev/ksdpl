/*
class Step3FormProduct extends StatelessWidget {
  final AddProductController addProductController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: addProductController.stepFormKeys[3],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Text("Processing Fee"),
          const SizedBox(height: 8),
          TextFormField(
            key: addProductController.processingFeeFieldKey,
            focusNode: addProductController.processingFeeFocusNode,
            controller: addProductController.prodProcessingFeeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Enter Processing Fee",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              final numValue = num.tryParse(value ?? '') ?? 0;
              if (numValue > 100) {
                return "Percentage can't be more than 100!";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
*/
