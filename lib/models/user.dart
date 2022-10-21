class ClientModel {
  String name;
  String uid;
  String agence;
  String adresse;
  String mobile1;
  String mobile2;
  String mobile3;
  String fixe;
  String rcnum;
  String irnum;
  String ifnum;
  String icenum;
  String cnssnum;
  String logo;
  String cacher;
  int nbcars;

  String getNamme() {
    return name;
  }

  ClientModel(
      {required this.name,
      required this.uid,
      required this.agence,
      required this.adresse,
      required this.mobile1,
      required this.mobile2,
      required this.mobile3,
      required this.fixe,
      required this.rcnum,
      required this.irnum,
      required this.ifnum,
      required this.icenum,
      required this.cnssnum,
      required this.logo,
      required this.cacher,
      required this.nbcars});

  static ClientModel fromJson(Map<String, dynamic> dataSnapshot) {
    return new ClientModel(
      name: dataSnapshot["name"],
      uid: dataSnapshot["id"],
      agence: dataSnapshot["agence"],
      adresse: dataSnapshot["adresse"],
      mobile1: dataSnapshot["mobile1"],
      mobile2: dataSnapshot["mobile2"],
      mobile3: dataSnapshot["mobile3"],
      fixe: dataSnapshot["fixe"],
      rcnum: dataSnapshot["rcnum"],
      irnum: dataSnapshot["irnum"],
      ifnum: dataSnapshot["ifnum"],
      icenum: dataSnapshot["icenum"],
      cnssnum: dataSnapshot["cnssnum"],
      logo: dataSnapshot["logo"],
      cacher: dataSnapshot["cacher"],
      nbcars: dataSnapshot["nbcars"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['uid'] = this.uid;
    data['agence'] = this.agence;
    data['adresse'] = this.adresse;
    data['mobile1'] = this.mobile1;
    data['mobile2'] = this.mobile2;
    data['mobile'] = this.mobile3;
    data['rcnum'] = this.rcnum;
    data['irnum'] = this.irnum;
    data['ifnum'] = this.ifnum;
    data['icenum'] = this.icenum;
    data['cnssnum'] = this.cnssnum;
    data['logo'] = this.logo;
    data['cacher'] = this.cacher;
    data['nbcars'] = this.nbcars;
    return data;
  }
}
