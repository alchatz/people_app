import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:people_app/presentation/widgets/person_list_item.dart';

import '../cubits/people_extended_cubit.dart';

class PeopleListPageWRouter extends StatefulWidget {
  const PeopleListPageWRouter({super.key});

  @override
  State<PeopleListPageWRouter> createState() => _PeopleListPageState();
}

class _PeopleListPageState extends State<PeopleListPageWRouter> {

  @override
  void initState() {
    super.initState();
    context.read<PeopleExtendedCubit>().fetchPeople();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('People List'),
        backgroundColor: Colors.blueGrey[900]),
      backgroundColor: Colors.blueGrey[50],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search by name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                context.read<PeopleExtendedCubit>().searchPeople(query);
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<PeopleExtendedCubit, PeopleExtendedState>(
              builder: (context, state) {
                if (state is PeopleLoading || state is PeopleInitial) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PeopleLoaded) {
                  return ListView.builder(
                    itemCount: state.people.length,
                    itemBuilder: (context, index) {
                      final person = state.people[index];
                      return PersonListItem(
                        person: person,
                        onTap: () {
                          context.go('/person/${person.id}');
                        },
                      );
                    },
                  );
                } else if (state is PeopleError) {
                  return Center(child: Text(state.message));
                }
                return const Center(child: Text('Something went wrong.'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
