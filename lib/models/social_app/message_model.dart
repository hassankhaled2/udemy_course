class MessageModel
{
String ?senderID;
String ?receiverId;
String ?datetime;
String ?text;
  MessageModel({
    this.senderID,
    this.receiverId,
    this.datetime,
    this.text,
  });
  MessageModel.fromjson(Map<String,dynamic>json)
  {
    senderID=json['senderID'];
    receiverId=json ['receiverID'];
    datetime=json['datetime'];
    text=json['text'];
  }
  Map<String,dynamic> ToMap()
  {
    return{
      'senderID': senderID,
      'receiverID':receiverId,
      'datetime':datetime,
      'text':text,
    };
  }
}