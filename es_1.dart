// Dart has a class named Comparable, which is used by the the sort method of List to sort its elements.
// Add a weight field to the provided Dog class
// Then make Dog implement Comparable so that when you have a list of Dog objects,
// calling sort on the list will sort them by weight.

// abstract class Animal {
//   bool isAlive = true;
//   void eat();

//   @override
//   String toString() {
//     return "I'm a $runtimeType";
//   }
// }

// class Dog extends Animal {
//   @override
//   void eat() {
//     print('Munch munch');
//   }

//   void bark() {
//     print('Bau bau');
//   }
// }

abstract class Animal {
  bool isAlive = true;
  void eat();

  @override
  String toString() {
    return "I'm a $runtimeType";
  }
}

class Dog extends Animal implements Comparable {
  int weight;

  Dog(this.weight);

  @override
  void eat() {
    print('Munch munch');
  }

  void bark() {
    print('Bau bau');
  }

  @override
  int compareTo(other) {
    return this.weight - (other as Dog).weight;
  }
}
