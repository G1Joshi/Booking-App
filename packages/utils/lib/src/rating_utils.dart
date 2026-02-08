class Grade {
  static String getGrade(num rating) {
    if (rating > 4.5) return 'Excellent';
    if (rating > 4) return 'Very Good';
    if (rating > 3) return 'Good';
    if (rating > 2) return 'Fair';
    return 'Poor';
  }
}
