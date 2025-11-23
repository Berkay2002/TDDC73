import 'package:flutter/rendering.dart';

/// Shared intrinsic size calculation utilities for stack-like components.
///
/// These helpers eliminate code duplication across VStack and ZStack by
/// providing common intrinsic size computation logic for components that
/// use ContainerRenderObjectMixin.

/// Computes the maximum intrinsic width from a chain of children.
///
/// Iterates through all children linked via ContainerBoxParentData and
/// returns the maximum intrinsic width among them.
double computeMaxIntrinsicWidthFromChildren(
  RenderBox? firstChild,
  double height,
) {
  double width = 0.0;
  RenderBox? child = firstChild;
  while (child != null) {
    final childParentData =
        child.parentData! as ContainerBoxParentData<RenderBox>;
    final childWidth = child.getMaxIntrinsicWidth(height);
    width = width > childWidth ? width : childWidth;
    child = childParentData.nextSibling;
  }
  return width;
}

/// Computes the minimum intrinsic width from a chain of children.
///
/// Iterates through all children linked via ContainerBoxParentData and
/// returns the maximum minimum intrinsic width among them.
double computeMinIntrinsicWidthFromChildren(
  RenderBox? firstChild,
  double height,
) {
  double width = 0.0;
  RenderBox? child = firstChild;
  while (child != null) {
    final childParentData =
        child.parentData! as ContainerBoxParentData<RenderBox>;
    final childWidth = child.getMinIntrinsicWidth(height);
    width = width > childWidth ? width : childWidth;
    child = childParentData.nextSibling;
  }
  return width;
}

/// Computes the maximum intrinsic height from a chain of children.
///
/// Iterates through all children linked via ContainerBoxParentData and
/// returns the maximum intrinsic height among them.
double computeMaxIntrinsicHeightFromChildren(
  RenderBox? firstChild,
  double width,
) {
  double height = 0.0;
  RenderBox? child = firstChild;
  while (child != null) {
    final childParentData =
        child.parentData! as ContainerBoxParentData<RenderBox>;
    final childHeight = child.getMaxIntrinsicHeight(width);
    height = height > childHeight ? height : childHeight;
    child = childParentData.nextSibling;
  }
  return height;
}

/// Computes the minimum intrinsic height from a chain of children.
///
/// Iterates through all children linked via ContainerBoxParentData and
/// returns the maximum minimum intrinsic height among them.
double computeMinIntrinsicHeightFromChildren(
  RenderBox? firstChild,
  double width,
) {
  double height = 0.0;
  RenderBox? child = firstChild;
  while (child != null) {
    final childParentData =
        child.parentData! as ContainerBoxParentData<RenderBox>;
    final childHeight = child.getMinIntrinsicHeight(width);
    height = height > childHeight ? height : childHeight;
    child = childParentData.nextSibling;
  }
  return height;
}
