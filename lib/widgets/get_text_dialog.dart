import 'package:flutter/material.dart';
import 'package:wishlist/widgets/default_outline_button.dart';
import 'package:wishlist/widgets/snackbar_helper.dart';

class GetTextDialog<T> extends StatefulWidget {
  const GetTextDialog({
    Key? key,
    required this.title,
    required this.hintText,
    required this.confirmAction,
    required this.onConfirm,
    this.isNumber = false,
    this.initialText,
    this.onSecondOption,
  }) : super(key: key);

  final String? initialText;
  final String title;
  final String hintText;
  final String confirmAction;
  final bool isNumber;
  final Function(T) onConfirm;
  final VoidCallback? onSecondOption;

  @override
  State<GetTextDialog<T>> createState() => _GetTextDialogState<T>();
}

class _GetTextDialogState<T> extends State<GetTextDialog<T>> {
  final nomeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nomeController.text = widget.initialText ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      widget.title,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (widget.onSecondOption != null) ...[
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.change_circle),
                        color: Colors.black,
                        onPressed: widget.onSecondOption!,
                      ),
                    ],
                  ],
                ),
                const Divider(color: Colors.black87),
                const SizedBox(height: 0),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: nomeController,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            border: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                            labelText: widget.hintText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    DefaultOutlineButton(
                      text: "Cancelar",
                      color: Colors.red,
                    ),
                    const SizedBox(width: 20),
                    DefaultOutlineButton(
                      text: widget.confirmAction,
                      color: Colors.green,
                      onPressed: () {
                        if (nomeController.text.isEmpty) {
                          showInSnackBar(
                            context: context,
                            type: SnackBarType.warning,
                            text: "Deve ser informado um nome",
                          );
                          nomeController.clear();
                          return;
                        }
                        widget.onConfirm(nomeController.text as T);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
