class ApiEndpoints {
  ApiEndpoints._();

  // Timeouts
  static const connectionTimeout = Duration(seconds: 1000);
  static const receiveTimeout = Duration(seconds: 1000);

  // Server Base
  // static const String serverAddress = "http://192.168.1.77:5050";
  static const String baseUrl = "$serverAddress/api/";
    // For Android Emulator
  static const String serverAddress = "http://192.168.1.77:5050";

  // Auth
  static const String login = "auth/login";
  static const String register = "auth/register";

  // Doctor
  static const String getAllDoctors = "doctor/list";
  static const String getDoctorsBySpeciality = "doctor";

  // Appointment
  static const String getAppointments = "appointments";
  static const String bookAppointment = "book-appointment";
  static String getAppointmentById(String id) => "appointments/$id";
  static String cancelAppointment(String id) => "appointments/$id/cancel";
  static String completeAppointment(String id) => "appointments/$id/complete";
  static String updateAppointment(String id) => "appointments/$id";
  //profile
  static const String getProfile = "user/get-profile";
  static const String updateProfile = "user/update-profile";
}
