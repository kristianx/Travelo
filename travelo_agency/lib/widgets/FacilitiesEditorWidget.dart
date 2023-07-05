import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_tag_editor/tag_editor.dart';
import 'package:provider/provider.dart';
import 'package:travelo_agency/widgets/SimpleButton.dart';
import '../providers/accomodation_provider.dart';
import 'CustomSnackBar.dart';

class FacilitiesEditorWidget extends StatefulWidget {
  const FacilitiesEditorWidget({super.key, required this.accomodationId});
  final int accomodationId;
  @override
  State<FacilitiesEditorWidget> createState() => _FacilitiesEditorWidgetState();
}

class _FacilitiesEditorWidgetState extends State<FacilitiesEditorWidget> {
  List<String> _values = [];
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();
  late AccomodationProvider _accomodationProvider;

  _onDelete(index) {
    setState(() {
      _values.removeAt(index);
    });
  }

  /// This is just an example for using `TextEditingController` to manipulate
  /// the the `TextField` just like a normal `TextField`.
  _onPressedModifyTextField() {
    final text = 'Test';
    _textEditingController.text = text;
    _textEditingController.value = _textEditingController.value.copyWith(
      text: text,
      selection: TextSelection(
        baseOffset: text.length,
        extentOffset: text.length,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _accomodationProvider = context.read<AccomodationProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TagEditor(
        length: _values.length,
        controller: _textEditingController,
        focusNode: _focusNode,
        delimiters: [',', ' '],
        hasAddButton: true,
        resetTextOnSubmitted: true,
        // This is set to grey just to illustrate the `textStyle` prop
        textStyle: const TextStyle(color: Colors.grey),
        onSubmitted: (outstandingValue) {
          setState(() {
            _values.add(outstandingValue);
          });
        },
        inputDecoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Facility name...',
        ),
        onTagChanged: (newValue) {
          setState(() {
            _values.add(newValue);
          });
        },
        tagBuilder: (context, index) => _Chip(
          index: index,
          label: _values[index],
          onDeleted: _onDelete,
        ),
        // InputFormatters example, this disallow \ and /
        inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'[/\\]'))],
      ),
      Center(
        child: SimpleButton(
          onTap: () async {
            if (_values.isNotEmpty) {
              try {
                bool flag = await _accomodationProvider.facilitiesUpdate(
                    widget.accomodationId as int, _values);
                if (flag) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      CustomSnackBar.showSuccessSnackBar(
                          "You have successfuly changed facilities."));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      CustomSnackBar.showErrorSnackBar(
                          "There was an error changing facilities."));
                }
              } catch (e) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text("Error"),
                          content: Text(e.toString()),
                          actions: [
                            TextButton(
                              child: const Text("Ok"),
                              onPressed: () => Navigator.pop(context),
                            )
                          ],
                        ));
              }
            }
          },
          bgColor: const Color(0xffEAAD5F),
          textColor: Colors.white,
          text: "Save Changes",
          width: 300,
          height: 70,
        ),
      ),
    ]);
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.onDeleted,
    required this.index,
  });

  final String label;
  final ValueChanged<int> onDeleted;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: const EdgeInsets.only(left: 8.0),
      label: Text(label),
      deleteIcon: const Icon(
        Icons.close,
        size: 18,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}
