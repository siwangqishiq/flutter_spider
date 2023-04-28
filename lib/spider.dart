import 'package:dio/dio.dart';
import 'package:fast_gbk/fast_gbk.dart';
import 'package:html/dom.dart';
import 'package:spider/log.dart';
import 'package:html/parser.dart' as parser;


///
/// 
///
class Spider{
  String url = "http://www.netbian.com/shouji";

  Future<void> startTask() async{
    final dio = Dio();
    // dio.options.headers["Content-Type"] = "application/x-www-form-urlencoded; charset=UTF-8";
    dio.options.responseType = ResponseType.bytes;
    final response = await dio.get(url);

    LogUtil.log(response.statusCode.toString());
    if(response.statusCode != 200){
      return;
    }

    await _parseHtml(gbk.decode(response.data));
  }

  Future<void> _parseHtml(String? htmlSource) async{
    Document document = parser.parse(htmlSource);
    // LogUtil.log("${document.outerHtml}");

    var imgElementList = document.body?.getElementsByClassName("list");
    // LogUtil.log("${document.body?.innerHtml}");
    var imgList = imgElementList?.first.getElementsByTagName("img");
    LogUtil.log("imgElementList size : ${imgList?.length}");

    for(Element imgElem in imgList??[]){
      var imageSrc = imgElem.attributes['src'];
      var desc = imgElem.attributes['alt'];
      LogUtil.log("$desc");
      LogUtil.log("$imageSrc");
    }
  }
}
