import 'dart:convert';
import 'dart:html' as html;
import 'dart:js_interop';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:web/web.dart' as web;

var backendURL = "https://petshopa3051back.builtwithrocket.new/log-inspected-widget";

class CustomWidgetInspector extends StatefulWidget {
  final Widget child;

  const CustomWidgetInspector({Key? key, required this.child})
      : super(key: key);

  @override
  State<CustomWidgetInspector> createState() => _CustomWidgetInspectorState();
}

class _CustomWidgetInspectorState extends State<CustomWidgetInspector> {
  RenderObject? _selectedRenderObject;
  Element? _selectedElement;
  final GlobalKey _ignorePointerKey = GlobalKey();
  final GlobalKey _overlayKey = GlobalKey();
  bool isInspectorEnabled = false;

  void _handleHover(PointerHoverEvent event) {
    if (!isInspectorEnabled) return;

    final RenderObject? userRender =
        _ignorePointerKey.currentContext?.findRenderObject();
    if (userRender == null) return;

    // Find the render object under the pointer
    final RenderObject? target = _findRenderObjectAtPosition(
      event.position,
      userRender,
    );

    if (target != null) {
      // Only update if the selection has changed
      if (_selectedRenderObject != target) {
        final Element? element = _findElementForRenderObject(target);

        setState(() {
          _selectedRenderObject = target;
          _selectedElement = element;
        });
      }
    } else if (_selectedRenderObject != null) {
      // Clear selection if we're not hovering over any widget
      setState(() {
        _selectedRenderObject = null;
        _selectedElement = null;
      });
    }
  }

  @override
  void initState() {
    _listenEvent();
    super.initState();
  }

  _listenEvent() {
    web.window.addEventListener(
        'message',
        (web.Event event) {
          try {
            final messageEvent = event as web.MessageEvent;
            if (messageEvent.data != null) {
              final inspectToggle = messageEvent.data.dartify();
              if (inspectToggle is Map) {
                isInspectorEnabled = inspectToggle['inspectToggle'];
                setState(() {});
              }
            }
          } catch (e) {
            // print('error listening message: $e');
          }
        }.toJS);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Overlay(
        key: _overlayKey,
        initialEntries: [
          OverlayEntry(
            builder: (context) => Stack(
              children: [
                MouseRegion(
                  onHover: isInspectorEnabled ? _handleHover : null,
                  onExit: (_) {
                    if (isInspectorEnabled) {
                      setState(() {
                        _selectedRenderObject = null;
                        _selectedElement = null;
                      });
                    }
                  },
                  child: InkWell(
                    onTap: () {
                      if (_selectedElement != null) {
                        try {
                          var location = _getWidgetLocation(_selectedElement!);
                          var widgetName =
                              _selectedElement!.widget.runtimeType.toString();
                          var parentWidgetName =
                              _getParentWidgetType(_selectedElement!);
                          var properties =
                              _extractWidgetProperties(_selectedElement!);
                          if (location.isNotEmpty && widgetName.isNotEmpty) {
                            var widgetInfo = <String, dynamic>{};
                            widgetInfo['widgetName'] = widgetName;
                            widgetInfo['parentWidgetName'] = parentWidgetName;
                            widgetInfo['location'] = location;
                            widgetInfo['props'] = properties;
                            _sendWidgetInformation(widgetInfo);
                          }
                        } catch (err, st) {
                          print("Error sending widget info: $err || $st");
                        }
                      }
                    },
                    child: IgnorePointer(
                      ignoring: isInspectorEnabled,
                      key: _ignorePointerKey,
                      child: widget.child,
                    ),
                  ),
                ),

                // Overlay showing the selected widget
                if (isInspectorEnabled && _selectedRenderObject != null)
                  IgnorePointer(
                    child: CustomPaint(
                      painter: _InspectorOverlayPainter(
                        selectedRenderObject: _selectedRenderObject!,
                        selectedElement: _selectedElement,
                      ),
                      size: Size.infinite,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  RenderObject? _findRenderObjectAtPosition(
    Offset position,
    RenderObject root,
  ) {
    // Simple hit test to find the smallest render object at the given position
    final List<RenderObject> hits = <RenderObject>[];
    _hitTestHelper(hits, position, root, root.getTransformTo(null));

    if (hits.isEmpty) return null;

    // Sort by size (smallest first)
    hits.sort((RenderObject a, RenderObject b) {
      final Size sizeA = a.semanticBounds.size;
      final Size sizeB = b.semanticBounds.size;
      return (sizeA.width * sizeA.height).compareTo(sizeB.width * sizeB.height);
    });

    return hits.first;
  }

  bool _hitTestHelper(
    List<RenderObject> hits,
    Offset position,
    RenderObject object,
    Matrix4 transform,
  ) {
    bool hit = false;
    final Matrix4? inverse = Matrix4.tryInvert(transform);
    if (inverse == null) {
      return false;
    }
    final Offset localPosition = MatrixUtils.transformPoint(inverse, position);

    // Check children first
    final List<DiagnosticsNode> children = object.debugDescribeChildren();
    for (int i = children.length - 1; i >= 0; i -= 1) {
      final DiagnosticsNode diagnostics = children[i];
      if (diagnostics.style == DiagnosticsTreeStyle.offstage ||
          diagnostics.value is! RenderObject) {
        continue;
      }
      final RenderObject child = diagnostics.value! as RenderObject;
      final Rect? paintClip = object.describeApproximatePaintClip(child);
      if (paintClip != null && !paintClip.contains(localPosition)) {
        continue;
      }

      final Matrix4 childTransform = transform.clone();
      object.applyPaintTransform(child, childTransform);
      if (_hitTestHelper(hits, position, child, childTransform)) {
        hit = true;
      }
    }

    // Check this object
    final Rect bounds = object.semanticBounds;
    if (bounds.contains(localPosition)) {
      hit = true;
      hits.add(object);
    }

    return hit;
  }

  Element? _findElementForRenderObject(RenderObject renderObject) {
    Element? result;
    void visitor(Element element) {
      if (element.renderObject == renderObject) {
        result = element;
        return;
      }
      element.visitChildren(visitor);
    }

    WidgetsBinding.instance.rootElement?.visitChildren(visitor);
    return result;
  }
}

class _InspectorOverlayPainter extends CustomPainter {
  final RenderObject selectedRenderObject;
  final Element? selectedElement;

  _InspectorOverlayPainter({
    required this.selectedRenderObject,
    required this.selectedElement,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (!selectedRenderObject.attached) return;

    final Paint fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color.fromARGB(128, 128, 128, 255);

    final Paint borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = const Color.fromARGB(128, 64, 64, 128);

    // Transform to the coordinate system of the selected object
    final Matrix4 transform = selectedRenderObject.getTransformTo(null);
    final Rect bounds = selectedRenderObject.semanticBounds;

    canvas.save();
    canvas.transform(transform.storage);
    canvas.drawRect(bounds.deflate(0.5), fillPaint);
    canvas.drawRect(bounds.deflate(0.5), borderPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _InspectorOverlayPainter oldDelegate) {
    return selectedRenderObject != oldDelegate.selectedRenderObject ||
        selectedElement != oldDelegate.selectedElement;
  }
}

String _getParentWidgetType(Element element) {
  Element? parent;
  element.visitAncestorElements((Element ancestor) {
    parent = ancestor;
    return false;
  });
  return parent?.widget.runtimeType.toString() ?? 'None';
}

String _getWidgetLocation(Element element) {
  const wrapperWidgetTypeNames = {
    'Obx',
    'GetX',
    'GetBuilder',
    'Observer',
    'Consumer',
    'Provider',
    'Builder',
    'BlocBuilder',
    'BlocListener',
    'BlocProvider',
    'Selector',
    'ValueListenableBuilder',
    'AnimatedBuilder',
    'StreamBuilder',
    'FutureBuilder',
    'SizedBox',
    'Positioned',
    'Center',
    'Expanded',
  };
  String widgetTypeName =
      element.widget.runtimeType.toString().split('<').first;
  if (wrapperWidgetTypeNames.contains(widgetTypeName)) {
    Element? childElement;
    element.visitChildren((child) {
      childElement ??= child;
    });
    if (childElement != null) {
      return _getWidgetLocation(childElement!);
    }
  }

  String? location;

  void check(Element e) {
    DiagnosticsNode node = e.toDiagnosticsNode();
    var delegate = InspectorSerializationDelegate(
      service: WidgetInspectorService.instance,
      summaryTree: true,
      subtreeDepth: 1,
      includeProperties: true,
      expandPropertyValues: true,
    );
    final Map<String, Object?> json = node.toJsonMap(delegate);
    if (json.containsKey('creationLocation')) {
      final Map creationLocation = json['creationLocation'] as Map;
      final String filePath = creationLocation['file']?.toString() ?? '';
      if (filePath.isNotEmpty &&
          !filePath.contains('/packages/flutter') &&
          !filePath.contains('pub.dev') &&
          !filePath.contains('/custom') &&
          !filePath.contains('/common')) {
        final String fileName = filePath.split("/").last;
        final String line = creationLocation['line']?.toString() ?? '0';
        final String column = creationLocation['column']?.toString() ?? '0';
        location = '$filePath:$line:$column';
      }
    }
  }

  check(element);
  if (location != null) return location!;
  element.visitAncestorElements((Element ancestor) {
    check(ancestor);
    return location == null;
  });
  return location ?? '';
}

Map<String, dynamic> _extractWidgetProperties(Element element) {
  final Map<String, dynamic> properties = {};
  final Widget currentWidget = element.widget;

  // List of wrapper widget type names (as strings) that require checking their immediate child
  const wrapperWidgetTypeNames = {
    'Obx',
    'GetX',
    'GetBuilder',
    'Observer',
    'Consumer',
    'Provider',
    'Builder',
    'BlocBuilder',
    'BlocListener',
    'BlocProvider',
    'Selector',
    'ValueListenableBuilder',
    'AnimatedBuilder',
    'StreamBuilder',
    'FutureBuilder',
    'SizedBox',
    'Positioned',
    'Center',
    'Expanded',
  };

  // If the current widget is a wrapper and has an immediate child, use that child.
  Widget effectiveWidget = currentWidget;
  if (wrapperWidgetTypeNames.contains(currentWidget.runtimeType.toString())) {
    // This finds only immediate child.
    Widget? immediateChild;
    element.visitChildElements((Element child) {
      immediateChild = child.widget;
    });
    if (immediateChild != null) {
      effectiveWidget = immediateChild!;
    }
  }

  // Check if the effective widget is a Text.
  if (effectiveWidget is Text) {
    properties['type'] = effectiveWidget.runtimeType.toString();
    properties['key'] = effectiveWidget.key?.toString() ?? 'null';
    properties['text'] = effectiveWidget.data;
    var fontFamilyVal = effectiveWidget.style?.fontFamily?.toString() ?? 'null';
    final textStyle = {
      'color': effectiveWidget.style?.color != null
          ? colorToHex(effectiveWidget.style!.color!).toString()
          : 'null',
      'fontSize': effectiveWidget.style?.fontSize != null
          ? effectiveWidget.style!.fontSize!.round().toString()
          : 'null',
      'backgroundColor': effectiveWidget.style?.backgroundColor != null
          ? colorToHex(effectiveWidget.style!.backgroundColor!).toString()
          : 'null',
      'fontWeight': effectiveWidget.style?.fontWeight?.toString() ?? 'null',
      'fontStyle': effectiveWidget.style?.fontStyle?.toString() ?? 'null',
      'fontFamily':
          fontFamilyVal == 'null' ? fontFamilyVal : "'$fontFamilyVal'",
      'letterSpacing':
          effectiveWidget.style?.letterSpacing?.toString() ?? 'null',
      'wordSpacing': effectiveWidget.style?.wordSpacing?.toString() ?? 'null',
      'textBaseline': effectiveWidget.style?.textBaseline?.toString() ?? 'null',
      'height': effectiveWidget.style?.height?.toString() ?? 'null',
      'overflow': effectiveWidget.style?.overflow?.toString() ?? 'null',
    };
    properties['style'] = textStyle;
    properties['textAlign'] = effectiveWidget.textAlign?.toString() ?? 'null';
    return properties;
  }

  const containerWrapperTypeNames = {
    'LimitedBox',
    'Align',
    'Padding',
    'ColoredBox',
    'ClipPath',
    'DecoratedBox',
    'ConstrainedBox',
    'Transform',
  };

  Container? containerConfig; // declared outside the if block
  if (containerWrapperTypeNames
      .contains(currentWidget.runtimeType.toString())) {
    element.visitAncestorElements((Element ancestor) {
      if (ancestor.widget is Container) {
        containerConfig = ancestor.widget as Container;
        return false; // Stop when found.
      }
      return true;
    });
    if (containerConfig != null) {
      effectiveWidget = containerConfig!;
    }
  }

  final Widget containerWidget = containerConfig ?? effectiveWidget;
  properties['type'] = containerWidget.runtimeType.toString();
  properties['key'] = containerWidget.key?.toString() ?? 'null';
  if (containerWidget is Container) {
    properties['color'] = containerWidget.color != null
        ? colorToHex(containerWidget.color!)
        : "null";
    properties['width'] =
        containerWidget.constraints?.maxWidth.toString() ?? 'null';
    properties['height'] =
        containerWidget.constraints?.maxHeight.toString() ?? 'null';
    properties['padding'] = containerWidget.padding?.toString() ?? 'null';
    properties['margin'] = containerWidget.margin?.toString() ?? 'null';
    if (containerWidget.decoration is BoxDecoration) {
      final boxDecoration = containerWidget.decoration as BoxDecoration;
      final decoration = {
        'color': boxDecoration.color != null
            ? colorToHex(boxDecoration.color!)
            : "null",
        'border': boxDecoration.border.toString(),
        'borderRadius': boxDecoration.borderRadius.toString(),
        'boxShadow': boxDecoration.boxShadow.toString(),
        'gradient': boxDecoration.gradient.toString(),
        'image': boxDecoration.image.toString(),
        'shape': boxDecoration.shape.toString(),
      };
      properties['decoration'] = decoration;
    }
    properties['alignment'] = containerWidget.alignment?.toString() ?? 'null';
  }

  return properties;
}

String colorToHex(Color color) {
  var alphaColor =
      (color.a * 255).round().toRadixString(16).padLeft(2, '0').toUpperCase();
  var redColor =
      (color.r * 255).round().toRadixString(16).padLeft(2, '0').toUpperCase();
  var greenColor =
      (color.g * 255).round().toRadixString(16).padLeft(2, '0').toUpperCase();
  var blueColor =
      (color.b * 255).round().toRadixString(16).padLeft(2, '0').toUpperCase();
  return '0X$alphaColor$redColor$greenColor$blueColor';
}

void _sendWidgetInformation(Map<String, dynamic> widgetInfo) {
  try {
    final payload = widgetInfo;

    final jsonData = jsonEncode(payload);
    final request = html.HttpRequest();
    request.open('POST', backendURL, async: true);
    request.setRequestHeader('Content-Type', 'application/json');

    request.onReadyStateChange.listen((_) {
      if (request.readyState == html.HttpRequest.DONE) {
        if (request.status == 200) {
          print('Successfully reported widgetInfo');
        } else {
          print('Error reporting widget information');
        }
      }
    });

    request.onError.listen((event) {
      print('Failed to send widget information');
    });

    request.send(jsonData);
  } catch (e) {
    print('Exception while reporting overflow error: $e');
  }
}
  