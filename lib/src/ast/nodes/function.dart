import 'package:flutter/widgets.dart';

import '../../render/layout/line.dart';
import '../options.dart';
import '../spacing.dart';
import '../syntax_tree.dart';

class FunctionNode extends SlotableNode {
  final EquationRowNode functionName;
  final EquationRowNode argument;

  FunctionNode({
    @required this.functionName,
    @required this.argument,
  })  : assert(functionName != null),
        assert(argument != null);

  @override
  List<BuildResult> buildSlotableWidget(
          Options options, List<BuildResult> childBuildResults) =>
      [
        BuildResult(
            widget: Line(children: [
              LineElement(
                trailingMargin: getSpacingSize(
                        AtomType.op, argument.leftType, options.style)
                    .toLpUnder(options),
                child: childBuildResults[0].widget,
              ),
              LineElement(
                trailingMargin: 0.0,
                child: childBuildResults[1].widget,
              ),
            ]),
            options: options,
            italic: 0.0)
      ];

  @override
  List<Options> computeChildOptions(Options options) =>
      List.filled(2, options, growable: false);

  @override
  List<EquationRowNode> computeChildren() => [functionName, argument];

  @override
  AtomType get leftType => AtomType.op;

  @override
  AtomType get rightType => argument.rightType;

  @override
  bool shouldRebuildWidget(Options oldOptions, Options newOptions) => false;

  @override
  ParentableNode<EquationRowNode> updateChildren(
          List<EquationRowNode> newChildren) =>
      FunctionNode(functionName: newChildren[0], argument: newChildren[2]);
}
