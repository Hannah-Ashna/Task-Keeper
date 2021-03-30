class Inventory {
  final int id;
  final int money;
  final int food;
  final int water;
  final int toys;

  // Class Constructor
  Inventory({this.id, this.money, this.food, this.water, this.toys});

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'money' : money,
      'food' : food,
      'water' : water,
      'toys' : toys,
    };
  }
}