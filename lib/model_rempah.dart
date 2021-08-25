class   ModelRempah {
  int? _id;
  String? _namaRempah;
  String? _namaIlmiah;
  String? _gambar;
  String? _ikhtisar;
  String? _morfologi;
  String? _ciri;
  String? _khasiat;
  String? _kegunaan;
  String? _potensi;
  String? _referensiMorfologi;
  String? _referensiCiri;
  String? _referensiKhasiat;
  String? _referensiKegunaan;
  String? _referensiPotensi;

  int? get id => _id;
  String? get namaRempah => _namaRempah;
  String? get namaIlmiah => _namaIlmiah;
  String? get gambar => _gambar;
  String? get ikhtisar => _ikhtisar;
  String? get morfologi => _morfologi;
  String? get ciri => _ciri;
  String? get khasiat => _khasiat;
  String? get kegunaan => _kegunaan;
  String? get potensi => _potensi;
  String? get referensiMorfologi => _referensiMorfologi;
  String? get referensiCiri => _referensiCiri;
  String? get referensiKhasiat => _referensiKhasiat;
  String? get referensiKegunaan => _referensiKegunaan;
  String? get referensiPotensi => _referensiPotensi;

  ModelRempah({
      int? id, 
      String? namaRempah, 
      String? namaIlmiah, 
      String? gambar, 
      String? ikhtisar, 
      String? morfologi, 
      String? ciri, 
      String? khasiat, 
      String? kegunaan, 
      String? potensi, 
      String? referensiMorfologi, 
      String? referensiCiri, 
      String? referensiKhasiat, 
      String? referensiKegunaan, 
      String? referensiPotensi}){
    _id = id;
    _namaRempah = namaRempah;
    _namaIlmiah = namaIlmiah;
    _gambar = gambar;
    _ikhtisar = ikhtisar;
    _morfologi = morfologi;
    _ciri = ciri;
    _khasiat = khasiat;
    _kegunaan = kegunaan;
    _potensi = potensi;
    _referensiMorfologi = referensiMorfologi;
    _referensiCiri = referensiCiri;
    _referensiKhasiat = referensiKhasiat;
    _referensiKegunaan = referensiKegunaan;
    _referensiPotensi = referensiPotensi;
}

  ModelRempah.fromJson(dynamic json) {
    _id = json['id'];
    _namaRempah = json['nama_rempah'];
    _namaIlmiah = json['nama_ilmiah'];
    _gambar = json['gambar'];
    _ikhtisar = json['ikhtisar'];
    _morfologi = json['morfologi'];
    _ciri = json['ciri'];
    _khasiat = json['khasiat'];
    _kegunaan = json['kegunaan'];
    _potensi = json['potensi'];
    _referensiMorfologi = json['referensi_morfologi'];
    _referensiCiri = json['referensi_ciri'];
    _referensiKhasiat = json['referensi_khasiat'];
    _referensiKegunaan = json['referensi_kegunaan'];
    _referensiPotensi = json['referensi_potensi'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['nama_rempah'] = _namaRempah;
    map['nama_ilmiah'] = _namaIlmiah;
    map['gambar'] = _gambar;
    map['ikhtisar'] = _ikhtisar;
    map['morfologi'] = _morfologi;
    map['ciri'] = _ciri;
    map['khasiat'] = _khasiat;
    map['kegunaan'] = _kegunaan;
    map['potensi'] = _potensi;
    map['referensi_morfologi'] = _referensiMorfologi;
    map['referensi_ciri'] = _referensiCiri;
    map['referensi_khasiat'] = _referensiKhasiat;
    map['referensi_kegunaan'] = _referensiKegunaan;
    map['referensi_potensi'] = _referensiPotensi;
    return map;
  }

}