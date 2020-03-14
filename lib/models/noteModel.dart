class Note{
  int id;
  String noteText;
  int clrID;

  Note(this.id, this.noteText,this.clrID);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'noteText': noteText,
      'clrID': clrID,
    };
    return map;
  }

  Note.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    noteText = map['noteText'];
    clrID =map['clrID'];
  }
}