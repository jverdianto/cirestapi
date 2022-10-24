part of 'services.dart';

class RajaOngkirService {
  static Future<http.Response> getOngkir() {
    return http.post(Uri.https(Const.baseUrl, "/starter/cost"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'key': Const.apiKey
        },
        body: jsonEncode(<String, dynamic>{
          'origin': '501',
          'destination': '114',
          'weight': 2500,
          'courier': 'jne'
        })
    );
  }
}

class EmailService{
  static Future<http.Response> sendEmail(String mail) {
    return http.post(
        Uri.https(Const_Email.baseUrl, "/week5/cirestapi/api/mahasiswa/sendmail"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': mail
        })
    );
  }
}