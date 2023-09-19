class ExtArray extends Array {
  isEmpty() {
    return this.length === 0;
  }
}

var exArray = new ExtArray(0, 1, 2, 3, 4);

exArray[1]; // Should return '1'
exArray.filter((i) => i !== 3); // Should return [0, 1, 2, 4]
exArray.isEmpty(); // Should return false
