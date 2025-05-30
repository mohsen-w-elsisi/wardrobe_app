import 'package:flutter/material.dart';

class SubmitableBottomSheet extends StatelessWidget {
  static const _titleBodySpacing = EdgeInsets.only(top: 8.0);
  static const _sheetPadding = EdgeInsets.symmetric(
    vertical: 16,
    horizontal: 8,
  );

  final BuildContext context;
  final String title;
  final String submitButtonText;
  final void Function() onSubmit;
  final Widget Function(BuildContext context) builder;

  const SubmitableBottomSheet({
    super.key,
    required this.title,
    required this.submitButtonText,
    required this.onSubmit,
    required this.context,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _sheetPadding,
      child: Stack(
        children: [
          Column(
            children: [
              _title(context),
              _body(context),
            ],
          ),
          _submitButton()
        ],
      ),
    );
  }

  Widget _title(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  Widget _body(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: _titleBodySpacing,
        child: builder(context),
      ),
    );
  }

  Widget _submitButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: double.infinity,
        child: FilledButton(
          onPressed: _onSubmitAndPop,
          child: Text(submitButtonText),
        ),
      ),
    );
  }

  void _onSubmitAndPop() {
    onSubmit();
    Navigator.pop(context);
  }
}
