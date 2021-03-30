import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class DeleteBankAccountDialog {
  static showDeleteDialog(BuildContext context, Function onDelete) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(translator.translate("deleteBankAccount")),
            content: Text(translator.translate("deleteAccountConformation")),
            actions: <Widget>[
              FlatButton(
                onPressed: () async {
                  await onDelete();
                  Navigator.of(context).pop();
                },
                child: Text(translator.translate("OK")),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(translator.translate("Cancel")),
              )
            ],
          );
        });
  }
}
