class Inventory {
  final int id;
  final int money;
  final int food;
  final int water;
  final int toys;
  final String login;

  // Class Constructor
  Inventory({this.id, this.money, this.food, this.water, this.toys, this.login});

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'money' : money,
      'food' : food,
      'water' : water,
      'toys' : toys,
      'login' : login,
    };
  }
}