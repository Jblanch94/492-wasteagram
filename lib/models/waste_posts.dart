class WastePosts {
  String date;
  int numItems;
  String imageUrl;
  double lat;
  double long;


  WastePosts({this.date, this.numItems, this.imageUrl, this.lat, this.long});

  WastePosts.fromMap(Map<String, dynamic> map) {
        date = map['date'];
        numItems = map['numItems'];
        imageUrl = map['imageUrl'];
        lat = map['lat'];
        long = map['long'];
  }
       

}
