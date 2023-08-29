/*  
* @ProjectName : fdemo 
* @Author : wizet
* @Time : 2023/8/21 17:36 
* @Description :
*/

// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class JZSliderController {
  Function(double)? setValue;
}

class JZSlider extends StatefulWidget {
  const JZSlider({
    super.key,
    required this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.initialValue = 0.0,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.activeColor = CupertinoColors.white,
    this.thumbColor = CupertinoColors.white,
    this.trackColor = CupertinoColors.white,
    this.controller,
    this.onLabel,
  })  : assert(initialValue != null),
        assert(min != null),
        assert(max != null),
        assert(initialValue >= min && initialValue <= max),
        assert(divisions == null || divisions > 0);

  final JZSliderController? controller;

  /// The currently selected value for this slider.
  ///
  /// The slider's thumb is drawn at a position that corresponds to this value.
  final double initialValue;

  /// Called when the user selects a new value for the slider.
  ///
  /// The slider passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the slider with the new
  /// value.
  ///
  /// If null, the slider will be displayed as disabled.
  ///
  /// The callback provided to onChanged should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method, so that the parent
  /// gets rebuilt; for example:
  ///
  /// ```dart
  /// CupertinoSlider(
  ///   value: _cupertinoSliderValue.toDouble(),
  ///   min: 1.0,
  ///   max: 10.0,
  ///   divisions: 10,
  ///   onChanged: (double newValue) {
  ///     setState(() {
  ///       _cupertinoSliderValue = newValue.round();
  ///     });
  ///   },
  /// )
  /// ```
  ///
  /// See also:
  ///
  ///  * [onChangeStart] for a callback that is called when the user starts
  ///    changing the value.
  ///  * [onChangeEnd] for a callback that is called when the user stops
  ///    changing the value.
  final ValueChanged<double>? onChanged;

  /// Called when the user starts selecting a new value for the slider.
  ///
  /// This callback shouldn't be used to update the slider [initialValue] (use
  /// [onChanged] for that), but rather to be notified when the user has started
  /// selecting a new value by starting a drag.
  ///
  /// The value passed will be the last [initialValue] that the slider had before the
  /// change began.
  ///
  /// {@tool snippet}
  ///
  /// ```dart
  /// CupertinoSlider(
  ///   value: _cupertinoSliderValue.toDouble(),
  ///   min: 1.0,
  ///   max: 10.0,
  ///   divisions: 10,
  ///   onChanged: (double newValue) {
  ///     setState(() {
  ///       _cupertinoSliderValue = newValue.round();
  ///     });
  ///   },
  ///   onChangeStart: (double startValue) {
  ///     print('Started change at $startValue');
  ///   },
  /// )
  /// ```
  /// {@end-tool}
  ///
  /// See also:
  ///
  ///  * [onChangeEnd] for a callback that is called when the value change is
  ///    complete.
  final ValueChanged<double>? onChangeStart;

  /// Called when the user is done selecting a new value for the slider.
  ///
  /// This callback shouldn't be used to update the slider [initialValue] (use
  /// [onChanged] for that), but rather to know when the user has completed
  /// selecting a new [initialValue] by ending a drag.
  ///
  /// {@tool snippet}
  ///
  /// ```dart
  /// CupertinoSlider(
  ///   value: _cupertinoSliderValue.toDouble(),
  ///   min: 1.0,
  ///   max: 10.0,
  ///   divisions: 10,
  ///   onChanged: (double newValue) {
  ///     setState(() {
  ///       _cupertinoSliderValue = newValue.round();
  ///     });
  ///   },
  ///   onChangeEnd: (double newValue) {
  ///     print('Ended change on $newValue');
  ///   },
  /// )
  /// ```
  /// {@end-tool}
  ///
  /// See also:
  ///
  ///  * [onChangeStart] for a callback that is called when a value change
  ///    begins.
  final ValueChanged<double>? onChangeEnd;

  /// The minimum value the user can select.
  ///
  /// Defaults to 0.0.
  final double min;

  /// The maximum value the user can select.
  ///
  /// Defaults to 1.0.
  final double max;

  /// The number of discrete divisions.
  ///
  /// If null, the slider is continuous.
  final int? divisions;

  final Color activeColor;
  final Color thumbColor;
  final Color trackColor;

  final String? Function(double)? onLabel;

  @override
  State<JZSlider> createState() => _JZSliderState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('value', initialValue));
    properties.add(DoubleProperty('min', min));
    properties.add(DoubleProperty('max', max));
  }
}

class _JZSliderState extends State<JZSlider> with TickerProviderStateMixin {
  double currentValue = 0.0;

  @override
  void initState() {
    super.initState();
    currentValue = widget.initialValue;

    widget.controller?.setValue = (value) {
      currentValue = value;
      setState(() {});
    };
  }

  void _handleChanged(double value) {
    assert(widget.onChanged != null);
    final double lerpValue = lerpDouble(widget.min, widget.max, value)!;
    if (lerpValue != currentValue) {
      widget.onChanged!(lerpValue);

      currentValue = lerpValue;
      setState(() {});
    }
  }

  void _handleDragStart(double value) {
    assert(widget.onChangeStart != null);
    widget.onChangeStart!(lerpDouble(widget.min, widget.max, value)!);
  }

  void _handleDragEnd(double value) {
    assert(widget.onChangeEnd != null);
    widget.onChangeEnd!(lerpDouble(widget.min, widget.max, value)!);
  }

  @override
  Widget build(BuildContext context) {
    return _JZSliderRenderObjectWidget(
      value: (currentValue - widget.min) / (widget.max - widget.min),
      divisions: widget.divisions,

      // //FIXME: 颜色修改
      // activeColor: CupertinoDynamicColor.resolve(
      //   widget.activeColor ?? CupertinoTheme.of(context).primaryColor,
      //   context,
      // ),
      // thumbColor: widget.thumbColor,
      activeColor: widget.activeColor,
      thumbColor: widget.thumbColor,
      trackColor: widget.trackColor,

      onChanged: widget.onChanged != null ? _handleChanged : null,
      onChangeStart: widget.onChangeStart != null ? _handleDragStart : null,
      onChangeEnd: widget.onChangeEnd != null ? _handleDragEnd : null,
      onLabel: widget.onLabel,
      vsync: this,
    );
  }
}

class _JZSliderRenderObjectWidget extends LeafRenderObjectWidget {
  const _JZSliderRenderObjectWidget({
    required this.value,
    this.divisions,
    required this.activeColor,
    required this.thumbColor,
    required this.trackColor,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.onLabel,
    required this.vsync,
  });

  final double value;
  final int? divisions;
  final Color activeColor;
  final Color thumbColor;
  final Color trackColor;
  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onChangeStart;
  final ValueChanged<double>? onChangeEnd;
  final TickerProvider vsync;
  final String? Function(double)? onLabel;

  @override
  _RenderJZSlider createRenderObject(BuildContext context) {
    assert(debugCheckHasDirectionality(context));
    return _RenderJZSlider(
      value: value,
      divisions: divisions,
      activeColor: activeColor,
      thumbColor: CupertinoDynamicColor.resolve(thumbColor, context),
      trackColor: trackColor,
      onChanged: onChanged,
      onChangeStart: onChangeStart,
      onChangeEnd: onChangeEnd,
      onLabel: onLabel,
      vsync: vsync,
      textDirection: Directionality.of(context),
      cursor: kIsWeb ? SystemMouseCursors.click : MouseCursor.defer,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderJZSlider renderObject) {
    assert(debugCheckHasDirectionality(context));
    renderObject
      ..value = value
      ..divisions = divisions
      ..activeColor = activeColor
      ..thumbColor = CupertinoDynamicColor.resolve(thumbColor, context)
      ..trackColor = trackColor
      ..onChanged = onChanged
      ..onChangeStart = onChangeStart
      ..onChangeEnd = onChangeEnd
      ..textDirection = Directionality.of(context);
    // Ticker provider cannot change since there's a 1:1 relationship between
    // the _SliderRenderObjectWidget object and the _SliderState object.
  }
}

const double _kPadding = 0;
const double _kSliderHeight = 2.0 * (JZThumbPainter.halfHeight + _kPadding);
const double _kSliderWidth = 176.0; // Matches Material Design slider.
const Duration _kDiscreteTransitionDuration = Duration(milliseconds: 500);

const double _kAdjustmentUnit =
    0.1; // Matches iOS implementation of material slider.

class _RenderJZSlider extends RenderConstrainedBox
    implements MouseTrackerAnnotation {
  // 2023年 8月29日 星期二 16时25分40秒 CST
  final TextPainter _labelPainter = TextPainter();

  var labelShouldShowing = false;
  String? Function(double)? onLabel;

  @override
  void dispose() {
    _labelPainter.dispose();
    super.dispose();
  }

  _RenderJZSlider({
    required double value,
    int? divisions,
    required Color activeColor,
    required Color thumbColor,
    required Color trackColor,
    ValueChanged<double>? onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.onLabel,
    required TickerProvider vsync,
    required TextDirection textDirection,
    MouseCursor cursor = MouseCursor.defer,
  })  : assert(value != null && value >= 0.0 && value <= 1.0),
        assert(textDirection != null),
        assert(cursor != null),
        _cursor = cursor,
        _value = value,
        _divisions = divisions,
        _activeColor = activeColor,
        _thumbColor = thumbColor,
        _trackColor = trackColor,
        _onChanged = onChanged,
        _textDirection = textDirection,
        super(
            additionalConstraints: const BoxConstraints.tightFor(
                width: _kSliderWidth, height: _kSliderHeight)) {
    _drag = HorizontalDragGestureRecognizer()
      ..onStart = _handleDragStart
      ..onUpdate = _handleDragUpdate
      ..onEnd = _handleDragEnd;
    _position = AnimationController(
      value: value,
      duration: _kDiscreteTransitionDuration,
      vsync: vsync,
    )..addListener(markNeedsPaint);
  }

  double get value => _value;
  double _value;

  set value(double newValue) {
    assert(newValue != null && newValue >= 0.0 && newValue <= 1.0);
    if (newValue == _value) {
      return;
    }
    _value = newValue;
    if (divisions != null) {
      _position.animateTo(newValue, curve: Curves.fastOutSlowIn);
    } else {
      _position.value = newValue;
    }
    markNeedsSemanticsUpdate();
  }

  int? get divisions => _divisions;
  int? _divisions;

  set divisions(int? value) {
    if (value == _divisions) {
      return;
    }
    _divisions = value;
    markNeedsPaint();
  }

  Color get activeColor => _activeColor;
  Color _activeColor;

  set activeColor(Color value) {
    if (value == _activeColor) {
      return;
    }
    _activeColor = value;
    markNeedsPaint();
  }

  Color get thumbColor => _thumbColor;
  Color _thumbColor;

  set thumbColor(Color value) {
    if (value == _thumbColor) {
      return;
    }
    _thumbColor = value;
    markNeedsPaint();
  }

  Color get trackColor => _trackColor;
  Color _trackColor;

  set trackColor(Color value) {
    if (value == _trackColor) {
      return;
    }
    _trackColor = value;
    markNeedsPaint();
  }

  ValueChanged<double>? get onChanged => _onChanged;
  ValueChanged<double>? _onChanged;

  set onChanged(ValueChanged<double>? value) {
    if (value == _onChanged) {
      return;
    }
    final bool wasInteractive = isInteractive;
    _onChanged = value;
    if (wasInteractive != isInteractive) {
      markNeedsSemanticsUpdate();
    }
  }

  ValueChanged<double>? onChangeStart;
  ValueChanged<double>? onChangeEnd;

  TextDirection get textDirection => _textDirection;
  TextDirection _textDirection;

  set textDirection(TextDirection value) {
    assert(value != null);
    if (_textDirection == value) {
      return;
    }
    _textDirection = value;
    markNeedsPaint();
  }

  late AnimationController _position;

  late HorizontalDragGestureRecognizer _drag;
  double _currentDragValue = 0.0;

  double get _discretizedCurrentDragValue {
    double dragValue = clampDouble(_currentDragValue, 0.0, 1.0);
    if (divisions != null) {
      dragValue = (dragValue * divisions!).round() / divisions!;
    }
    return dragValue;
  }

  double get _trackLeft => _kPadding;

  double get _trackRight => size.width - _kPadding;

  double get _thumbCenter {
    final double visualPosition;
    switch (textDirection) {
      case TextDirection.rtl:
        visualPosition = 1.0 - _value;
        break;
      case TextDirection.ltr:
        visualPosition = _value;
        break;
    }
    return lerpDouble(_trackLeft + JZThumbPainter.halfWidth,
        _trackRight - JZThumbPainter.halfWidth, visualPosition)!;
  }

  bool get isInteractive => onChanged != null;

  void _handleDragStart(DragStartDetails details) =>
      _startInteraction(details.globalPosition);

  void _handleDragUpdate(DragUpdateDetails details) {
    if (isInteractive) {
      final double extent = math.max(
          _kPadding, size.width - 2.0 * (_kPadding + JZThumbPainter.halfWidth));
      final double valueDelta = details.primaryDelta! / extent;
      switch (textDirection) {
        case TextDirection.rtl:
          _currentDragValue -= valueDelta;
          break;
        case TextDirection.ltr:
          _currentDragValue += valueDelta;
          break;
      }
      onChanged!(_discretizedCurrentDragValue);
    }
  }

  void _handleDragEnd(DragEndDetails details) => _endInteraction();

  void _startInteraction(Offset globalPosition) {
    labelShouldShowing = true;
    if (isInteractive) {
      onChangeStart?.call(_discretizedCurrentDragValue);
      _currentDragValue = _value;
      onChanged!(_discretizedCurrentDragValue);
    }
  }

  void _endInteraction() {
    onChangeEnd?.call(_discretizedCurrentDragValue);
    _currentDragValue = 0.0;

    // 2023年 8月29日 星期二 16时31分00秒 CST
    labelShouldShowing = false;
    markNeedsLayout();
  }

  @override
  bool hitTestSelf(Offset position) {
    return (position.dx - _thumbCenter).abs() <
        JZThumbPainter.halfWidth + _kPadding;
  }

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));
    if (event is PointerDownEvent && isInteractive) {
      _drag.addPointer(event);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final double visualPosition;
    final Color leftColor;
    final Color rightColor;
    switch (textDirection) {
      case TextDirection.rtl:
        visualPosition = 1.0 - _position.value;
        leftColor = _activeColor;
        rightColor = trackColor;
        break;
      case TextDirection.ltr:
        visualPosition = _position.value;
        leftColor = trackColor;
        rightColor = _activeColor;
        break;
    }

    final double trackCenter = offset.dy + size.height / 2.0;
    final double trackLeft = offset.dx + _trackLeft;
    final double trackTop = trackCenter - 1.0;
    final double trackBottom = trackCenter + 1.0;
    final double trackRight = offset.dx + _trackRight;
    final double trackActive = offset.dx + _thumbCenter;

    final Canvas canvas = context.canvas;

    if (visualPosition > 0.0) {
      final Paint paint = Paint()..color = rightColor;
      // 绘制左边
      canvas.drawRRect(
          RRect.fromLTRBXY(
              trackLeft, trackTop, trackActive, trackBottom, 1.0, 1.0),
          paint);
    }

    if (visualPosition < 1.0) {
      final Paint paint = Paint()..color = leftColor;
      // 绘制右边
      canvas.drawRRect(
          RRect.fromLTRBXY(
              trackActive, trackTop, trackRight, trackBottom, 1.0, 1.0),
          paint);
    }

    // 中渐渐那块东西
    final Offset thumbCenter = Offset(trackActive, trackCenter);

    double height = 24.0;
    double driverWidth = 32.0;
    var thumbRect = Rect.fromCenter(
        center: thumbCenter, width: driverWidth, height: height);
    JZThumbPainter(color: thumbColor).paint(canvas, thumbRect);

    //FIXME: 判断这个东西的显示与否
    if (labelShouldShowing && this.onLabel != null) {
      // 绘制文字
      _labelPainter
        ..text = TextSpan(
          style: TextStyle(color: Colors.orange, fontSize: 10),
          text: "${this.onLabel!(visualPosition)}",
        )
        ..textDirection = textDirection
        ..textScaleFactor = 1
        ..layout();
      double width = _labelPainter.width + 10;
      double height = 25.0;
      var gap = 5.0;
      var offset = 2.0;
      var topY = thumbCenter.dy - height - gap - offset;
      var thumbRect = Rect.fromCenter(
          center: Offset(thumbCenter.dx, topY), width: width, height: height);
      final RRect rrect = RRect.fromRectAndRadius(
        thumbRect,
        Radius.circular(2),
      );
      // 绘制三角形
      //thumbCenter.dx
      var labelBGPaint = Paint()..color = Colors.green;
      canvas.drawRRect(rrect, labelBGPaint);
      var path = Path();
      path.moveTo(thumbCenter.dx, thumbCenter.dy - (height / 2) - offset);
      path.lineTo(
          thumbCenter.dx - 5, thumbCenter.dy - (height / 2) - gap - offset);
      path.lineTo(
          thumbCenter.dx + 5, thumbCenter.dy - (height / 2) - gap - offset);
      canvas.drawPath(path, labelBGPaint);

      _labelPainter.paint(
          canvas,
          Offset(thumbCenter.dx - (_labelPainter.width / 2),
              topY - _labelPainter.height / 2));
    }
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);

    config.isSemanticBoundary = isInteractive;
    config.isSlider = true;
    if (isInteractive) {
      config.textDirection = textDirection;
      config.onIncrease = _increaseAction;
      config.onDecrease = _decreaseAction;
      config.value = '${(value * 100).round()}%';
      config.increasedValue =
          '${(clampDouble(value + _semanticActionUnit, 0.0, 1.0) * 100).round()}%';
      config.decreasedValue =
          '${(clampDouble(value - _semanticActionUnit, 0.0, 1.0) * 100).round()}%';
    }
  }

  double get _semanticActionUnit =>
      divisions != null ? 1.0 / divisions! : _kAdjustmentUnit;

  void _increaseAction() {
    if (isInteractive) {
      onChanged!(clampDouble(value + _semanticActionUnit, 0.0, 1.0));
    }
  }

  void _decreaseAction() {
    if (isInteractive) {
      onChanged!(clampDouble(value - _semanticActionUnit, 0.0, 1.0));
    }
  }

  @override
  MouseCursor get cursor => _cursor;
  MouseCursor _cursor;

  set cursor(MouseCursor value) {
    if (_cursor != value) {
      _cursor = value;
      // A repaint is needed in order to trigger a device update of
      // [MouseTracker] so that this new value can be found.
      markNeedsPaint();
    }
  }

  @override
  PointerEnterEventListener? onEnter;

  PointerHoverEventListener? onHover;

  @override
  PointerExitEventListener? onExit;

  @override
  bool get validForMouseTracker => false;
}

class JZThumbPainter {
  // static const Color _kThumbBorderColor = Color(0x0A000000);
  //
  // static const List<BoxShadow> _kSwitchBoxShadows = <BoxShadow> [
  //   BoxShadow(
  //     color: Color(0x26000000),
  //     offset: Offset(0, 3),
  //     blurRadius: 8.0,
  //   ),
  //   BoxShadow(
  //     color: Color(0x0F000000),
  //     offset: Offset(0, 3),
  //     blurRadius: 1.0,
  //   ),
  // ];

  static const List<BoxShadow> _kSliderBoxShadows = <BoxShadow>[
    BoxShadow(
      color: Color(0x33000000),
      offset: Offset(0, 0),
      blurRadius: 8.0,
    ),
  ];

  /// Creates an object that paints an iOS-style slider thumb.
  const JZThumbPainter({
    this.color = CupertinoColors.white,
    this.shadows = JZThumbPainter._kSliderBoxShadows,
  }) : assert(shadows != null);

  /// The color of the interior of the thumb.
  final Color color;

  /// The list of [BoxShadow] to paint below the thumb.
  ///
  /// Must not be null.
  final List<BoxShadow> shadows;

  /// 宽度
  static const double halfWidth = 16.0;
  static const double halfHeight = 12.0;

  /// The default amount the thumb should be extended horizontally when pressed.
  // static const double extension = 7.0;

  /// Paints the thumb onto the given canvas in the given rectangle.
  ///
  /// Consider using [halfWidth] and [extension] when deciding how large a
  /// rectangle to use for the thumb.
  void paint(Canvas canvas, Rect rect) {
    final RRect rrect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(4),
    );

    for (final BoxShadow shadow in shadows) {
      canvas.drawRRect(rrect.shift(shadow.offset), shadow.toPaint());
    }
    // canvas.drawRRect(
    //   rrect.inflate(0.5),
    //   Paint()..color = JZThumbPainter._kThumbBorderColor,
    // );

    canvas.drawRRect(rrect, Paint()..color = color);

    var tipsPaint = Paint();
    tipsPaint.strokeWidth = 2;
    tipsPaint.color = Colors.orange;
    var midX = rrect.left + rect.width / 2;
    canvas.drawLine(
        Offset(midX, rect.top + 5), Offset(midX, rect.bottom - 5), tipsPaint);

    midX = rrect.left + rect.width / 2 - 4;
    canvas.drawLine(
        Offset(midX, rect.top + 5), Offset(midX, rect.bottom - 5), tipsPaint);
    midX = rrect.left + rect.width / 2 + 4;
    canvas.drawLine(
        Offset(midX, rect.top + 5), Offset(midX, rect.bottom - 5), tipsPaint);
  }
}
