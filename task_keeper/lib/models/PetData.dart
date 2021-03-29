class PetData{
  final int id;
  final int hunger;
  final int thirst;
  final int happiness;

  // Class Constructor
  PetData({this.id, this.hunger, this.thirst, this.happiness});

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'hunger' : hunger,
      'thirst' : thirst,
      'happiness' : happiness,
    };
  }
}