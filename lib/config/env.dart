class Env {
  // Supabase Configuration
  static const supabaseUrl = 'https://dthdapqwcpwqzbpkeoxc.supabase.co';
  static const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR0aGRhcHF3Y3B3cXpicGtlb3hjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDI4MjIzMjYsImV4cCI6MjA1ODM5ODMyNn0.2sOTYFs_ntN8YkIiCx2xhayNzYTA15zaO9jR8A1lx1c';

  // Backend API (Node.js)
  static const apiBaseUrl = 'https://c08c-2409-40c2-10b-cc54-810-d213-a9da-a5f0.ngrok-free.app/api'; // Android emulator
  // static const apiBaseUrl = 'http://localhost:3000/api'; // iOS simulator

  // Timeouts
  static const apiTimeout = Duration(seconds: 20);
}