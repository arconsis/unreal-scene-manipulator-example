import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unreal_test/home/repository/data/Data.dart';
import 'package:unreal_test/home/widgets/object_card.dart';
import 'bloc/home_bloc.dart';
import 'bloc/home_event.dart';
import 'bloc/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeBloc(),
      child: const _HomeScreen(),
    );
  }
}

class _HomeScreen extends StatefulWidget {
  const _HomeScreen();

  @override
  State<_HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<_HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Home Screen'),
      ),
      floatingActionButton: _buildFAB(),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) =>
      BlocBuilder<HomeBloc, HomeState>(
          builder: (BuildContext context, HomeState state) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.dataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildCard(state.dataList[index]);
                  },
                ),
              ),
            ],
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
      });

  Widget _buildCard(Data data) {
    return ObjectCard(
      id: data.id,
      data: data,
      dismissCard: _dismissCard,
    );
  }

  Widget _buildFAB() {
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      FloatingActionButton(
        onPressed: _addCard,
        child: const Icon(Icons.add),
      ),
      const SizedBox(height: 10),
      FloatingActionButton(
        onPressed: _sendData,
        heroTag: null,
        child: const Icon(Icons.send),
      )
    ]);
  }

  void _sendData() {
    BlocProvider.of<HomeBloc>(context).add(const SendDataEvent());
  }

  void _dismissCard(int id) {
    BlocProvider.of<HomeBloc>(context).add(DismissCardEvent(id));
  }

  void _addCard() {
    BlocProvider.of<HomeBloc>(context).add(const AddCardEvent());
  }
}
