class CarouselModel {
  String image;

  CarouselModel(this.image);
}

List<CarouselModel> carousels =
    carouselsData.map((item) => CarouselModel(item['image'])).toList();

var carouselsData = [
  {"image": "assets/images/image_slider1.png"},
  {"image": "assets/images/image_slider2.png"},
  {"image": "assets/images/image_slider3.png"},
  {"image": "assets/images/image_slider4.png"},
];
