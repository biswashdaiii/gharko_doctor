class ApiEndpoints {
  ApiEndpoints._();

  // Timeouts
  static const connectionTimeout = Duration(seconds: 1000);
  static const receiveTimeout = Duration(seconds: 1000);

  // For Android Emulator
  static const String serverAddress = "http://192.168.1.77:5050";

  // For iPhone (uncomment if needed)
  static const String baseUrl = "$serverAddress/api/";

  // Auth
  static const String login = "auth/login";
  static const String register = "auth/register";

  // Doctor Endpoints
  static const String getAllDoctors = "doctor/list"; // GET: api/doctor
  static const String getDoctorsBySpeciality = "doctor"; // GET: api/doctor?speciality={speciality}
  // static const String getDoctorById = "doctor"; // GET: api/doctor/
}
