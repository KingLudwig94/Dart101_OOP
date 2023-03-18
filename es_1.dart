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
  String toString() {
    return 'Dog($weight)';
  }

  @override
  int compareTo(other) {
    // if (this.weigth < (other as Dog).weigth) {
    //   return -1;
    // } else if (this.weigth > other.weigth) {
    //   return 1;
    // } else {
    //   return 0;
    // }
    return this.weight - (other as Dog).weight;
  }
}

void main(List<String> args) {
  Dog a = Dog(10);
  Dog b = Dog(9);

  if (a.compareTo(b) > 0) {
    print('A è più pesante di B');
  } else if (a.compareTo(b) < 0) {
    print('B è più pesante di A');
  } else {
    print('Pesano uguali');
  }

  List<Dog> list = [a, b];
  list.sort();
  print(list);
}
