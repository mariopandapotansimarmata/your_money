import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:number_text_input_formatter/number_text_input_formatter.dart';
import 'package:your_money_flutter/assets/material_properties.dart';
import 'package:your_money_flutter/repository/transaction_repositry.dart';

class AddForm extends StatefulWidget {
  const AddForm({super.key});

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final TransactionRepositry vm = TransactionRepositry();

  List<String> catergoryList = [
    "Food",
    "Transportation",
    "Care",
    "Entertainment",
    "Others"
  ];
  Map<String, Icon> catergoryIconList = {
    "Food": const Icon(Icons.food_bank),
    "Transportation": const Icon(Icons.emoji_transportation),
    "Care": const Icon(Icons.health_and_safety),
    "Entertainment": const Icon(Icons.shopify),
    "Others": const Icon(Icons.help_outline_sharp),
  };
  TextEditingController textarea = TextEditingController();
  String? selectedCategory;

  @override
  void dispose() {
    textarea.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String dropdownValue = catergoryList.first;

    return Scaffold(
        backgroundColor: MaterialProperties.backgroundColor,
        appBar: AppBar(
          foregroundColor: MaterialProperties.whiteBackgroundColor,
          backgroundColor: MaterialProperties.primaryBlueColor,
          title: const Text("Add Form"),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.55,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          const HeaderForm(headerName: "Amount"),
                          TextField(
                            cursorColor: MaterialProperties.primaryBlueColor,
                            style: const TextStyle(fontSize: 24),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: MaterialProperties
                                        .transactionBorderColor),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: MaterialProperties.primaryBlueColor),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              isDense: true,
                              hintText: "   Enter Amount of Money",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                              fillColor: Colors.white,
                              prefixIcon: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 5, 10),
                                  child: const Text(
                                    "Rp",
                                    style: TextStyle(fontSize: 24),
                                  )),
                              prefixIconConstraints: const BoxConstraints(
                                  minWidth: 0, minHeight: 0),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              NumberTextInputFormatter(
                                groupDigits: 3,
                                decimalDigits: 0,
                                decimalSeparator: '.',
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const HeaderForm(headerName: "Category"),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: MaterialProperties
                                        .transactionBorderColor),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: MaterialProperties.primaryBlueColor),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              hintText: "   Enter Amount of Money",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                              fillColor: MaterialProperties.whiteTextColor,
                              prefixIconConstraints: const BoxConstraints(
                                  minWidth: 0, minHeight: 0),
                            ),
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                            isExpanded: true,
                            value: dropdownValue,
                            items: catergoryList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Container(
                                  height: 50,
                                  alignment: Alignment.center,
                                  color: MaterialProperties.whiteTextColor,
                                  child: Row(
                                    children: [
                                      catergoryIconList[value]!,
                                      const SizedBox(width: 15),
                                      Text(value),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedCategory = value;
                              });
                            },
                          )
                        ],
                      ),
                      Column(
                        children: [
                          const HeaderForm(headerName: "Date Time"),
                          Row(
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(right: 15),
                                  child: const Icon(Icons.date_range)),
                              Expanded(
                                child: DateTimePicker(
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1.5,
                                            color: MaterialProperties
                                                .transactionBorderColor),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1.5,
                                            color: MaterialProperties
                                                .primaryBlueColor),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      filled: true,
                                      fillColor:
                                          MaterialProperties.whiteTextColor),
                                  type: DateTimePickerType.dateTimeSeparate,
                                  dateMask: 'd MMM, yyyy',
                                  initialValue: DateTime.now().toString(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                  icon: const Icon(Icons.event),
                                  dateLabelText: 'Date',
                                  timeLabelText: "Hour",
                                  selectableDayPredicate: (date) {
                                    if (date.weekday == 6 ||
                                        date.weekday == 7) {
                                      return false;
                                    }
                                    return true;
                                  },
                                  onChanged: (val) => print(val),
                                  validator: (val) {
                                    print(val);
                                    return null;
                                  },
                                  onSaved: (val) => print(val),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const HeaderForm(headerName: "Notes"),
                          TextField(
                            controller: textarea,
                            keyboardType: TextInputType.multiline,
                            maxLines: 4,
                            decoration: InputDecoration(
                              fillColor: MaterialProperties.whiteTextColor,
                              filled: true,
                              hintText: "Enter the notes",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: MaterialProperties
                                        .transactionBorderColor),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: MaterialProperties.primaryBlueColor),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MaterialProperties.primaryBlueColor,
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: () {
                        vm.add();
                      },
                      child: Container(
                          child: Text(
                        "Save",
                        style: TextStyle(
                            color: MaterialProperties.whiteTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ))),
                )
              ],
            ),
          ),
        )));
  }
}

class HeaderForm extends StatelessWidget {
  const HeaderForm({super.key, required this.headerName});

  final String headerName;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          headerName,
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w300,
              color: Colors.grey[500]),
        ),
      ],
    );
  }
}
