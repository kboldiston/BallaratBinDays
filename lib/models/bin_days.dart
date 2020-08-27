class BinData {
  final String address;
  final String collectionDay;
  final String nextGreen;
  final String nextWaste;
  final String nextRecycle;

  BinData({
    this.address, 
    this.collectionDay, 
    this.nextGreen, 
    this.nextWaste,
    this.nextRecycle
  });

  factory BinData.fromJson(Map<String, dynamic> json) {
    return BinData(
      address: json['result']['records'][0]['address'],
      collectionDay: json['result']['records'][0]['collectionday'],
      nextGreen: json['result']['records'][0]['nextgreen'],
      nextWaste: json['result']['records'][0]['nextwaste'],
      nextRecycle: json['result']['records'][0]['nextrecycle'],
    );
  }
}
