import 'package:intl/intl.dart';

String formatJoinedDate(dynamic createdAt) {
  if (createdAt == null) return "Unknown";

  try {
    return DateFormat(
      'MMMM yyyy',
      'id_ID',
    ).format(
      DateTime.parse(createdAt.toString()),
    );
  } catch (_) {
    return "Unknown";
  }
}
