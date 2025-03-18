/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:permission_handler/permission_handler.dart';
import '../common/helper.dart';
import '../common/skelton.dart';
import '../common/storage_service.dart';
import '../controllers/call_storage_controller.dart';
import '../controllers/registration_dd_controller.dart';
import '../custom_widgets/CustomSegmentedButton.dart';
import '../custom_widgets/custom_flutter_switch.dart';

CallStorageController manageBranchController=Get.put(CallStorageController());

class LeadListScreen extends StatefulWidget {
  const LeadListScreen({super.key});

  @override
  LeadListScreenState createState() => LeadListScreenState();
}

class LeadListScreenState extends State<LeadListScreen> {
  final List<Map<String, String>> branchData = [
    {
      'S No.': '1',
      'Name': 'Manish',
      'Date': '04/03/2025',
      'Mobile Number': '9399299880',
      'Email': 'mgroad.sbi@gmail.com',
      'Pincode': '456001',
      'Status': 'Interested',
    },
    {
      'S No.': '2',
      'Name': 'Rahul',
      'Date': '05/03/2025',
      'Mobile Number': '9876543210',
      'Email': 'rahul123@gmail.com',
      'Pincode': '110001',
      'Status': 'Not Interested',
    },
    {
      'S No.': '3',
      'Name': 'Priya',
      'Date': '06/03/2025',
      'Mobile Number': '8765432109',
      'Email': 'priya88@yahoo.com',
      'Pincode': '400001',
      'Status': 'Interested',
    },
    {
      'S No.': '4',
      'Name': 'Amit',
      'Date': '07/03/2025',
      'Mobile Number': '9988776655',
      'Email': 'amitwork@outlook.com',
      'Pincode': '560001',
      'Status': 'Pending',
    },
    {
      'S No.': '5',
      'Name': 'Sneha',
      'Date': '08/03/2025',
      'Mobile Number': '9123456789',
      'Email': 'sneha.kumar@gmail.com',
      'Pincode': '600001',
      'Status': 'Interested',
    },
    {
      'S No.': '6',
      'Name': 'Vikram',
      'Date': '09/03/2025',
      'Mobile Number': '9012345678',
      'Email': 'vikram.mehra@gmail.com',
      'Pincode': '700001',
      'Status': 'Not Interested',
    },
    {
      'S No.': '7',
      'Name': 'Deepika',
      'Date': '10/03/2025',
      'Mobile Number': '8901234567',
      'Email': 'deepika.rathod@yahoo.com',
      'Pincode': '380001',
      'Status': 'Interested',
    },
    {
      'S No.': '8',
      'Name': 'Ravi',
      'Date': '11/03/2025',
      'Mobile Number': '7890123456',
      'Email': 'ravi.b@gmail.com',
      'Pincode': '500001',
      'Status': 'Pending',
    },
    {
      'S No.': '9',
      'Name': 'Kavita',
      'Date': '12/03/2025',
      'Mobile Number': '6789012345',
      'Email': 'kavita.sharma@hotmail.com',
      'Pincode': '302001',
      'Status': 'Interested',
    },
    {
      'S No.': '10',
      'Name': 'Anil',
      'Date': '13/03/2025',
      'Mobile Number': '5678901234',
      'Email': 'anil.raj@rediffmail.com',
      'Pincode': '122001',
      'Status': 'Not Interested',
    },
    {
      'S No.': '11',
      'Name': 'Meena',
      'Date': '14/03/2025',
      'Mobile Number': '4567890123',
      'Email': 'meena.123@gmail.com',
      'Pincode': '411001',
      'Status': 'Interested',
    },
    {
      'S No.': '12',
      'Name': 'Arjun',
      'Date': '15/03/2025',
      'Mobile Number': '3456789012',
      'Email': 'arjun.singh@outlook.com',
      'Pincode': '641001',
      'Status': 'Pending',
    },
    {
      'S No.': '13',
      'Name': 'Sunita',
      'Date': '16/03/2025',
      'Mobile Number': '2345678901',
      'Email': 'sunita.kapoor@gmail.com',
      'Pincode': '751001',
      'Status': 'Interested',
    },
    {
      'S No.': '14',
      'Name': 'Ramesh',
      'Date': '17/03/2025',
      'Mobile Number': '1234567890',
      'Email': 'ramesh.varma@yahoo.com',
      'Pincode': '800001',
      'Status': 'Not Interested',
    }
  ];



  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnInde=0;
  bool _sortAscending = true;

  void _sort<T>(Comparable<T> getField(Map<String, String> d), int columnIndex, bool ascending) {
    branchData.sort((Map<String, String> a, Map<String, String> b) {
      if (!ascending) {
        final Map<String, String> c = a;
        a = b;
        b = c;
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
  final RegistrationDDController regDDController = Get.put(RegistrationDDController(),);
  TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _filteredData = []; // Store filtered data

  @override
  void initState() {
    super.initState();
    */
/*var bankId=StorageService.get(StorageService.BANK_ID).toString();
    regDDController.getAllBranchByBankIdApi(bankId).then((_){
      print("req data ===>${regDDController.getAllBranchByBankIdModel!.data.toString()}");
      branchData=regDDController.getAllBranchByBankIdModel!.data as List<Map<String, String>>;
      print("req branchData ===>${branchData.toString()}");
    });
    _filteredData = branchData; // Initially, show all data*//*

  }

  void _filterData(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredData = branchData; // Reset to all data
      } else {
        _filteredData = branchData.where((entry) {
          return entry['Branch Name']!.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  String? _searchingWithQuery;
  // The most recent options received from the API.


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Lead List"),
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
                    const Text(AppText.branchList, style: TextStyle(fontSize: 20, color: Colors.transparent),),
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
                if (regDDController.isLoading.value) {
                  return  Center(child:CustomSkelton.productShimmerList(context));
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
                  source: _BranchDataTableSource(branchData),
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
      {'label': "Name", 'toggle': manageBranchController.brNameToggle.value, 'key': "Name","colIndex":1},
      {'label': "Date", 'toggle': manageBranchController.ifscToggle.value, 'key': "Date","colIndex":2},
      {'label': "Mobile Number", 'toggle': manageBranchController.phNoToggle.value, 'key': "Mobile Number","colIndex":3},
      {'label': "Email", 'toggle': manageBranchController.emailToggle.value, 'key': "Email","colIndex":4},
      {'label': "Pincode", 'toggle': manageBranchController.stateToggle.value, 'key': "Pincode","colIndex":5},
      {'label': "Status", 'toggle': manageBranchController.distToggle.value, 'key': "Status", "colIndex":6},
      {'label': "Actions", 'toggle': manageBranchController.cityToggle.value, 'key': "Actions","colIndex":7},

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
                        _searchingWithQuery = controller.text;

                        */
/*      if (_searchingWithQuery != controller.text) {
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
                        ];*//*


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
                          (Map<String, String> d) => d[label]!,
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
                                  (Map<String, String> d) => d[label]!,
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
                                  (Map<String, String> d) => d[label]!,
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
                                  (Map<String, String> d) => d[label]!,
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

*/
/*Widget customSearchBox(){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: "Search",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
           // onChanged: _onSearchChanged, // Listen for input changes
          ),
        ),
        if (_searchQuery.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Searching for: $_searchQuery",
              style: TextStyle(fontSize: 16),
            ),
          ),
      ],
    );
}*//*



}

class _BranchDataTableSource extends DataTableSource {
  final List<Map<String, String>> branchData;

  _BranchDataTableSource(this.branchData,);
  static const platform = MethodChannel("call_recorder");
  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    // if (index >= branchData.length) return null;
    final Map<String, String> branch = branchData[index];
    return DataRow.byIndex(

      index: index,
      cells: [
        if(manageBranchController.snToggle.value)
          DataCell(Text(branch['S No.'] ?? '')),

        if(manageBranchController.brNameToggle.value)

          DataCell(
            InkWell(
              onTap: (){
                Get.toNamed("/leadDetails");
              },
              child: Text(branch['Name'] ?? ''),
            )
          ),

        if(manageBranchController.ifscToggle.value)
          DataCell(Text(branch['Date'] ?? '')),

        if(manageBranchController.phNoToggle.value)
          DataCell(Row(
            children: [
              InkWell(
                onTap: (){

                  //makeCall(branch['Mobile Number'] ?? '');

                },
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      shape: BoxShape.circle
                  ),
                  padding: EdgeInsets.all(5),
                  child: Icon(Icons.phone, size: 10,color: Colors.white,),
                ),
              ),
              SizedBox(width: 10,),
              Text(branch['Mobile Number'] ?? ''),


            ],
          )),

        if(manageBranchController.emailToggle.value)
          DataCell(Text(branch['Email'] ?? '')),

        if(manageBranchController.stateToggle.value)
          DataCell(Text(branch['Pincode'] ?? '')),

        if(manageBranchController.distToggle.value)
          DataCell(Text(branch['Status'] ?? '')),

        if(manageBranchController.cityToggle.value)
          DataCell(Row(
            children: [
              InkWell(
                onTap: (){

                  //makeCall(branch['Mobile Number'] ?? '');
                  Get.toNamed("/leadDetails");

                },
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      shape: BoxShape.circle
                  ),
                  padding: EdgeInsets.all(5),
                  child: Icon(Icons.visibility, size: 10,color: Colors.white,),
                ),
              ),
            ],
          )),

      ],
    );
  }

  @override
  int get rowCount => branchData.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;

  Future<void> requestPermissions() async {
    final micPermission = await Permission.microphone.request();
    final phonePermission = await Permission.phone.request();
    final storagePermission = await Permission.storage.request();
    final microphonePermission= await Permission.microphone.request();

    if (micPermission.isGranted &&
        phonePermission.isGranted &&
        storagePermission.isGranted &&
        microphonePermission.isGranted
    ) {
      print("✅ All required permissions granted");
    } else {
      print("❌ Permissions not granted");
      return;
    }
  }

  Future<void> makeCall(String phoneNumber) async {
    await requestPermissions(); // ✅ Ensure permissions are granted

    const platform = MethodChannel('com.mrb.lender_mrb/calls');

    try {
      print("call recording: method invoked 1");
      await platform.invokeMethod('startCall', {"phoneNumber": phoneNumber});
      print("call recording: method invoked 2");
    } on PlatformException catch (e) {
      print("call recording: Error: ${e.message}");
    }
  }


}


*/
