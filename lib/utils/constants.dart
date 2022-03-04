var baseUrl = "http://localhost:8080";

final signInUrl = baseUrl+"/api/users/login";
final signUpUrl = baseUrl+"/api/users/signUp";
final signOutUrl = baseUrl+"/api/users/logout";
final getDetailUrl = baseUrl+"/api/users/user_info";
final findPasswordUrl = baseUrl+"/api/users/find-password";
final changePasswordUrl = baseUrl+"/api/users/change-password";

final tokenHeaderName = "x-auth-token";