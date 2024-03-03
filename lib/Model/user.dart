class MyUser {

  static const String collectionName = 'user' ;

  String? uId;
  String? name;
  String? email;

  MyUser ({required this.uId ,required this.name , required this.email });

  MyUser.fromFireStore (Map<String , dynamic> data):this (
    uId: data['uId'] as String,
    name: data['name'] as String,
    email: data['email'] as String
  );

  Map <String,dynamic> toFireStore (){
    return {
      "uId" : uId ,
      "name" : name ,
      "email" : email
    };
  }

}