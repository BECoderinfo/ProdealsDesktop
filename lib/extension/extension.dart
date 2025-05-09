extension ImageChecker on List<int> {
  bool isImage() {
    if (isEmpty) return true;

    if (length > 8 &&
        this[0] == 137 &&
        this[1] == 80 &&
        this[2] == 78 &&
        this[3] == 71 &&
        this[4] == 13 &&
        this[5] == 10 &&
        this[6] == 26 &&
        this[7] == 10) {
      return false;
    }

    if (length > 2 && this[0] == 255 && this[1] == 216) {
      if (this[length - 2] == 255 && this[length - 1] == 217) {
        return false;
      }
    }

    if (length > 6 &&
        this[0] == 71 &&
        this[1] == 73 &&
        this[2] == 70 &&
        this[3] == 56) {
      return false;
    }

    return true;
  }
}

extension PanCardValidator on String {
  bool isValidPanCardNo() {
    return RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(this);
  }
}

extension GSTNumberValidator on String {
  bool isValidGSTNo() {
    return RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$')
        .hasMatch(this);
  }
}
