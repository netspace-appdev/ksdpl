/*
Future<void> handleRemindersFromApi(List<dynamic> dataFromApi) async {
  for (var item in dataFromApi) {
    Reminder reminder = Reminder.fromJson(item);

    // Only schedule future reminders
    if (reminder.reminderDateTime.isAfter(DateTime.now())) {
      await NotificationHelper.scheduleReminder(
        id: reminder.id,
        title: reminder.title,
        body: reminder.body,
        scheduledDateTime: reminder.reminderDateTime,
      );
    } else {
      print('⏰ Skipped past reminder: ${reminder.title}');
    }
  }
}
*/
