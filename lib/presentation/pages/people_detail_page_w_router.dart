import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/person_entity.dart';
import '../cubits/people_extended_cubit.dart';

// Page to display the details of a person
class PersonDetailPageWRouter extends StatefulWidget {
  final int personId;

  const PersonDetailPageWRouter({super.key, required this.personId});

  @override
  State<PersonDetailPageWRouter> createState() => _PersonDetailScreenState();
}

class _PersonDetailScreenState extends State<PersonDetailPageWRouter> {
  @override
  void initState() {
    super.initState();
    // Triggers the person selection in the cubit when the screen is initialized
    context.read<PeopleExtendedCubit>().selectPerson(widget.personId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Person Details')),
      body: BlocBuilder<PeopleExtendedCubit, PeopleExtendedState>(
        builder: (context, state) {
          // Displays details when a person is selected
          if (state is PersonSelected) {
            final Person person = state.selectedPerson;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${person.first_name} ${person.last_name}', style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 8),
                      Text('Email: ${person.email}')
                    ],
                  ),
                ),
              ),
            );
            // Shows a loading indicator while fetching data
          } else if (state is PeopleLoading) {
            return const Center(child: CircularProgressIndicator());
            // Shows an error message if something goes wrong
          } else if (state is PeopleError) {
            return Center(child: Text(state.message));
          }
          // Default message
          return const Center(child: Text('Select a person to see details.'));
        },
      ),
    );
  }
}

