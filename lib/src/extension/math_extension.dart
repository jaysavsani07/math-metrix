extension MathExtension on double {
  double remap(double from1, double to1, double from2, double to2) {
    return (this - from1) / (to1 - from1) * (to2 - from2) + from2;
  }

  double toRange(double maxExtent, double minExtent) {
    double maxScrollAllowed = maxExtent - minExtent;
    return ((maxScrollAllowed - this) / maxScrollAllowed)
        .clamp(0, 1)
        .toDouble();
  }

  double toReverseRange(double maxExtent, double minExtent) {
    return 1 - toRange(maxExtent, minExtent);
  }

  double toElevation(
      double maxExtent, double minExtent, double after, double elevation) {
    if (this < after)
      return 0;
    else
      return elevation * (this - after).toReverseRange(maxExtent, minExtent);
  }

  double toRadius(
      double maxExtent, double minExtent, double after, double radius) {
    if (this < after)
      return 0;
    else
      return radius * (this - after).toReverseRange(maxExtent, minExtent);
  }

  double toTextSize(
      double maxExtent, double minExtent, double from, double to) {
    return this.toRange(maxExtent, minExtent).remap(0, 1, from, to);
  }
}
