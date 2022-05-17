class EvalDetailModel {
  int? id;
  double score;
  String description;

  EvalDetailModel(this.id, this.score, this.description);

  EvalDetailModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        score = json['score'],
        description = json["description"];

  Map<String, dynamic> toJson() =>
      {"id": id, "score": score, "description": description};

  factory EvalDetailModel.of(score, description) {
    return EvalDetailModel(null, score, description);
  }
}
