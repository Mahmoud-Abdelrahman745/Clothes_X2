import 'dart:math' as math;
import 'dart:ui';

/// Minimal SVG path-data parser covering the commands emitted by icon sets:
/// `M m L l H h V v C c S s Q q T t A a Z z`.
///
/// Absolute and relative forms are both supported; arcs are converted to cubic
/// beziers so the result can be stroked with [Path.draw].
class SvgPathParser {
  SvgPathParser(this.d);

  final String d;

  late final Path path = _parse();

  Path _parse() {
    final result = Path();
    final tokens = _tokenize();
    var i = 0;

    var current = Offset.zero;
    var start = Offset.zero;
    Offset? lastCubicControl;
    Offset? lastQuadControl;

    void moveTo(Offset p) {
      current = p;
      start = p;
      result.moveTo(p.dx, p.dy);
      lastCubicControl = null;
      lastQuadControl = null;
    }

    void lineTo(Offset p) {
      current = p;
      result.lineTo(p.dx, p.dy);
      lastCubicControl = null;
      lastQuadControl = null;
    }

    void cubicTo(Offset c1, Offset c2, Offset p) {
      current = p;
      result.cubicTo(c1.dx, c1.dy, c2.dx, c2.dy, p.dx, p.dy);
      lastCubicControl = c2;
      lastQuadControl = null;
    }

    void quadTo(Offset c, Offset p) {
      current = p;
      result.quadraticBezierTo(c.dx, c.dy, p.dx, p.dy);
      lastQuadControl = c;
      lastCubicControl = null;
    }

    void close() {
      result.close();
      current = start;
      lastCubicControl = null;
      lastQuadControl = null;
    }

    double num() {
      if (i >= tokens.length) {
        throw FormatException('Unexpected end of path data in "$d"');
      }
      final t = tokens[i++];
      final v = double.tryParse(t);
      if (v == null) throw FormatException('Expected number, got "$t" in "$d"');
      return v;
    }

    bool hasCommand() =>
        i < tokens.length &&
        tokens[i].length == 1 &&
        _commands.contains(tokens[i]);

    while (i < tokens.length) {
      if (hasCommand()) {
        final cmd = tokens[i++];
        _run(
          cmd: cmd,
          num: num,
          moveTo: moveTo,
          lineTo: lineTo,
          cubicTo: cubicTo,
          quadTo: quadTo,
          close: close,
          current: () => current,
          lastCubicControl: () => lastCubicControl,
          lastQuadControl: () => lastQuadControl,
        );
        continue;
      }

      // Implicit repetition: after the first pair, M behaves as L and m as l.
      final implicit = _lastCommand;
      if (implicit == null) {
        throw FormatException('Path data must start with a command: "$d"');
      }
      if (implicit == 'M') _lastCommand = 'L';
      if (implicit == 'm') _lastCommand = 'l';
      _run(
        cmd: _lastCommand!,
        num: num,
        moveTo: moveTo,
        lineTo: lineTo,
        cubicTo: cubicTo,
        quadTo: quadTo,
        close: close,
        current: () => current,
        lastCubicControl: () => lastCubicControl,
        lastQuadControl: () => lastQuadControl,
      );
    }

    return result;
  }

  String? _lastCommand;

  void _run({
    required String cmd,
    required double Function() num,
    required void Function(Offset) moveTo,
    required void Function(Offset) lineTo,
    required void Function(Offset, Offset, Offset) cubicTo,
    required void Function(Offset, Offset) quadTo,
    required void Function() close,
    required Offset Function() current,
    required Offset? Function() lastCubicControl,
    required Offset? Function() lastQuadControl,
  }) {
    _lastCommand = cmd;
    final c = current();

    switch (cmd) {
      case 'M':
        moveTo(Offset(num(), num()));
      case 'm':
        moveTo(c + Offset(num(), num()));

      case 'L':
        lineTo(Offset(num(), num()));
      case 'l':
        lineTo(c + Offset(num(), num()));

      case 'H':
        lineTo(Offset(num(), c.dy));
      case 'h':
        lineTo(Offset(c.dx + num(), c.dy));

      case 'V':
        lineTo(Offset(c.dx, num()));
      case 'v':
        lineTo(Offset(c.dx, c.dy + num()));

      case 'C':
        cubicTo(
          Offset(num(), num()),
          Offset(num(), num()),
          Offset(num(), num()),
        );
      case 'c':
        final p1 = c + Offset(num(), num());
        final p2 = c + Offset(num(), num());
        final p3 = c + Offset(num(), num());
        cubicTo(p1, p2, p3);

      case 'S':
        final p1 = _reflect(lastCubicControl(), c);
        final p2 = Offset(num(), num());
        final p3 = Offset(num(), num());
        cubicTo(p1, p2, p3);
      case 's':
        final p1 = _reflect(lastCubicControl(), c);
        final p2 = c + Offset(num(), num());
        final p3 = c + Offset(num(), num());
        cubicTo(p1, p2, p3);

      case 'Q':
        quadTo(Offset(num(), num()), Offset(num(), num()));
      case 'q':
        final q = c + Offset(num(), num());
        final p = c + Offset(num(), num());
        quadTo(q, p);

      case 'T':
        final q = _reflect(lastQuadControl(), c);
        final p = Offset(num(), num());
        quadTo(q, p);
      case 't':
        final q = _reflect(lastQuadControl(), c);
        final p = c + Offset(num(), num());
        quadTo(q, p);

      case 'A':
        _arc(
          current: c,
          rx: num(),
          ry: num(),
          rotation: num(),
          largeArc: num(),
          sweep: num(),
          target: Offset(num(), num()),
          out: (from, via1, via2, to) => cubicTo(via1, via2, to),
        );
      case 'a':
        _arc(
          current: c,
          rx: num(),
          ry: num(),
          rotation: num(),
          largeArc: num(),
          sweep: num(),
          target: c + Offset(num(), num()),
          out: (from, via1, via2, to) => cubicTo(via1, via2, to),
        );

      case 'Z':
      case 'z':
        close();
    }
  }

  static Offset _reflect(Offset? control, Offset current) {
    if (control == null) return current;
    return Offset(2 * current.dx - control.dx, 2 * current.dy - control.dy);
  }

  void _arc({
    required Offset current,
    required double rx,
    required double ry,
    required double rotation,
    required double largeArc,
    required double sweep,
    required Offset target,
    required void Function(Offset, Offset, Offset, Offset) out,
  }) {
    if (current == target) return;
    rx = rx.abs();
    ry = ry.abs();
    if (rx == 0 || ry == 0) {
      out(current, current, target, target);
      return;
    }

    final phi = rotation * math.pi / 180;
    final cosPhi = math.cos(phi);
    final sinPhi = math.sin(phi);

    final dx2 = (current.dx - target.dx) / 2;
    final dy2 = (current.dy - target.dy) / 2;
    final x1 = cosPhi * dx2 + sinPhi * dy2;
    final y1 = -sinPhi * dx2 + cosPhi * dy2;

    final lambda = (x1 * x1) / (rx * rx) + (y1 * y1) / (ry * ry);
    if (lambda > 1) {
      final s = math.sqrt(lambda);
      rx *= s;
      ry *= s;
    }

    final sign = (largeArc != sweep) ? 1.0 : -1.0;
    final num = rx * rx * ry * ry - rx * rx * y1 * y1 - ry * ry * x1 * x1;
    final den = rx * rx * y1 * y1 + ry * ry * x1 * x1;
    final co = den == 0 ? 0 : sign * math.sqrt(math.max(0, num / den));

    final cxp = co * (rx * y1) / ry;
    final cyp = co * -(ry * x1) / rx;

    final cx = cosPhi * cxp - sinPhi * cyp + (current.dx + target.dx) / 2;
    final cy = sinPhi * cxp + cosPhi * cyp + (current.dy + target.dy) / 2;

    // Parametric point on the (rotated, translated) ellipse at angle `a`.
    Offset onEllipse(double a) {
      final ex = rx * math.cos(a);
      final ey = ry * math.sin(a);
      return Offset(
        cx + cosPhi * ex - sinPhi * ey,
        cy + sinPhi * ex + cosPhi * ey,
      );
    }

    // First derivative with respect to `a`, used for the cubic control points.
    Offset derivative(double a) {
      final ex = -rx * math.sin(a);
      final ey = ry * math.cos(a);
      return Offset(cosPhi * ex - sinPhi * ey, sinPhi * ex + cosPhi * ey);
    }

    var a0 = math.atan2(current.dy - cy, current.dx - cx);
    final a1 = math.atan2(target.dy - cy, target.dx - cx);

    var delta = a1 - a0;
    if (sweep != 0 && delta < 0) delta += 2 * math.pi;
    if (sweep == 0 && delta > 0) delta -= 2 * math.pi;

    final segments = math.max(1, (delta.abs() / (math.pi / 2)).ceil());
    final step = delta / segments;
    // Control point distance for a circular arc approximated by a cubic.
    final k = 4 / 3 * math.tan(step / 4);

    for (var s = 0; s < segments; s++) {
      final t1 = a0 + step * s;
      final t2 = t1 + step;
      final p1 = onEllipse(t1);
      final p2 = onEllipse(t2);
      final c1 = p1 + derivative(t1) * k;
      final c2 = p2 - derivative(t2) * k;
      out(current, c1, c2, p2);
      current = p2;
    }
  }

  static const _commands = 'MmLlHhVvCcSsQqTtAaZz';

  static final _numberPattern = RegExp(
    r'[-+]?(?:\d*\.\d+|\d+\.?)(?:[eE][-+]?\d+)?',
  );

  List<String> _tokenize() {
    final out = <String>[];
    for (final m in _numberPattern.allMatches(d)) {
      out.add(m.group(0)!);
    }
    // Re-interleave command letters, which the numeric regex skipped.
    final result = <String>[];
    var last = 0;
    for (final m in _numberPattern.allMatches(d)) {
      for (final ch in d.substring(last, m.start).split('')) {
        if (ch.trim().isNotEmpty) result.add(ch);
      }
      result.add(m.group(0)!);
      last = m.end;
    }
    for (final ch in d.substring(last).split('')) {
      if (ch.trim().isNotEmpty) result.add(ch);
    }
    return result;
  }
}

/// Parses [d] into a [Path] positioned on the 24x24 icon grid.
Path parseSvgPath(String d) => SvgPathParser(d).path;
