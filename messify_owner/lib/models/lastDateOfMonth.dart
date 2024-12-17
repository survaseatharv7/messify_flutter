class LastDate {
  int month;
  int lastDate = 0;

  LastDate({required this.month}) {
    if (this.month == 1) {
      this.lastDate = 31;
    } else if (this.month == 2) {
      this.lastDate = 28;
    } else if (this.month == 3) {
      this.lastDate = 31;
    } else if (this.month == 4) {
      this.lastDate = 30;
    } else if (this.month == 5) {
      this.lastDate = 31;
    } else if (this.month == 6) {
      this.lastDate = 30;
    } else if (this.month == 7) {
      this.lastDate = 31;
    } else if (this.month == 8) {
      this.lastDate = 31;
    } else if (this.month == 9) {
      this.lastDate = 30;
    } else if (this.month == 10) {
      this.lastDate = 31;
    } else if (this.month == 11) {
      this.lastDate = 30;
    } else {
      this.lastDate = 31;
    }
  }
}
