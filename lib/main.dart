import 'package:flutter/material.dart';

//supabase
import 'package:supabase_flutter/supabase_flutter.dart';

//internal
import 'package:buddybrew/routes.dart';
import 'package:buddybrew/theme.dart';

final supabase = Supabase.instance.client;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://kydfxujmkfeudafznumu.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imt5ZGZ4dWpta2ZldWRhZnpudW11Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTQ1NTQzOTYsImV4cCI6MjAxMDEzMDM5Nn0.eP6cyFYgHlMOONS8sCSshE_CYEq0YDZ4F1-PWmxf1UU',
  );
  runApp(const App());
}

/// We are using a StatefulWidget such that we only create the [Future] once,
/// no matter how many times our widget rebuild.
/// If we used a [StatelessWidget], in the event where [App] is rebuilt, that
/// would re-initialize FlutterFire and make our application re-enter loading state,
/// which is undesired.
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRoutes,
      theme: buildTheme(Brightness.light, context),
      darkTheme: buildTheme(Brightness.dark, context),
      themeMode: ThemeMode.light,
    );
  }
}
