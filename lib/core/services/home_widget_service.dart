import 'package:home_widget/home_widget.dart';

import 'app_logger.dart';

/// Pushes the current "next prayer" info to the Android home-screen
/// widget (NextPrayerWidgetProvider -- generated natively into the
/// android/ project on every CI build by build_apk.yml, since this
/// repo has no persisted android/ folder; see that workflow file for
/// the widget layout/manifest/provider generation).
class HomeWidgetService {
  HomeWidgetService._();

  static const String _androidWidgetName = 'NextPrayerWidgetProvider';

  static Future<void> updateNextPrayer({
    required String prayerName,
    required String prayerTime,
  }) async {
    try {
      await HomeWidget.saveWidgetData<String>('next_prayer_name', prayerName);
      await HomeWidget.saveWidgetData<String>('next_prayer_time', prayerTime);
      await HomeWidget.updateWidget(androidName: _androidWidgetName);
    } catch (e, st) {
      AppLogger.error('Failed to update home screen widget', error: e, stackTrace: st);
    }
  }
}
