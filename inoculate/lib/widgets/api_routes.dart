import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inoculate/modules/lesson_snippet/lesson_snippet.dart';
import 'package:inoculate/utils/services/get_api_routes.dart';
import 'package:provider/provider.dart';

class ApiRoutes extends StatefulWidget {
  const ApiRoutes({super.key});

  @override
  State<ApiRoutes> createState() => _ApiRoutesState();
}

class _ApiRoutesState extends State<ApiRoutes> {
  String apiRoutes = 'Loading...';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    fetchApiRoutes(context);
  }

  Future<void> fetchApiRoutes(BuildContext buildContext) async {
    User? user = Provider.of<User?>(buildContext);

    if (user == null) {
      setState(() {
        apiRoutes = "User not authenticated";
      });
      return;
    }

    String routes = await getApiRoutes(user);

    setState(() {
      apiRoutes = routes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InformationCard(data: apiRoutes);
  }
}
