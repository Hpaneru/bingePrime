import 'package:binge_prime/helpers/colors.dart';
import 'package:binge_prime/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatefulWidget {
  ConfirmationDialog(
      {this.title,
      this.description,
      this.onConfirm,
      this.onCancel,
      this.popAfterDone = true});
  final String title;
  final String description;
  final Function onConfirm;
  final Function onCancel;
  final bool popAfterDone;
  @override
  _ConfirmationDialogState createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.transparent,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).backgroundColor,
          ),
          padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.title,
                style: Theme.of(context).primaryTextTheme.headline6,
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                widget.description,
                style: Theme.of(context).primaryTextTheme.caption.copyWith(
                    fontStyle: FontStyle.italic,
                    color: AppColors.disabledColor.withAlpha(220)),
              ),
              SizedBox(height: 12),
              Divider(
                height: 1,
              ),
              SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.width * 0.12,
                    width: 100,
                    child: CustomButton(
                      onPress: () async {
                        Navigator.pop(context);
                        if (widget.onCancel != null) {
                          widget.onCancel();
                        }
                      },
                      label: "Cancel",
                      color: AppColors.red,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.width * 0.12,
                    width: 100,
                    child: CustomButton(
                        onPress: () async {
                          setState(() {
                            loading = true;
                          });
                          try {
                            await widget.onConfirm();
                          } catch (e) {}
                          setState(() {
                            loading = false;
                          });
                          if (widget.popAfterDone) Navigator.pop(context);
                        },
                        label: "Confirm",
                        loading: loading),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
