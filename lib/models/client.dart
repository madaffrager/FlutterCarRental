class Locataire {
  String id;
  String name;
  String dob;
  String cin;
  String permis;
  String datelivr;
  String passeport;
  String adresse;
  String mobile;
  bool second;
  String sname = "";
  String sdob = "";
  String scin = "";
  String spermis = "";
  String cacher = "";
  Locataire({
    required this.id,
    required this.name,
    required this.dob,
    required this.cin,
    required this.permis,
    required this.datelivr,
    required this.passeport,
    required this.adresse,
    required this.mobile,
    required this.second,
  });

  static Locataire fromJson(Map<String, dynamic>? dataSnapshot) {
    return new Locataire(
        id: dataSnapshot!['id'],
        name: dataSnapshot!['name'],
        dob: dataSnapshot['dob'],
        cin: dataSnapshot['cin'],
        permis: dataSnapshot['permis'],
        datelivr: dataSnapshot['datelivr'],
        passeport: dataSnapshot['passeport'],
        adresse: dataSnapshot['adresse'],
        mobile: dataSnapshot['mobile'],
        second: dataSnapshot['second']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['dob'] = this.dob;
    data['cin'] = this.cin;
    data['permis'] = this.permis;
    data['datelivr'] = this.datelivr;
    data['passeport'] = this.passeport;
    data['adresse'] = this.adresse;
    data['mobile'] = this.mobile;

    return data;
  }
}
