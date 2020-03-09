// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

// List<Post> postFromJson(String str){
//   final data = json.decode(str);
//   return List<Post>.from(data.map((item) => Post.fromJson(item)));
//   // Post.fromJson(json.decode(str));
// } 

// String postToJson(Post data) {
//   final jsonData = data.toJson();
//   return json.encode(jsonData);
//   // json.encode(data.toJson());

// }

// // Post postFromJson(String str) => Post.fromJson(json.decode(str));

// // String postToJson(Post data) => json.encode(data.toJson());




// class Post {
//     int id;
//     String noIndukBuku;
//     String callNumber1;
//     String callNumber2;
//     String callNumber3;
//     String tajukSubjek;
//     String pengarang;
//     String judul;
//     String jilidKe;
//     String seri;
//     String edisiKe;
//     String cetakanKe;
//     String penerbit;
//     String kotaTerbit;
//     String tahunTerbit;
//     String jumlahHalaman;
//     String ilustrasi;
//     String bibliografi;
//     String isbn;
//     String tinggiBuku;
//     String diterimaDari;
//     String jumlahEksemplar;
//     DateTime selesaiDiproses;
//     dynamic createdBy;
//     dynamic updatedBy;
//     dynamic createdAt;
//     dynamic updatedAt;

//     Post({
//         this.id,
//         this.noIndukBuku,
//         this.callNumber1,
//         this.callNumber2,
//         this.callNumber3,
//         this.tajukSubjek,
//         this.pengarang,
//         this.judul,
//         this.jilidKe,
//         this.seri,
//         this.edisiKe,
//         this.cetakanKe,
//         this.penerbit,
//         this.kotaTerbit,
//         this.tahunTerbit,
//         this.jumlahHalaman,
//         this.ilustrasi,
//         this.bibliografi,
//         this.isbn,
//         this.tinggiBuku,
//         this.diterimaDari,
//         this.jumlahEksemplar,
//         this.selesaiDiproses,
//         this.createdBy,
//         this.updatedBy,
//         this.createdAt,
//         this.updatedAt,
//     });

//     factory Post.fromJson(Map<String, dynamic> json) {
//       return Post(
//         id: json["id"],
//         noIndukBuku: json["no_induk_buku"],
//         callNumber1: json["call_number_1"],
//         callNumber2: json["call_number_2"],
//         callNumber3: json["call_number_3"],
//         tajukSubjek: json["tajuk_subjek"],
//         pengarang: json["pengarang"],
//         judul: json["judul"],
//         jilidKe: json["jilid_ke"],
//         seri: json["seri"],
//         edisiKe: json["edisi_ke"],
//         cetakanKe: json["cetakan_ke"],
//         penerbit: json["penerbit"],
//         kotaTerbit: json["kota_terbit"],
//         tahunTerbit: json["tahun_terbit"],
//         jumlahHalaman: json["jumlah_halaman"],
//         ilustrasi: json["ilustrasi"],
//         bibliografi: json["bibliografi"],
//         isbn: json["ISBN"],
//         tinggiBuku: json["tinggi_buku"],
//         diterimaDari: json["diterima_dari"],
//         jumlahEksemplar: json["jumlah_eksemplar"],
//         selesaiDiproses: DateTime.parse(json["selesai_diproses"]),
//         createdBy: json["created_by"],
//         updatedBy: json["updated_by"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//     ); 
//     }

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "no_induk_buku": noIndukBuku,
//         "call_number_1": callNumber1,
//         "call_number_2": callNumber2,
//         "call_number_3": callNumber3,
//         "tajuk_subjek": tajukSubjek,
//         "pengarang": pengarang,
//         "judul": judul,
//         "jilid_ke": jilidKe,
//         "seri": seri,
//         "edisi_ke": edisiKe,
//         "cetakan_ke": cetakanKe,
//         "penerbit": penerbit,
//         "kota_terbit": kotaTerbit,
//         "tahun_terbit": tahunTerbit,
//         "jumlah_halaman": jumlahHalaman,
//         "ilustrasi": ilustrasi,
//         "bibliografi": bibliografi,
//         "ISBN": isbn,
//         "tinggi_buku": tinggiBuku,
//         "diterima_dari": diterimaDari,
//         "jumlah_eksemplar": jumlahEksemplar,
//         "selesai_diproses": "${selesaiDiproses.year.toString().padLeft(4, '0')}-${selesaiDiproses.month.toString().padLeft(2, '0')}-${selesaiDiproses.day.toString().padLeft(2, '0')}",
//         "created_by": createdBy,
//         "updated_by": updatedBy,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//     };
// }

// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

// import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
    bool status;
    String message;
    List<Datum> data;

    Post({
        this.status,
        this.message,
        this.data,
    });

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    String noIndukBuku;
    String callNumber1;
    String callNumber2;
    String callNumber3;
    String tajukSubjek;
    String pengarang;
    String judul;
    String jilidKe;
    String seri;
    String edisiKe;
    String cetakanKe;
    String penerbit;
    String kotaTerbit;
    String tahunTerbit;
    String jumlahHalaman;
    String ilustrasi;
    String bibliografi;
    String isbn;
    String tinggiBuku;
    String diterimaDari;
    String jumlahEksemplar;
    DateTime selesaiDiproses;
    dynamic createdBy;
    dynamic updatedBy;
    dynamic createdAt;
    dynamic updatedAt;

    Datum({
        this.id,
        this.noIndukBuku,
        this.callNumber1,
        this.callNumber2,
        this.callNumber3,
        this.tajukSubjek,
        this.pengarang,
        this.judul,
        this.jilidKe,
        this.seri,
        this.edisiKe,
        this.cetakanKe,
        this.penerbit,
        this.kotaTerbit,
        this.tahunTerbit,
        this.jumlahHalaman,
        this.ilustrasi,
        this.bibliografi,
        this.isbn,
        this.tinggiBuku,
        this.diterimaDari,
        this.jumlahEksemplar,
        this.selesaiDiproses,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        noIndukBuku: json["no_induk_buku"],
        callNumber1: json["call_number_1"],
        callNumber2: json["call_number_2"],
        callNumber3: json["call_number_3"],
        tajukSubjek: json["tajuk_subjek"],
        pengarang: json["pengarang"],
        judul: json["judul"],
        jilidKe: json["jilid_ke"],
        seri: json["seri"],
        edisiKe: json["edisi_ke"],
        cetakanKe: json["cetakan_ke"],
        penerbit: json["penerbit"],
        kotaTerbit: json["kota_terbit"],
        tahunTerbit: json["tahun_terbit"],
        jumlahHalaman: json["jumlah_halaman"],
        ilustrasi: json["ilustrasi"],
        bibliografi: json["bibliografi"],
        isbn: json["ISBN"],
        tinggiBuku: json["tinggi_buku"],
        diterimaDari: json["diterima_dari"],
        jumlahEksemplar: json["jumlah_eksemplar"],
        selesaiDiproses: DateTime.parse(json["selesai_diproses"]),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "no_induk_buku": noIndukBuku,
        "call_number_1": callNumber1,
        "call_number_2": callNumber2,
        "call_number_3": callNumber3,
        "tajuk_subjek": tajukSubjek,
        "pengarang": pengarang,
        "judul": judul,
        "jilid_ke": jilidKe,
        "seri": seri,
        "edisi_ke": edisiKe,
        "cetakan_ke": cetakanKe,
        "penerbit": penerbit,
        "kota_terbit": kotaTerbit,
        "tahun_terbit": tahunTerbit,
        "jumlah_halaman": jumlahHalaman,
        "ilustrasi": ilustrasi,
        "bibliografi": bibliografi,
        "ISBN": isbn,
        "tinggi_buku": tinggiBuku,
        "diterima_dari": diterimaDari,
        "jumlah_eksemplar": jumlahEksemplar,
        "selesai_diproses": "${selesaiDiproses.year.toString().padLeft(4, '0')}-${selesaiDiproses.month.toString().padLeft(2, '0')}-${selesaiDiproses.day.toString().padLeft(2, '0')}",
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
