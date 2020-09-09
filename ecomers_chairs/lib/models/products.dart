class Product {
  final int id, price;
  final String title, description, image;

  Product({this.id, this.price, this.title, this.description, this.image});
}

List<Product> products = [
  Product(
      id: 0,
      price: 123,
      title: "UNA SILLA",
      image: "assets/img/1.png",
      description: "Sirve para sentarse"),
  Product(
      id: 1,
      price: 343,
      title: "No es SILLA",
      image: "assets/img/2.png",
      description: "Sirve para sentarse"),
  Product(
      id: 2,
      price: 543,
      title: "La misma SILLA",
      image: "assets/img/3.png",
      description: "Sirve para sentarse"),
];
