var object = { type: "object" };
var array = ["type", "array"];
var string = "string";
var number = 99;
var regex = /regex/g;

console.log(typeof object); // object
console.log(typeof array); // object
console.log(typeof string); // string
console.log(typeof number); // number
console.log(typeof regex); // object

console.log(Object.prototype.toString.call(object)); // [object Object]
console.log(Object.prototype.toString.call(array)); // [object Array]
console.log(Object.prototype.toString.call(string)); // [object String]
console.log(Object.prototype.toString.call(number)); // [object Number]
console.log(Object.prototype.toString.call(regex)); // [object RegExp]
