import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Common widget for handling FocusableActionDetector supports both mouse 
/// (hover) and keyboard (specific list of keys) supported keys: escape, tab, 
/// shift tab, enter, arrow up, arrow down simple callback functions for each 
/// of these events
class XFAD extends StatelessWidget {
  final Function onEscCallback;
  final Function onTabCallback;
  final Function onShiftTabCallback;
  final Function onEnterCallback;
  final Function onArrowUpCallback;
  final Function onArrowDownCallback;
  final ValueChanged<bool> onHoverCallback;
  final Widget child;

  XFAD({
    this.child,
    this.onEscCallback,
    this.onTabCallback,
    this.onShiftTabCallback,
    this.onEnterCallback,
    this.onHoverCallback,
    this.onArrowUpCallback,
    this.onArrowDownCallback,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => FocusableActionDetector(
        actions: _initActions(),
        shortcuts: _initShortcuts(),
        onShowHoverHighlight: onHoverCallback,
        child: child,
      );

  _initShortcuts() => <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.escape): _XIntent.esc(),
        LogicalKeySet(LogicalKeyboardKey.tab): _XIntent.tab(),
        LogicalKeySet.fromSet({LogicalKeyboardKey.tab, LogicalKeyboardKey.shift}): _XIntent.shiftTab(),
        LogicalKeySet(LogicalKeyboardKey.enter): _XIntent.enter(),
        LogicalKeySet(LogicalKeyboardKey.arrowUp): _XIntent.arrowUp(),
        LogicalKeySet(LogicalKeyboardKey.arrowDown): _XIntent.arrowDown(),
      };

  void _actionHandler(_XIntent intent) {
    switch (intent.type) {
      case _XIntentType.Esc:
        if (onEscCallback != null) onEscCallback();
        break;
      case _XIntentType.Tab:
        if (onTabCallback != null) onTabCallback();
        break;
      case _XIntentType.ShiftTab:
        if (onShiftTabCallback != null) onShiftTabCallback();
        break;
      case _XIntentType.Enter:
        if (this.onEnterCallback != null) onEnterCallback();
        break;
      case _XIntentType.ArrowUp:
        if (this.onArrowUpCallback != null) onArrowUpCallback();
        break;
      case _XIntentType.ArrowDown:
        if (this.onArrowDownCallback != null) onArrowDownCallback();
        break;
    }
  }

  _initActions() => <Type, Action<Intent>>{
        _XIntent: CallbackAction<_XIntent>(
          onInvoke: _actionHandler,
        ),
      };
}

class _XIntent extends Intent {
  final _XIntentType type;
  const _XIntent({this.type});

  const _XIntent.esc() : type = _XIntentType.Esc;
  const _XIntent.tab() : type = _XIntentType.Tab;
  const _XIntent.shiftTab() : type = _XIntentType.ShiftTab;
  const _XIntent.enter() : type = _XIntentType.Enter;
  const _XIntent.arrowUp() : type = _XIntentType.ArrowUp;
  const _XIntent.arrowDown() : type = _XIntentType.ArrowDown;
}

enum _XIntentType {
  Esc,
  Tab,
  ShiftTab,
  Enter,
  ArrowUp,
  ArrowDown,
}
