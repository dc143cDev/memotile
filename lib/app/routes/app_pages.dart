import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/views/memo_detail_view.dart';
import '../modules/home/views/tags_customize_view.dart';
import '../modules/memo_calendar/bindings/memo_calendar_binding.dart';
import '../modules/memo_calendar/views/memo_calendar_view.dart';
import '../modules/theme/bindings/theme_binding.dart';
import '../modules/theme/views/theme_view.dart';
import '../modules/tile/bindings/tile_binding.dart';
import '../modules/tile/views/tile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      transition: Transition.noTransition,
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.TILE,
      page: () => const TileView(),
      binding: TileBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL,
      page: () => const MemoDetailView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.TAGS,
      page: () => const TagsCustomizeView(),
      transition: Transition.downToUp,
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MEMO_CALENDAR,
      page: () => const MemoCalendarView(),
      binding: MemoCalendarBinding(),
    ),
    GetPage(
      name: _Paths.THEME,
      page: () => const ThemeView(),
      binding: ThemeBinding(),
    ),
  ];
}
