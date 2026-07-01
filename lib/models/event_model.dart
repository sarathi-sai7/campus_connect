class EventModel {

  final String id;

  final String title;

  final String description;

  final String category;

  final String location;

  final String image;

  final String createdBy;

  final DateTime eventDate;

  final DateTime createdAt;

  final List<String>
      registeredStudents;

  final int participantsCount;

  final bool isOfficial;

  EventModel({

    required this.id,

    required this.title,

    required this.description,

    required this.category,

    required this.location,

    required this.image,

    required this.createdBy,

    required this.eventDate,

    required this.createdAt,

    required this.registeredStudents,

    required this.participantsCount,

    required this.isOfficial,
  });

  // =========================
  // FROM MAP
  // =========================

  factory EventModel.fromMap(

    Map<String, dynamic> map,
  ) {

    return EventModel(

      id:
          map["id"] ?? "",

      title:
          map["title"] ?? "",

      description:
          map["description"] ?? "",

      category:
          map["category"] ?? "",

      location:
          map["location"] ?? "",

      image:
          map["image"] ?? "",

      createdBy:
          map["createdBy"] ?? "",

      eventDate:

          map["eventDate"] !=
                  null

              ? map["eventDate"]
                  .toDate()

              : DateTime.now(),

      createdAt:

          map["createdAt"] !=
                  null

              ? map["createdAt"]
                  .toDate()

              : DateTime.now(),

      registeredStudents:

          List<String>.from(

        map["registeredStudents"] ??
            [],
      ),

      participantsCount:

          map["participantsCount"] ??
              0,

      isOfficial:
          map["isOfficial"] ??
              false,
    );
  }

  // =========================
  // TO MAP
  // =========================

  Map<String, dynamic> toMap() {

    return {

      "id": id,

      "title": title,

      "description":
          description,

      "category":
          category,

      "location":
          location,

      "image": image,

      "createdBy":
          createdBy,

      "eventDate":
          eventDate,

      "createdAt":
          createdAt,

      "registeredStudents":
          registeredStudents,

      "participantsCount":
          participantsCount,

      "isOfficial":
          isOfficial,
    };
  }
}