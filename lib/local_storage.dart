class StudentModel {
  List<StudentData>? studentData;
  String? time;

  StudentModel({this.studentData, this.time});

  StudentModel.fromJson(json) {
    studentData = (json["student_data"] as List)
        .map((value) => StudentData.fromJson(value))
        .toList();
    time = json["time"];
  }
}

class StudentData {
  int? id;
  String? name;
  String? address;
  int? number;
  int? age;
  String? course;

  StudentData({
    this.id,
    this.name,
    this.address,
    this.number,
    this.age,
    this.course,
  });

  StudentData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    address = json["address"];
    number = json["number"];
    age = json["age"];
    course = json["course"];
  }
}
