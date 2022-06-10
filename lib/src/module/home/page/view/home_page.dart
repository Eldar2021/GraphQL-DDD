import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../src.dart';
import 'characters_view.dart';
import 'episodes_view.dart';
import 'locations_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeCubit>(),
      child: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        key: const Key('HomeView'),
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        onPageChanged: context.read<HomeCubit>().change,
        children: const [
          CharactersView(),
          EpisodesView(),
          LocationsView(),
        ],
      ),
      bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return NavigationBar(
            selectedIndex: state.val,
            onDestinationSelected: (val) async {
              context.read<HomeCubit>().change(val);
              await toPage(val);
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.admin_panel_settings),
                label: 'Characters',
              ),
              NavigationDestination(
                icon: Icon(Icons.approval),
                label: 'Episodes',
              ),
              NavigationDestination(
                icon: Icon(Icons.audio_file),
                label: 'Locations',
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> toPage(int val) async {
    await controller.animateToPage(
      val,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }
}
