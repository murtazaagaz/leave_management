import 'dart:convert';

class Leave {
  int avaialableLeaves;
  int totalLeaves;
  int usedLeaves;
  Leave({
    required this.avaialableLeaves,
    required this.totalLeaves,
    required this.usedLeaves,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'avaialableLeaves': avaialableLeaves});
    result.addAll({'totalLeaves': totalLeaves});
    result.addAll({'usedLeaves': usedLeaves});

    return result;
  }

  factory Leave.fromMap(Map<String, dynamic> map) {
    return Leave(
      avaialableLeaves: map['avaialableLeaves']?.toInt() ?? 0,
      totalLeaves: map['totalLeaves']?.toInt() ?? 0,
      usedLeaves: map['usedLeaves']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Leave.fromJson(String source) => Leave.fromMap(json.decode(source));
}
