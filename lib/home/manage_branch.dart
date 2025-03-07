import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ksdpl/controllers/manage_branch/manage_branch_controller.dart';
import 'package:ksdpl/models/GetAllBranchByBankIdModel.dart';
import '../common/helper.dart';
import '../common/skelton.dart';
import '../common/storage_service.dart';
import '../controllers/registration_dd_controller.dart';
import '../custom_widgets/CustomSegmentedButton.dart';
import '../custom_widgets/custom_flutter_switch.dart';

ManageBranchController manageBranchController=Get.put(ManageBranchController());

class ManageBranchScreen1 extends StatefulWidget {
  const ManageBranchScreen1({super.key});

  @override
  ManageBranchScreen1State createState() => ManageBranchScreen1State();
}

class ManageBranchScreen1State extends State<ManageBranchScreen1> {

 // List<Data> branchData = [];
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnInde=0;
  bool _sortAscending = true;


  void _sort<T>(Comparable<T> Function(Data d) getField, int columnIndex, bool ascending) {
    manageBranchController.branchData.sort((Data a, Data b) {
      if (!ascending) {
        final Data temp = a;
        a = b;
        b = temp;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });

    setState(() {
      _sortColumnInde = columnIndex;
      _sortAscending = ascending;
    });
  }

  final FocusNode _buttonFocusNode = FocusNode(debugLabel: 'Menu Button');




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppText.manageBranches),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(

            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(AppText.branchList, style: TextStyle(fontSize: 20),),
                    MenuAnchor(
                      childFocusNode: _buttonFocusNode,
                      menuChildren: <Widget>[
                        MenuItemButton(
                          child: const Text("Show/Hide Search"),
                          onPressed: (){},
                        ),
                        MenuItemButton(
                          onPressed: (){},

                          child: const Text("Toggle Desnsity"),
                        ),
                        SubmenuButton(
                          menuChildren: <Widget>[
                            MenuItemButton(
                              onPressed:null,

                              child: Row(

                                children: [
                                  Obx(()=> CustomSegmentedButton(
                                    selectedValue: manageBranchController.selectionViewCLearAll.value,
                                    onSelectionChanged: (val){

                                      manageBranchController.selectionViewCLearAll.value=val;
                                      if (val == 'clear_all') {
                                        manageBranchController.snToggle.value=false;
                                        manageBranchController.cityToggle.value=false;
                                        manageBranchController.micrToggle.value=false;
                                        manageBranchController.zipToggle.value=false;
                                        manageBranchController.addressToggle.value=false;
                                        manageBranchController.brCodeToggle.value=false;
                                        manageBranchController.emailToggle.value=false;
                                        manageBranchController.distToggle.value=false;
                                        manageBranchController.brNameToggle.value=false;
                                        manageBranchController.zipToggle.value=false;
                                        manageBranchController.phNoToggle.value=false;
                                        manageBranchController.ifscToggle.value=false;
                                        manageBranchController.stateToggle.value=false;
                                      } else if (val == 'select_all') {
                                        manageBranchController.snToggle.value=true;
                                        manageBranchController.cityToggle.value=true;
                                        manageBranchController.micrToggle.value=true;
                                        manageBranchController.zipToggle.value=true;
                                        manageBranchController.addressToggle.value=true;
                                        manageBranchController.brCodeToggle.value=true;
                                        manageBranchController.emailToggle.value=true;
                                        manageBranchController.distToggle.value=true;
                                        manageBranchController.brNameToggle.value=true;
                                        manageBranchController.zipToggle.value=true;
                                        manageBranchController.phNoToggle.value=true;
                                        manageBranchController.ifscToggle.value=true;
                                        manageBranchController.stateToggle.value=true;
                                      }
                                    },
                                  ))

                                ],
                              ),
                            ),
                            MenuItemButton(
                              onPressed:null,

                              child: Row(

                                children: [
                                  Obx(()=>CustomFlutterSwitch(
                                    value: manageBranchController.snToggle.value,
                                    onToggle: (val) {

                                      manageBranchController.snToggle.value=val;
                                      manageBranchController.checkToggleSelection();
                                    },
                                  )),
                                  const SizedBox(width: 15,),
                                  const Text(AppText.sNo, style: TextStyle(color: AppColor.black87),),

                                ],
                              ),
                            ),
                            MenuItemButton(
                              onPressed:null,

                              child: Row(

                                children: [
                                  Obx(()=>CustomFlutterSwitch(
                                    value: manageBranchController.brNameToggle.value,
                                    onToggle: (val) {
                                       manageBranchController.brNameToggle.value=val;
                                       manageBranchController.checkToggleSelection();
                                    },
                                  )),
                                  const SizedBox(width: 15,),
                                  const Text(AppText.branchName, style: TextStyle(color: AppColor.black87),),

                                ],
                              ),
                            ),
                            MenuItemButton(
                              onPressed:null,

                              child: Row(

                                children: [
                                  Obx(()=>CustomFlutterSwitch(
                                    value: manageBranchController.ifscToggle.value,
                                    onToggle: (val) {
                                      manageBranchController.ifscToggle.value=val;
                                      manageBranchController.checkToggleSelection();
                                    },
                                  )),
                                  const SizedBox(width: 15,),
                                  const Text(AppText.IFSC, style: TextStyle(color: AppColor.black87),),

                                ],
                              ),
                            ),
                            MenuItemButton(
                              onPressed:null,

                              child: Row(

                                children: [
                                  Obx(()=>CustomFlutterSwitch(
                                    value: manageBranchController.phNoToggle.value,
                                    onToggle: (val) {
                                      manageBranchController.phNoToggle.value=val;
                                      manageBranchController.checkToggleSelection();
                                    },
                                  )),
                                  const SizedBox(width: 15,),
                                  const Text(AppText.phoneNo, style: TextStyle(color: AppColor.black87),),

                                ],
                              ),
                            ),
                            MenuItemButton(
                              onPressed:null,

                              child: Row(

                                children: [
                                  Obx(()=>CustomFlutterSwitch(
                                    value: manageBranchController.emailToggle.value,
                                    onToggle: (val) {
                                      manageBranchController.emailToggle.value=val;
                                      manageBranchController.checkToggleSelection();
                                    },
                                  )),
                                  const SizedBox(width: 15,),
                                  const Text(AppText.eml, style: TextStyle(color: AppColor.black87),),

                                ],
                              ),
                            ),
                            MenuItemButton(
                              onPressed:null,

                              child: Row(

                                children: [
                                  Obx(()=>CustomFlutterSwitch(
                                    value: manageBranchController.stateToggle.value,
                                    onToggle: (val) {

                                      manageBranchController.stateToggle.value=val;
                                      manageBranchController.checkToggleSelection();
                                    },
                                  )),
                                  const SizedBox(width: 15,),
                                  const Text(AppText.state, style: TextStyle(color: AppColor.black87),),

                                ],
                              ),
                            ),
                            MenuItemButton(
                              onPressed:null,

                              child: Row(

                                children: [
                                  Obx(()=>CustomFlutterSwitch(
                                    value: manageBranchController.distToggle.value,
                                    onToggle: (val) {
                                      manageBranchController.distToggle.value=val;
                                      manageBranchController.checkToggleSelection();
                                    },
                                  )),
                                  const SizedBox(width: 15,),
                                  const Text(AppText.district, style: TextStyle(color: AppColor.black87),),

                                ],
                              ),
                            ),
                            MenuItemButton(
                              onPressed:null,

                              child: Row(

                                children: [
                                  Obx(()=>CustomFlutterSwitch(
                                    value: manageBranchController.cityToggle.value,
                                    onToggle: (val) {
                                      manageBranchController.cityToggle.value=val;
                                      manageBranchController.checkToggleSelection();
                                    },
                                  )),
                                  const SizedBox(width: 15,),
                                  const Text(AppText.city, style: TextStyle(color: AppColor.black87),),

                                ],
                              ),
                            ),
                            MenuItemButton(
                              onPressed:null,

                              child: Row(

                                children: [
                                  Obx(()=>CustomFlutterSwitch(
                                    value: manageBranchController.micrToggle.value,
                                    onToggle: (val) {
                                      manageBranchController.micrToggle.value=val;
                                      manageBranchController.checkToggleSelection();
                                    },
                                  )),
                                  const SizedBox(width: 15,),
                                  const Text(AppText.mICRCode, style: TextStyle(color: AppColor.black87),),

                                ],
                              ),
                            ),
                            MenuItemButton(
                              onPressed:null,

                              child: Row(

                                children: [
                                  Obx(()=>CustomFlutterSwitch(
                                    value: manageBranchController.zipToggle.value,
                                    onToggle: (val) {
                                     manageBranchController.zipToggle.value=val;
                                     manageBranchController.checkToggleSelection();
                                    },
                                  )),
                                  const SizedBox(width: 15,),
                                  const Text(AppText.zipCode, style: TextStyle(color: AppColor.black87),),

                                ],
                              ),
                            ),
                            MenuItemButton(
                              onPressed:null,

                              child: Row(

                                children: [
                                  Obx(()=>CustomFlutterSwitch(
                                    value: manageBranchController.addressToggle.value,
                                    onToggle: (val) {
                                     manageBranchController.addressToggle.value=val;
                                     manageBranchController.checkToggleSelection();
                                    },
                                  )),
                                  const SizedBox(width: 15,),
                                  const Text(AppText.address, style: TextStyle(color: AppColor.black87),),

                                ],
                              ),
                            ),
                            MenuItemButton(
                              onPressed:null,

                              child: Row(

                                children: [
                                  Obx(()=>CustomFlutterSwitch(
                                    value: manageBranchController.brCodeToggle.value,
                                    onToggle: (val) {
                                      manageBranchController.brCodeToggle.value=val;
                                      manageBranchController.checkToggleSelection();
                                    },
                                  )),
                                  const SizedBox(width: 15,),
                                  const Text(AppText.branchCode, style: TextStyle(color: AppColor.black87),),

                                ],
                              ),
                            ),
                          ],
                          child: const Text('Show/Hide Columns'),
                        ),
                      ],
                      builder: (BuildContext context, MenuController controller, Widget? child) {
                        return TextButton(
                          focusNode: _buttonFocusNode,
                          onPressed: () {
                            if (controller.isOpen) {
                              controller.close();
                            } else {
                              controller.open();
                            }
                          },
                          child: const Text('Menu'),
                        );
                      },
                    ),
                  ],
                ),
              ),

              Obx((){
                if(manageBranchController.snToggle.value==false &&
                    manageBranchController.brNameToggle.value==false &&
                    manageBranchController.ifscToggle.value==false &&
                    manageBranchController.phNoToggle.value==false &&
                    manageBranchController.emailToggle.value==false &&
                    manageBranchController.stateToggle.value==false &&
                    manageBranchController.distToggle.value==false &&
                    manageBranchController.cityToggle.value==false &&
                    manageBranchController.micrToggle.value==false &&
                    manageBranchController.zipToggle.value==false &&
                    manageBranchController.zipToggle.value==false &&
                    manageBranchController.brCodeToggle.value==false
                ){
                  return const Center(child: Text(AppText.noDataFound,style: TextStyle(fontSize: 20, color: AppColor.lightGrey),));
                }

                return PaginatedDataTable(

                  headingRowHeight: 80,
                  headingRowColor: WidgetStateColor.resolveWith((states) => AppColor.primaryColor),
                  rowsPerPage: _rowsPerPage,
                  onRowsPerPageChanged: (int? value) {
                    if (value != null) {
                      setState(() {
                        _rowsPerPage = value;
                      });
                    }
                  },
                  availableRowsPerPage:  const [5, 10, 14],
                  sortColumnIndex: _sortColumnInde,
                  sortAscending: _sortAscending,
                  columns: _generateColumns(),
                  source: _BranchDataTableSource(manageBranchController.branchData),
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIconButton({
    required IconData icon,
    required VoidCallback onPressed
}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: GestureDetector(
        onTap: onPressed,
        child: FaIcon(
          icon,
          size: 14,
          color: Colors.grey,
        ),
      ),
    );
  }

  List<DataColumn> _generateColumns() {
    final List<Map<String, dynamic>> columnConfigs = [
      {'label': AppText.sNo, 'toggle': manageBranchController.snToggle.value, 'key': AppText.sNo, "colIndex":0},
      {'label': AppText.branchName, 'toggle': manageBranchController.brNameToggle.value, 'key': AppText.branchName,"colIndex":1},
      {'label': AppText.IFSC, 'toggle': manageBranchController.ifscToggle.value, 'key': AppText.IFSC,"colIndex":2},
      {'label': AppText.phoneNo, 'toggle': manageBranchController.phNoToggle.value, 'key': AppText.phoneNo,"colIndex":3},
      {'label': AppText.eml, 'toggle': manageBranchController.emailToggle.value, 'key': AppText.eml,"colIndex":4},
      {'label': AppText.state, 'toggle': manageBranchController.stateToggle.value, 'key': AppText.state,"colIndex":5},
      {'label': AppText.district, 'toggle': manageBranchController.distToggle.value, 'key': AppText.district, "colIndex":6},
      {'label': AppText.city, 'toggle': manageBranchController.cityToggle.value, 'key': AppText.city,"colIndex":7},
      {'label': AppText.mICRCode, 'toggle': manageBranchController.micrToggle.value, 'key': AppText.mICRCode,"colIndex":8},
      {'label': AppText.zipCode, 'toggle': manageBranchController.zipToggle.value, 'key': AppText.zipCode,"colIndex":9},
      {'label': AppText.address, 'toggle': manageBranchController.addressToggle.value, 'key': AppText.address,"colIndex":10},
      {'label': AppText.branchCode, 'toggle': manageBranchController.brCodeToggle.value, 'key': AppText.branchCode,"colIndex":11},
    ];

    return columnConfigs
        .where((column) => column['toggle']) // ✅ Only include enabled columns
        .map((column) => DataColumn(
      label: generateLabel(
        label: column['label'],
        colIndex: column['colIndex']
      ),

    ))
        .toList();
  }

  generateLabel({
    required String label,
    required int colIndex
   }){
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppStyles.headerTextStyle),
          const SizedBox(height: 5),
          if(label!=AppText.sNo)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [

                Container(
                  width: 30,
                  height: 30,


                  child: OverflowBox(
                    maxHeight: 60,
                    child: SearchAnchor(


                      viewConstraints: BoxConstraints(
                        minHeight: 60,
                        maxHeight: 60,
                        maxWidth: MediaQuery.of(context).size.width,
                        minWidth: MediaQuery.of(context).size.width,

                      ),
                      dividerColor: Colors.transparent,
                      isFullScreen: false,
                      builder: (BuildContext context, SearchController controller) {
                        return Center(
                          child: IconButton(
                            icon: const FaIcon(
                              FontAwesomeIcons.filter,
                              size: 14,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              controller.openView();
                            },
                          ),
                        );
                      },
                      suggestionsBuilder:
                          (BuildContext context, SearchController controller) async {


/*
                             if (_searchingWithQuery != controller.text) {
                          return _lastOptions;
                        }

                        _lastOptions = List<ListTile>.generate(options.length, (int index) {
                          final String item = options[index];
                          return ListTile(title: Text(item));
                        });

                        return [
                          SizedBox(
                            height: 100, // 👈 Set the desired height here
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: _lastOptions.toList(), // 👈 Convert Iterable to List
                              ),
                            ),
                          )
                        ];*/
                        return [];
                      },
                    ),
                  ),

                ),


                const SizedBox(
                  width: 15,
                ),

                buildIconButton(
                  icon:  _sortColumnInde == colIndex
                      ? (_sortAscending ? FontAwesomeIcons.arrowUp : FontAwesomeIcons.arrowDown)
                      : FontAwesomeIcons.sort,
                  onPressed:   () {

                    _sort<String>(
                      fieldExtractors[label]!,
                      colIndex,
                      !_sortAscending,
                    );

                  },
                ),
                const SizedBox(
                  width: 15,
                ),
                Container(
                  //  color: Colors.red,
                  width: 10,
                  height: 24,
                  alignment: Alignment.center,
                  child: MenuAnchor(

                    childFocusNode: _buttonFocusNode,
                    menuChildren: <Widget>[
                      MenuItemButton(
                        child: const Row(

                          children: [
                            Icon(Icons.dehaze),
                            SizedBox(width: 10,),
                            Text(AppText.clearSort)
                          ],
                        ),
                        onPressed: (){
                          if(!_sortAscending){
                            _sort<String>(
                              fieldExtractors[label]!,
                              colIndex,
                              !_sortAscending,
                            );
                          }

                        },
                      ),
                      MenuItemButton(
                        onPressed:_sortAscending?null: (){
                          if(!_sortAscending){
                            _sort<String>(
                              fieldExtractors[label]!,
                              colIndex,
                              !_sortAscending,
                            );
                          }
                        },

                        child: Row(
                          children: [
                            const Icon(Icons.arrow_downward),
                            const SizedBox(width: 10,),
                            Text("${AppText.sort} $label ${AppText.ascending}"),
                          ],
                        ),
                      ),
                      MenuItemButton(
                        onPressed:!_sortAscending?null: (){
                          if(_sortAscending){
                            _sort<String>(
                              fieldExtractors[label]!,
                              colIndex,
                              !_sortAscending,
                            );
                          }
                        },

                        child: Row(
                          children: [
                            const Icon(Icons.arrow_upward),
                            const SizedBox(width: 10,),
                            Text("${AppText.sort} $label ${AppText.descending}"),
                          ],
                        ),
                      ),

                      Helper.customDivider(
                          color: AppColor.grey200
                      ),

                      MenuItemButton(
                        onPressed:(){

                        },

                        child: const Row(
                          children: [
                            Icon(Icons.filter_list_off),
                            SizedBox(width: 10,),
                            Text(AppText.clearFilters),
                          ],
                        ),
                      ),

                      MenuItemButton(
                        onPressed:(){

                          manageBranchController.changeListToggle(label, false);
                          manageBranchController.checkToggleSelection();
                        },

                        child: Row(
                          children: [
                            const Icon(Icons.visibility_off_outlined),
                            const SizedBox(width: 10,),
                            Text("${AppText.hide} $label ${AppText.column}"),
                          ],
                        ),
                      ),

                      MenuItemButton(
                        onPressed:(){
                          manageBranchController.showAllColumns();
                        },

                        child: const Row(
                          children: [
                            Icon(Icons.view_column_outlined),
                            SizedBox(width: 10,),
                            Text(AppText.showAllColumns),
                          ],
                        ),
                      ),


                    ],
                    builder: (BuildContext context, MenuController controller, Widget? child) {
                      return IconButton(
                        padding: EdgeInsets.zero, // 👈 Remove extra padding
                        constraints: const BoxConstraints(), //
                        focusNode: _buttonFocusNode,
                        onPressed: () {
                          if (controller.isOpen) {
                            controller.close();
                          } else {
                            controller.open();
                          }
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.ellipsisVertical,
                          size: 14,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }

// mapping from  column labels to functions that extract the corresponding property.
  final Map<String, Comparable<String> Function(Data)> fieldExtractors = {

    AppText.branchName: (Data d) => d.branchName.toString(),
    AppText.IFSC: (Data d) => d.ifsc.toString(),
    AppText.phoneNo: (Data d) => d.branchPhoneNo.toString(),
    AppText.eml: (Data d) => d.email.toString(),
    AppText.state: (Data d) => d.stateName.toString(),
    AppText.district: (Data d) => d.districtName.toString(),
    AppText.city: (Data d) => d.cityName.toString(),
    AppText.mICRCode: (Data d) => d.micrCode.toString(),
    AppText.zipCode: (Data d) => d.zipCode.toString(),
    AppText.address: (Data d) => d.branchAddress.toString(),
    AppText.branchCode: (Data d) => d.branchCode.toString(),
  };


}

class _BranchDataTableSource extends DataTableSource {
  final List<Data> branchData;

  _BranchDataTableSource(this.branchData,);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    final Data branch = branchData[index];
    return DataRow.byIndex(

      index: index,
      cells: [
        if(manageBranchController.snToggle.value)
        DataCell(Text((index+1).toString() ?? '')),

        if(manageBranchController.brNameToggle.value)
        DataCell(Text(branch.branchName ?? '')),

        if(manageBranchController.ifscToggle.value)
        DataCell(Text(branch.ifsc ?? '')),

        if(manageBranchController.phNoToggle.value)
        DataCell(Text(branch.branchPhoneNo ?? '')),

        if(manageBranchController.emailToggle.value)
        DataCell(Text(branch.email ?? '')),

        if(manageBranchController.stateToggle.value)
        DataCell(Text(branch.stateName ?? '')),

        if(manageBranchController.distToggle.value)
        DataCell(Text(branch.districtName ?? '')),

        if(manageBranchController.cityToggle.value)
        DataCell(Text(branch.cityName ?? '')),

        if(manageBranchController.micrToggle.value)
        DataCell(Text(branch.micrCode ?? '')),

        if(manageBranchController.zipToggle.value)
        DataCell(Text(branch.zipCode ?? '')),

        if(manageBranchController.addressToggle.value)
        DataCell(Text(branch.branchAddress ?? '')),

        if(manageBranchController.brCodeToggle.value)
        DataCell(Text(branch.branchCode ?? '')),
      ],
    );
  }

  @override
  int get rowCount => branchData.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

const Duration fakeAPIDuration = Duration(seconds: 1);
