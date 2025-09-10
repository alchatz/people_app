import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:people_app/presentation/cubits/people_extended_cubit.dart';
import 'package:people_app/presentation/pages/people_detail_page_w_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:people_app/utils/services/people_api_services.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:people_app/presentation/pages/people_list_page_w_router.dart';
import 'package:people_app/utils/services/people_api_services_w_dio.dart';

import 'data/repositories/people_repository.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PeopleRepository(
        peopleApiServices: PeopleApiServicesWDio(dio: Dio()),
      ),
      // this is an older implementation using http and navigation without the go_router
      //
      // child: BlocProvider<PeopleCubit>(
      //   create: (context) =>
      //       PeopleCubit(peopleRepository: context.read<PeopleRepository>()),
      //   child: MaterialApp(
      //     title: 'People App',
      //     debugShowCheckedModeBanner: false,
      //     home: const PeopleListPage(),
      //   ),
      // ),
      child: BlocProvider<PeopleExtendedCubit>(
        create: (context) => PeopleExtendedCubit(personRepository: context.read<PeopleRepository>()),
        child: MaterialApp.router(
          title: 'People App',
          debugShowCheckedModeBanner: false,
          routerConfig: _router,
        ),
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const PeopleListPageWRouter();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'person/:id',
          builder: (BuildContext context, GoRouterState state) {
            final id = int.parse(state.pathParameters['id']!);
            return PersonDetailPageWRouter(personId: id);
          },
        ),
      ],
    ),
  ],
);
