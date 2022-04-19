var baseUrl = "http://localhost:8080/api/";

final signInUrl = baseUrl+"users/login";
final signUpUrl = baseUrl+"users/signUp";
final signOutUrl = baseUrl+"users/logout";
final getDetailUrl = baseUrl+"users/user_info";
final findPasswordUrl = baseUrl+"users/find-password";
final changePasswordUrl = baseUrl+"users/change-password";
final getUniversitiesUrl = baseUrl+"university";
final emailAuthUrl = baseUrl+"email";
final friendUrl = baseUrl+"friend";
final scheduleUrl = baseUrl+"schedule";
final groupUrl = baseUrl+"schedule-group";
final timeTableUrl = baseUrl+"timetable";
final lectureUrl = baseUrl+"lecture";

final tokenHeaderName = "x-auth-token";