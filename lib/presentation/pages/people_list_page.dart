import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people_app/presentation/pages/people_detail_page.dart';

import '../cubits/people_cubit.dart';
import '../widgets/error_dialog.dart';
import '../widgets/person_list_item.dart';

class PeopleListPage extends StatefulWidget { // Changed to StatefulWidget
  const PeopleListPage({super.key});

  @override
  State<PeopleListPage> createState() => _PeopleListPageState(); // Added createState
}

class _PeopleListPageState extends State<PeopleListPage> { // New State class

  @override
  void initState() {
    super.initState();
    context.read<PeopleCubit>().fetchPeople();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('People List'),
        backgroundColor: Colors.blueGrey[900],
      ),
      backgroundColor: Colors.blueGrey[50],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
          ),
          // List of people
          Expanded(
            child: BlocConsumer<PeopleCubit, PeopleState>(
              listener: (context, state) {
                if (state.status == PeopleStatus.error) {
                  errorDialog(context, state.customError.errorMessage);
                }
              },
              builder: (context, state) {
                if (state.status == PeopleStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.status == PeopleStatus.loaded) {
                  if (state.people.isEmpty) {
                    return const Center(
                      child: Text(
                        'No people found.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: state.people.length,
                    itemBuilder: (context, index) {
                      final person = state.people.people[index];
                      return PersonListItem(
                        person: person,
                        onTap: () {
                          // Navigate to the detail page on tap
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PersonDetailPage(person: person),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else if (state.status == PeopleStatus.error) {
                  return Center(
                    child: Text(
                      'Error: ${state.customError.errorMessage}',
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  );
                }
                // Initial state or unexpected states
                return const Center(child: Text('Waiting for people to load...'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
