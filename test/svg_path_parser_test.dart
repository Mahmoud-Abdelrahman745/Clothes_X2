import 'package:flutter_test/flutter_test.dart';
import 'package:smartwardrobe/core/icons/svg_path_parser.dart';

void main() {
  group('SvgPathParser', () {
    test('parses absolute and relative commands', () {
      final path = parseSvgPath('M10 10 L20 20 Z');
      expect(path.getBounds().left, closeTo(10, 0.01));
      expect(path.getBounds().top, closeTo(10, 0.01));
      expect(path.getBounds().right, closeTo(20, 0.01));
      expect(path.getBounds().bottom, closeTo(20, 0.01));
    });

    test('treats repeated coordinate pairs as implicit lineto', () {
      // moveto consumes the first pair, the rest become linetos.
      final path = parseSvgPath('M0 0 10 0 10 10');
      expect(path.getBounds().right, closeTo(10, 0.01));
      expect(path.getBounds().bottom, closeTo(10, 0.01));
    });

    test('draws a full circle from two semicircular arcs', () {
      final path = parseSvgPath('M22 12a10 10 0 1 1-20 0 10 10 0 0 1 20 0z');
      final b = path.getBounds();
      expect(b.left, closeTo(2, 0.2));
      expect(b.top, closeTo(2, 0.2));
      expect(b.right, closeTo(22, 0.2));
      expect(b.bottom, closeTo(22, 0.2));
    });

    test('arc sweep direction is respected', () {
      // Sweep 1 travels clockwise in the y-down icon grid: (22,12) -> (12,22).
      final cw = parseSvgPath('M22 12a10 10 0 0 1-20 0').getBounds();
      // Sweep 0 travels the other way: through (12,2).
      final ccw = parseSvgPath('M22 12a10 10 0 0 0-20 0').getBounds();
      expect(cw.top, closeTo(12, 0.2));
      expect(cw.bottom, closeTo(22, 0.2));
      expect(ccw.top, closeTo(2, 0.2));
      expect(ccw.bottom, closeTo(12, 0.2));
    });

    test('scales radii up when the chord exceeds them', () {
      // A 20 unit chord with r=4 must be scaled to r=10 to be drawable.
      final b = parseSvgPath('M2 12a4 4 0 0 1 20 0').getBounds();
      expect(b.left, closeTo(2, 0.5));
      expect(b.right, closeTo(22, 0.5));
    });

    test('parses every command letter', () {
      const d =
          'M0 0 H10 V10 C12 10 14 12 14 14 S16 18 18 18 '
          'Q20 18 20 20 T24 20 A5 5 0 0 1 30 20 Z';
      expect(() => parseSvgPath(d), returnsNormally);
    });

    test('rejects data that does not start with a command', () {
      expect(() => parseSvgPath('10 10 L20 20'), throwsFormatException);
    });
  });
}
