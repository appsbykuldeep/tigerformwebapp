import 'package:tiger_newemployee/Models/image_saved.dart';
import 'package:tiger_newemployee/Models/newform_model.dart';

ApplicationModel appicationdata = ApplicationModel();
ImageSave idpicstatus = ImageSave();
ImageSave signpicstatus = ImageSave();
ImageSave profilepicstatus = ImageSave();
ImageSave markspicstatus = ImageSave();
ImageSave paymentpicstatus = ImageSave();
String frompage = '';
String reffid = '';
final formdata = appicationdata.toJson();
final picid = {
  'profile': profilepicstatus.id,
  'signpic': signpicstatus.id,
  'address': idpicstatus.id,
  'marks': markspicstatus.id,
  'payment': paymentpicstatus.id
};

final fullapplicationdata = {...formdata, ...picid};
