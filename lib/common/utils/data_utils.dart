import 'dart:convert';

class DataUtils{
    static pathToUrl(String value){
      return "http://$value";
    }

    static String EncodingToUrl(String plain){
      Codec<String,String> stringToUrl=utf8.fuse(base64Url); //인코딩 방식을 결정.

      String encoded =stringToUrl.encode(plain); //방식을 활용해서 rawstring를 인딩
      return encoded;
    }

    static String DecodingToUrl(String encoded){
      Codec<String,String> stringToBase64=utf8.fuse(base64Url);

      String decoded =stringToBase64.decode(encoded);
      return decoded;
    }
}
