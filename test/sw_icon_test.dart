import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:smartwardrobe/core/icons/sw_icon.dart';
import 'package:smartwardrobe/core/icons/svg_path_parser.dart';

void main() {
  List<String> pathsFor(SwIcon icon) => [
    ...SwGlyphPaths.strokesOf(icon),
    ...SwGlyphPaths.fillsOf(icon),
  ];

  Rect unionBounds(SwIcon icon) {
    var l = double.infinity, t = double.infinity;
    var r = -double.infinity, b = -double.infinity;
    for (final d in pathsFor(icon)) {
      final box = parseSvgPath(d).getBounds();
      l = box.left < l ? box.left : l;
      t = box.top < t ? box.top : t;
      r = box.right > r ? box.right : r;
      b = box.bottom > b ? box.bottom : b;
    }
    return Rect.fromLTRB(l, t, r, b);
  }

  group('SwIcon geometry', () {
    for (final icon in SwIcon.values) {
      test('${icon.name} is centred and fits the 24x24 grid', () {
        final paths = pathsFor(icon);
        expect(paths, isNotEmpty, reason: '${icon.name} has no path data');

        for (final d in paths) {
          final box = parseSvgPath(d).getBounds();
          expect(
            box.width > 0.01 || box.height > 0.01,
            isTrue,
            reason: '${icon.name}: "$d" draws nothing',
          );
        }

        final b = unionBounds(icon);
        expect(b.left, greaterThan(0.5), reason: '${icon.name} bleeds left');
        expect(b.top, greaterThan(0.5), reason: '${icon.name} bleeds up');
        expect(b.right, lessThan(23.5), reason: '${icon.name} bleeds right');
        expect(b.bottom, lessThan(23.5), reason: '${icon.name} bleeds down');
        expect(
          b.center.dx,
          closeTo(12, 0.35),
          reason: '${icon.name} is off centre horizontally',
        );
        expect(
          b.longestSide,
          greaterThan(9),
          reason: '${icon.name} is too small',
        );
        // A vertical ellipsis is legitimately narrow; nothing else is.
        if (icon != SwIcon.moreVertical) {
          expect(
            b.shortestSide,
            greaterThan(5),
            reason: '${icon.name} is too thin',
          );
        }
      });
    }
  });

  group('key glyphs', () {
    test('search is a lens plus an off-centre handle', () {
      final lens = parseSvgPath(
        SwGlyphPaths.strokesOf(SwIcon.search)[0],
      ).getBounds();
      expect(lens.width, closeTo(16, 0.2));
      expect(lens.height, closeTo(16, 0.2));
      expect(lens.left, closeTo(3, 0.2));
    });

    test('shirt body is symmetric about the vertical axis', () {
      final b = parseSvgPath(
        SwGlyphPaths.strokesOf(SwIcon.shirt)[0],
      ).getBounds();
      expect(b.center.dx, closeTo(12, 0.1));
      expect(b.left, closeTo(24 - b.right, 0.2));
    });

    test('eye is a wide lens containing a smaller pupil', () {
      final lens = parseSvgPath(
        SwGlyphPaths.strokesOf(SwIcon.eye)[0],
      ).getBounds();
      final pupil = parseSvgPath(
        SwGlyphPaths.strokesOf(SwIcon.eye)[1],
      ).getBounds();
      expect(lens.width, greaterThan(18));
      expect(lens.height, lessThan(15));
      expect(pupil.width, closeTo(6, 0.2));
      expect(pupil.height, closeTo(6, 0.2));
      expect(pupil.center.dx, closeTo(lens.center.dx, 0.1));
    });

    test('circular glyphs all share the same ring', () {
      for (final icon in [
        SwIcon.circleX,
        SwIcon.circleCheck,
        SwIcon.circleInfo,
        SwIcon.clock,
      ]) {
        final b = parseSvgPath(SwGlyphPaths.strokesOf(icon)[0]).getBounds();
        expect(b.left, closeTo(2, 0.2), reason: icon.name);
        expect(b.width, closeTo(20, 0.3), reason: icon.name);
        expect(b.height, closeTo(20, 0.3), reason: icon.name);
      }
    });

    test('moreVertical renders three evenly spaced dots', () {
      final fills = SwGlyphPaths.fillsOf(SwIcon.moreVertical);
      expect(fills.length, 3);
      final ys =
          fills.map((d) => parseSvgPath(d).getBounds().center.dy).toList()
            ..sort();
      expect(ys[0], closeTo(4, 0.2));
      expect(ys[1], closeTo(12, 0.2));
      expect(ys[2], closeTo(20, 0.2));
    });

    test('filled and outlined variants share identical outlines', () {
      final outline = parseSvgPath(
        SwGlyphPaths.strokesOf(SwIcon.heart)[0],
      ).getBounds();
      final filled = parseSvgPath(
        SwGlyphPaths.fillsOf(SwIcon.heartFill)[0],
      ).getBounds();
      expect(filled.left, closeTo(outline.left, 0.01));
      expect(filled.right, closeTo(outline.right, 0.01));
      expect(filled.top, closeTo(outline.top, 0.01));
      expect(filled.bottom, closeTo(outline.bottom, 0.01));
    });
  });
}
