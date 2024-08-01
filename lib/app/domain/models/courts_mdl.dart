class Court {
  int id;
  String name;
  String location;
  String type;
  int price;
  bool available;
  String initAvailable;
  String endAvailable;
  String percentRain;
  Court({
    required this.id,
    required this.name,
    required this.location,
    required this.type,
    required this.price,
    required this.available,
    required this.initAvailable,
    required this.endAvailable,
    required this.percentRain,
  });

  factory Court.empty() {
    return Court(
      id: -1,
      name: "",
      location: "",
      type: "",
      price: 0,
      available: false,
      initAvailable: "",
      endAvailable: "",
      percentRain: "",
    );
  }
}
