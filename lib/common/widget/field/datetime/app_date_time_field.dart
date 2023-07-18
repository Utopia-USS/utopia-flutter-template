import 'dart:async';

import 'package:DART_PACKAGE_NAME/common/widget/field/app_field_layout.dart';
import 'package:DART_PACKAGE_NAME/common/widget/field/app_field_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_utils/utopia_utils.dart';

class AppDateTimeField extends StatelessWidget {
  static final _dateFormat = DateFormat('dd.MM.yyyy');
  static final _timeFormat = DateFormat('HH:mm');
  static const _selectableYearRadius = 100;

  final GenericFieldState<DateTime?> state;
  final Widget? label, hint;
  final bool date, time;
  final DateFormat? format;
  final DateTime? min, max;
  final AppFieldThemeData? theme;
  final bool required;

  const AppDateTimeField({
    super.key,
    required this.state,
    this.label,
    this.hint,
    this.date = true,
    this.time = true,
    this.format,
    this.min,
    this.max,
    this.theme,
    this.required = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppFieldLayout(
      showHint: state.value == null,
      required: required,
      label: label,
      hint: hint,
      error: state.errorMessage?.let((it) => Text(it(context))),
      theme: theme,
      onTap: () => unawaited(_showPicker(context)),
      child: Text(_buildValue()),
    );
  }

  String _buildValue() {
    if (state.value == null) return '';
    if (format != null) return format!.format(state.value!);
    return [
      if (date) _dateFormat.format(state.value!),
      if (time) _timeFormat.format(state.value!),
    ].join(' ');
  }

  Future<void> _showPicker(BuildContext context) async {
    var value = DateTime.now();
    if (date) {
      final result = await showDatePicker(
        context: context,
        initialDate: value,
        firstDate: min ?? value.copyWith(year: value.year - _selectableYearRadius),
        lastDate: max ?? value.copyWith(year: value.year + _selectableYearRadius),
      );
      if (result == null) return;
      value = value.copyWith(year: result.year, month: result.month, day: result.day);
    }
    if (time && context.mounted) {
      final result = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(value),
      );
      if (result == null) return;
      value = value.copyWith(hour: result.hour, minute: result.minute);
    }
    state.onChanged(value);
  }
}
