import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget? tabletBody;
  final Widget? desktopBody;

  // Screen size breakpoints
  static const int mobileBreakpoint = 600;
  static const int tabletBreakpoint = 1200;

  const ResponsiveLayout({
    Key? key,
    required this.mobileBody,
    this.tabletBody,
    this.desktopBody,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileBreakpoint;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileBreakpoint &&
      MediaQuery.of(context).size.width < tabletBreakpoint;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletBreakpoint;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    // If width is more than tabletBreakpoint, show desktop layout
    if (size.width >= tabletBreakpoint && desktopBody != null) {
      return desktopBody!;
    }

    // If width is more than mobileBreakpoint but less than tabletBreakpoint, show tablet layout
    // If tablet layout is not provided, fallback to desktop layout if available, else mobile layout
    if (size.width >= mobileBreakpoint) {
      return tabletBody ?? desktopBody ?? mobileBody;
    }

    // By default show mobile layout
    return mobileBody;
  }
}
