import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_magang/common/widgets/search_field.dart';
import 'package:sistem_magang/core/config/assets/app_images.dart';
import 'package:sistem_magang/domain/entities/lecturer_home_entity.dart';
import 'package:sistem_magang/presenstation/lecturer/detail_student/pages/detail_student.dart';
import 'package:sistem_magang/presenstation/lecturer/home/bloc/lecturer_display_cubit.dart';
import 'package:sistem_magang/presenstation/lecturer/home/bloc/lecturer_display_state.dart';
import 'package:sistem_magang/presenstation/lecturer/home/bloc/selection_bloc.dart';
import 'package:sistem_magang/presenstation/lecturer/home/bloc/selection_event.dart';
import 'package:sistem_magang/presenstation/lecturer/home/bloc/selection_state.dart';
import 'package:sistem_magang/presenstation/lecturer/home/widgets/filter_jurusan.dart';
import 'package:sistem_magang/presenstation/lecturer/home/widgets/filter_tahun.dart';
import 'package:sistem_magang/presenstation/lecturer/home/widgets/student_card.dart';
import 'package:sistem_magang/presenstation/lecturer/profile/pages/lecturer_profile.dart';

class LecturerHomePage extends StatefulWidget {
  const LecturerHomePage({super.key});

  @override
  State<LecturerHomePage> createState() => _LecturerHomePageState();
}

class _LecturerHomePageState extends State<LecturerHomePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    LecturerHomeContent(),
    LecturerProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class LecturerHomeContent extends StatefulWidget {
  const LecturerHomeContent({super.key});

  @override
  _LecturerHomeContentState createState() => _LecturerHomeContentState();
}

class _LecturerHomeContentState extends State<LecturerHomeContent> {
  String _search = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => LecturerDisplayCubit()..displayLecturer()),
          BlocProvider(create: (context) => SelectionBloc()),
        ],
        child: BlocBuilder<LecturerDisplayCubit, LecturerDisplayState>(
          builder: (context, state) {
            if (state is LecturerLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is LecturerLoaded) {
              LecturerHomeEntity data = state.lecturerHomeEntity;
              List<LecturerStudentsEntity>? students =
                  data.students?.where((student) {
                return student.name
                        .toLowerCase()
                        .contains(_search.toLowerCase()) ||
                    student.major.toLowerCase().contains(_search.toLowerCase());
              }).toList();
              return BlocBuilder<SelectionBloc, SelectionState>(
                builder: (context, selectionState) {
                  return Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            _header(data.name, selectionState.isSelectionMode,
                                context),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Mahasiswa Bimbingan',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (students == null) ...[
                                    Text('Tidak Memiliki Mahasiswa Bimbingan'),
                                  ],
                                  if (students != null) ...[
                                    const SizedBox(height: 16),
                                    const Row(
                                      children: [
                                        Expanded(child: FilterJurusan()),
                                        SizedBox(width: 16),
                                        Expanded(child: FilterTahun()),
                                      ],
                                    ),
                                    ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: students.length,
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(height: 14),
                                      itemBuilder: (context, index) {
                                        return StudentCard(
                                          id: students[index].id,
                                          imageUrl:
                                              'https://picsum.photos/200/300',
                                          name: students[index].name,
                                          jurusan: students[index].major,
                                          nim: students[index].username,
                                          isSelected: selectionState.selectedIds
                                              .contains(students[index].id),
                                          onTap: () {
                                            if (selectionState
                                                .isSelectionMode) {
                                              context.read<SelectionBloc>().add(
                                                  ToggleItemSelection(
                                                      students[index].id));
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailStudentPage(
                                                            id: students[index]
                                                                .id,
                                                          )));
                                            }
                                          },
                                          onLongPress: () {
                                            if (!selectionState
                                                .isSelectionMode) {
                                              context
                                                  .read<SelectionBloc>()
                                                  .add(ToggleSelectionMode());
                                              context.read<SelectionBloc>().add(
                                                  ToggleItemSelection(
                                                      students[index].id));
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (selectionState.isSelectionMode)
                        Positioned(
                          bottom: 16,
                          right: 16,
                          child: FloatingActionButton(
                            onPressed: () => _showSendMessageDialog(context),
                            child: const Icon(Icons.add),
                          ),
                        ),
                    ],
                  );
                },
              );
            }
            if (state is LoadLecturerFailure) {
              return Text(state.errorMessage);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _header(String name, bool isSelectionMode, BuildContext context) {
    return Container(
      width: double.infinity,
      height: 220,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.homePattern),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isSelectionMode)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Select Items',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    context.read<SelectionBloc>().add(ToggleSelectionMode());
                  },
                ),
              ],
            )
          else ...[
            const Text(
              'HELLO,',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
          const SizedBox(height: 26),
          if (!isSelectionMode)
            SearchField(
              onChanged: (value) {
                setState(() {
                  _search = value;
                });
              },
              onFilterPressed: () {},
            ),
        ],
      ),
    );
  }

  void _showSendMessageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String message = '';
        return AlertDialog(
          title: const Text('Send Message'),
          content: TextField(
            onChanged: (value) {
              message = value;
            },
            decoration: const InputDecoration(hintText: "Enter your message"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Send'),
              onPressed: () {
                context.read<SelectionBloc>().add(SendMessage(message));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
