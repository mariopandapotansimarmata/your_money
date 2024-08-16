import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:number_text_input_formatter/number_text_input_formatter.dart';
import 'package:your_money_flutter/assets/material_properties.dart';
import 'package:your_money_flutter/feature/form/form_view_model.dart';
import 'package:your_money_flutter/models/transaction_model.dart';

import '../../../utils/model_utils.dart';

class EditForm extends StatefulWidget {
  const EditForm({super.key, required this.transaction});
  final TransactionModel transaction;
  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final FormViewModel _formViewModel = FormViewModel();

  late String documentId;
  TextEditingController amountController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  @override
  void initState() {
    documentId = widget.transaction.documentId!;
    amountController.text =
        ModelUtils.decimalFormatter(widget.transaction.amount!).toString();
    categoryController.text = widget.transaction.category.toString();
    dateTimeController.text = widget.transaction.dateTime.toString();
    notesController.text = widget.transaction.notes.toString();
    super.initState();
  }

  @override
  void dispose() {
    amountController.dispose();
    categoryController.dispose();
    dateTimeController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dateTimeController.text = DateTime.now().toString();
    return Scaffold(
        backgroundColor: MaterialProperties.backgroundColor,
        appBar: AppBar(
          foregroundColor: MaterialProperties.whiteBackgroundColor,
          backgroundColor: MaterialProperties.primaryBlueColor,
          title: const Text("Edit Transaction"),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const HeaderForm(headerName: "Amount"),
                          TextField(
                            controller: amountController,
                            cursorColor: MaterialProperties.primaryBlueColor,
                            style: Theme.of(context).textTheme.bodyLarge!,
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
                              hintText: " Enter Amount of Money",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w300,
                                  ),
                              fillColor: Colors.white,
                              prefixIcon: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 5, 10),
                                  child: Text(
                                    "Rp",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
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
                            // itemHeight: 100,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 8),
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
                              fillColor: MaterialProperties.whiteTextColor,
                            ),
                            style: Theme.of(context).textTheme.bodyLarge!,
                            isExpanded: true,
                            value: widget.transaction.category,
                            items: _formViewModel.catergoryList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Container(
                                  // height: 50,
                                  alignment: Alignment.center,
                                  color: MaterialProperties.whiteTextColor,
                                  child: Row(
                                    children: [
                                      Icon(
                                          ModelUtils.catergoryIconList[value]!),
                                      const SizedBox(width: 15),
                                      Text(value),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                categoryController.text = value!;
                                print(categoryController.text);
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 15),
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
                                    return true;
                                  },
                                  onChanged: (val) {
                                    dateTimeController.text = val;
                                  },
                                  validator: (val) {
                                    print(val);
                                    return null;
                                  },
                                  onSaved: (val) {
                                    dateTimeController.text = val!;
                                  },
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
                            controller: notesController,
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
                        _formViewModel.editTransaction(
                            context,
                            documentId,
                            amountController,
                            categoryController,
                            dateTimeController,
                            notesController);
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(
                            color: MaterialProperties.whiteTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      )),
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
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(headerName,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w300, color: Colors.grey[900])),
          const SizedBox(
            height: 8,
          )
        ],
      ),
    );
  }
}
