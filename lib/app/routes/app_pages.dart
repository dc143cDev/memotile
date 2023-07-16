import 'package:get/get.dart';
import 'package:memotile/app/modules/home/views/trash_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/views/memo_detail_view.dart';
import '../modules/home/views/tags_customize_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/theme/bindings/theme_binding.dart';
import '../modules/theme/views/theme_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      transition: Transition.leftToRight,
      binding: HomeBinding(),
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
      name: _Paths.TRASH,
      page: () => TrashView(),
      transition: Transition.downToUp,
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.THEME,
      page: () => const ThemeView(),
      binding: ThemeBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
  ];
}
