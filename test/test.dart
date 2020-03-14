import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/models/waste_posts.dart';
import 'package:wasteagram/models/waste_posts_services.dart';

void main() {
  test('Post created from map should have correct values', () {
    const date = 'Friday, Mar. 13';
    const numItems = 6;
    const imageUrl = 'example.com';
    const lat = 1.0;
    const long = 2.0;

    final foodWastePosts = WastePosts.fromMap({
      'date': date,
      'numItems': numItems,
      'imageUrl': imageUrl,
      'lat': lat,
      'long': long,
    });

    expect(foodWastePosts.date, date);
    expect(foodWastePosts.numItems, numItems);
    expect(foodWastePosts.imageUrl, imageUrl);
    expect(foodWastePosts.lat, lat);
    expect(foodWastePosts.long, long);
  });

  test('Properly formats the date for readability', () {
    const date = 'Friday, Mar. 13';

    final services = WastePostServices();
    final dateServices = services.getCurrentDate();

    expect(dateServices, date);

  });

}
