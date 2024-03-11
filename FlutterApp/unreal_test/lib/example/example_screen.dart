import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unreal_test/example/bloc/example_bloc.dart';
import 'package:unreal_test/example/bloc/example_data.dart';
import 'package:unreal_test/example/bloc/example_state.dart';

class ExampleScreen extends StatelessWidget {
  const ExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExampleBloc(),
      child: const _ExampleScreen(),
    );
  }
}

class _ExampleScreen extends StatelessWidget {
  const _ExampleScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const Text("Wonderful Example Screen")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          child: _buildList(context),
        ),
      ),
    );
  }

  _buildList(BuildContext context) {
    return BlocBuilder<ExampleBloc, ExampleState>(
      builder: (BuildContext context, ExampleState state) {
        if (state is UpdateState) {
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return _buildItem(state.updatedInteger[index]);
            },
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemCount: state.updatedInteger.length,
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildItem(ExampleData data) {
    return SizedBox(height: 50, child: Text(data.value.toString()));
  }
}
