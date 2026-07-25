String getInitials(String name) {
  if (name.trim().isEmpty) return "?";

  final parts = name.trim().split(RegExp(r'\s+'));

  if (parts.length == 1) {
    return parts.first[0].toUpperCase();
  }

  return (parts.first[0] + parts.last[0]).toUpperCase();
}
