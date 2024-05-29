import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../../app_style.dart';
import '../controllers/content_box_controller.dart';

class ContentBox extends StatefulWidget {
  const ContentBox({super.key});

  @override
  State<ContentBox> createState() => _ContentBoxState();
}

class _ContentBoxState extends State<ContentBox> {
  final controller = ContentBoxController();

  @override
  void initState() {
    super.initState();
    controller.getSimulations();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppStyle.padding8,
        vertical: AppStyle.padding16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            flex: 1,
            child: ContentBoxInfo(),
          ),
          const SizedBox(width: AppStyle.padding16),
          Expanded(
            flex: 3,
            child: ValueListenableBuilder(
              valueListenable: controller.simulationSelected,
              builder: (context, value, child) {
                if (value == null) {
                  return const ContentBoxData();
                }
                return const SimulationInfoBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ContentBoxInfo extends StatelessWidget {
  const ContentBoxInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/simulations.png',
        ),
        const SizedBox(height: AppStyle.padding16),
        const Text(
          'THÔNG TIN SỬ DỤNG',
        ),
        const SizedBox(height: AppStyle.padding16),
        Container(
          width: 320,
          padding: const EdgeInsets.all(AppStyle.padding32),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade400,
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Thông tin tài nguyên sử dụng phục vụ tính toán và mô phỏng của Trung tâm Dữ liệu - MKDC.',
              ),
              const SizedBox(height: AppStyle.padding16),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: '- Thời gian tính toán: ',
                    ),
                    TextSpan(
                      text: 'Không giới hạn',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: AppStyle.padding4),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: '- Giới hạn phiên làm việc: ',
                    ),
                    TextSpan(
                      text: '100',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: AppStyle.padding4),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: '- Ngày bắt đầu: ',
                    ),
                    TextSpan(
                      text: '29/05/2024',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ContentBoxData extends StatelessWidget {
  const ContentBoxData({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ContentBoxController();

    return ValueListenableBuilder(
      valueListenable: controller.isLoading,
      builder: (context, value, child) {
        if (value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return const SimulationDataTable();
      },
    );
  }
}

class SimulationDataTable extends StatelessWidget {
  const SimulationDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ContentBoxController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                onFieldSubmitted: (value) {
                  controller.onSearchSummit(value);
                },
                style: const TextStyle(
                  fontSize: AppStyle.fontSize14,
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    size: AppStyle.iconSize20,
                  ),
                  hintText: 'Tìm kiếm',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppStyle.padding8),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ListenableBuilder(
              listenable: controller,
              builder: (context, child) {
                return SingleChildScrollView(
                  child: DataTable(
                    showCheckboxColumn: false,
                    headingRowColor: const WidgetStatePropertyAll(
                      AppStyle.menuColor,
                    ),
                    headingTextStyle: const TextStyle(
                      color: AppStyle.whiteColor,
                    ),
                    columns: const [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Model')),
                      DataColumn(label: Text('User')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('Type')),
                      DataColumn(label: Text('Start Time')),
                      DataColumn(label: Text('Length')),
                    ],
                    rows: [
                      for (final item in controller.simulations)
                        DataRow(
                          cells: [
                            DataCell(Text(item.id)),
                            DataCell(Text(item.name)),
                            DataCell(Text(item.modelName)),
                            DataCell(Text(item.username)),
                            DataCell(Text(item.status)),
                            DataCell(Text(item.type)),
                            DataCell(Text(
                              DateTime.tryParse(item.started) != null
                                  ? DateFormat('dd/MM/yyyy HH:mm:ss')
                                      .format(DateTime.parse(item.started))
                                      .toString()
                                  : item.started,
                            )),
                            DataCell(Text(formatTotalTime(item.totalTime))),
                          ],
                          onSelectChanged: (value) {
                            if (value == true) {
                              controller.onSelectSimulation(item);
                            }
                          },
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        ListenableBuilder(
          listenable: controller,
          builder: (context, child) {
            return Container(
              margin: const EdgeInsets.only(top: AppStyle.padding8),
              height: 48,
              width: 440,
              child: NumberPaginator(
                initialPage: controller.currentPage,
                numberPages: controller.numberOfPage,
                onPageChange: (int index) {
                  controller.currentPage = index;
                  controller.getSimulations();
                },
                config: NumberPaginatorUIConfig(
                  buttonShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  buttonSelectedBackgroundColor: AppStyle.menuColor,
                  buttonUnselectedForegroundColor: AppStyle.menuColor,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  String formatTotalTime(int totalTime) {
    if (totalTime > 3600) {
      return '${(totalTime / 3600).toStringAsFixed(2)} giờ';
    } else if (totalTime > 60) {
      return '${(totalTime / 60).toStringAsFixed(2)} phút';
    } else {
      return '${(totalTime).toStringAsFixed(2)} giây';
    }
  }
}

class SimulationInfoBox extends StatelessWidget {
  const SimulationInfoBox({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ContentBoxController();
    final simulation = controller.simulationSelected.value!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                controller.simulationSelected.value = null;
                controller.simulationFiles.value = null;
              },
              icon: const Icon(
                Icons.close,
                size: AppStyle.iconSize20,
              ),
            ),
            const SizedBox(width: AppStyle.padding8),
            Text(
              '${simulation.name.toString()} (ID: ${simulation.id})',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const Divider(),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: SimulationTextItem(
                      title: 'Name',
                      value: simulation.name,
                    ),
                  ),
                  Expanded(
                    child: SimulationTextItem(
                      title: 'Duration',
                      value: simulation.duration.toString(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppStyle.padding16),
              Row(
                children: [
                  Expanded(
                    child: SimulationTextItem(
                      title: 'Start time',
                      value: simulation.started,
                    ),
                  ),
                  Expanded(
                    child: SimulationTextItem(
                      title: 'End time',
                      value: simulation.finished,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppStyle.padding16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Results',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppStyle.fontSize16,
                          ),
                        ),
                        ValueListenableBuilder(
                          valueListenable: controller.simulationFiles,
                          builder: (context, files, child) {
                            if (files == null) {
                              return const SizedBox();
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (final file in files)
                                  InkWell(
                                    onTap: () {
                                      controller.launchUrl(file['url']);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: AppStyle.padding8,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.download,
                                            size: AppStyle.iconSize18,
                                          ),
                                          const SizedBox(
                                            width: AppStyle.padding8,
                                          ),
                                          Text(
                                            '${file['name']} (${formatFileSize(file['size'])})',
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SimulationTextItem(
                      title: 'Model',
                      value: simulation.modelName,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppStyle.padding16),
            ],
          ),
        ),
      ],
    );
  }

  String formatFileSize(double size) {
    const units = ["bytes", "KB", "MB", "GB", "TB"];
    int i = 0;

    while (size >= 1024 && i < units.length - 1) {
      size /= 1024;
      i++;
    }

    return "${size.toStringAsFixed(2)} ${units[i]}";
  }
}

class SimulationTextItem extends StatelessWidget {
  const SimulationTextItem({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: AppStyle.fontSize16,
          ),
        ),
        const SizedBox(height: AppStyle.padding4),
        Text(
          value,
        ),
      ],
    );
  }
}
