class BinData {
  final String address;
  final String collectionDay;
  final String nextGreen;
  final String nextWaste;
  final String nextRecycle;
  final String helpLink;

  BinData(
      {this.address,
      this.collectionDay,
      this.nextGreen,
      this.nextWaste,
      this.nextRecycle,
      this.helpLink});

  factory BinData.fromJson(Map<String, dynamic> json) {
    String helpLink = json['help'];

    if (json['result']['records'].length == 0)
      return new BinData(helpLink: helpLink);

    return BinData(
        address: json['result']['records'][0]['address'],
        collectionDay:
            json['result']['records'][0]['collectionday'].split(" ")[0],
        nextGreen: json['result']['records'][0]['nextgreen'],
        nextWaste: json['result']['records'][0]['nextwaste'],
        nextRecycle: json['result']['records'][0]['nextrecycle'],
        helpLink: helpLink);
  }
}
