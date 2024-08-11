import 'package:flutter/material.dart';
import 'package:your_money_flutter/assets/ciruclar_icon.dart';
import 'package:your_money_flutter/feature/form/edit_form/edit_form_view.dart';
import 'package:your_money_flutter/feature/home/detail_views/details_widgets/detail_page_button.dart';
import 'package:your_money_flutter/repository/utils/model_utils.dart';

import '../../../assets/material_properties.dart';
import '../../../models/transaction_model.dart';

class DetailTransaction extends StatefulWidget {
  const DetailTransaction({
    super.key,
    required this.transaction,
  });

  final TransactionModel transaction;

  @override
  State<DetailTransaction> createState() => _DetailTransactionState();
}

class _DetailTransactionState extends State<DetailTransaction> {
  TextEditingController notesController = TextEditingController();

  @override
  void initState() {
    notesController.text = widget.transaction.notes!;
    super.initState();
  }

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: MaterialProperties.whiteBackgroundColor,
        backgroundColor: MaterialProperties.primaryBlueColor,
        title: Text(
          "${widget.transaction.category}",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        // actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.edit))],
      ),
      body: Container(
        height: screenHeight * 0.94,
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              height: screenHeight * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: screenHeight * 0.35,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TranscIcon(
                          icon:
                              ModelUtils.getIcon(widget.transaction.category!)!,
                          color: MaterialProperties.primaryBlueColor,
                          size: 70,
                        ),
                        Text(
                          "Rp ${ModelUtils.decimalFormatter(widget.transaction.amount!)} ",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(ModelUtils.dateTimeFormatter(
                            widget.transaction.dateTime!)),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Notes",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w300),
                            ),
                            TextField(
                              controller: notesController,
                              readOnly: true,
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
                                      color: MaterialProperties
                                          .transactionBorderColor),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                children: [
                  DetailPageButton(
                      page: EditForm(transaction: widget.transaction),
                      text: "Edit",
                      icon: Icons.edit,
                      backgroundColor: Colors.amber[800]!),
                  const SizedBox(
                    height: 10,
                  ),
                  DetailPageButton(
                      text: "Delete",
                      icon: Icons.delete_outline,
                      backgroundColor: Colors.red[800]!)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
