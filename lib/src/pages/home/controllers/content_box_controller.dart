import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/material.dart';

import '../../../models/simulation_model.dart';
import '../../../services/three_di_service.dart';

class ContentBoxController extends ChangeNotifier {
  ContentBoxController._();
  static final _instance = ContentBoxController._();
  factory ContentBoxController() {
    return _instance;
  }

  final _threeDiService = ThreeDiService();

  List<SimulationModel> simulations = [];
  int currentPage = 0;
  int itemsPerPage = 15;
  int numberOfPage = 0;
  String? currentKeyword;
  ValueNotifier<int> numberOfSimulation = ValueNotifier(0);

  ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<List<SimulationModel>> getSimulations() async {
    isLoading.value = true;
    simulations.clear();

    final body = await _threeDiService.getSimulations(
      limit: itemsPerPage,
      offset: currentPage * itemsPerPage,
      keyword: currentKeyword,
    );
    final data = json.decode(body);

    numberOfSimulation.value = data['count'] ?? 0;
    numberOfPage = ((data['count'] + itemsPerPage - 1) / itemsPerPage).toInt();

    if (numberOfPage <= 0) {
      numberOfPage = 1;
    }

    for (final item in data['results']) {
      final simulation = SimulationModel(
        id: item['simulation']['id'].toString(),
        name: item['simulation']['name'].toString(),
        modelName: '',
        modelId: item['simulation']['threedimodel_id'].toString(),
        tags: List.from(item['simulation']['tags']),
        username: item['user_name'].toString(),
        started: item['simulation']['start_datetime'].toString(),
        finished: item['simulation']['end_datetime'].toString(),
        totalTime: item['total_time'],
        duration: item['simulation']['duration'],
        type: item['simulation_type'].toString(),
        status: item['status'].toString(),
      );

      simulations.add(simulation);

      _threeDiService
          .getModelById(id: item['simulation']['threedimodel_id'].toString())
          .then(
        (modelDataString) {
          final modelInfo = jsonDecode(modelDataString);
          simulation.modelName = modelInfo['name'];
          notifyListeners();
        },
      );
    }

    isLoading.value = false;
    return [];
  }

  // Lấy thông tin Simulation được chọn
  ValueNotifier<SimulationModel?> simulationSelected = ValueNotifier(null);
  ValueNotifier<List<Map<String, dynamic>>?> simulationFiles = ValueNotifier(
    null,
  );

  Future<void> onSelectSimulation(SimulationModel simulation) async {
    simulationSelected.value = simulation;
    final files = json.decode(
      await _threeDiService.getSimulationFiles(id: simulation.id),
    );

    final List<Map<String, dynamic>> data = [];

    for (final file in files['results']) {
      data.add({
        'id': file['file']['id'],
        'name': file['file']['filename'],
        'size': file['file']['size'],
      });
    }

    for (int i = 0; i < data.length; i++) {
      final fileInfo = json.decode(await _threeDiService.getDownloadFile(
        fileId: data[i]['id'].toString(),
      ));

      try {
        data[i]['url'] = fileInfo['get_url'];
      } catch (e) {
        data[i]['url'] = '#';
      }
    }

    final gridAdminData = json.decode(
      await _threeDiService.getGridAdmin(
        modelId: simulation.modelId,
      ),
    );

    data.add(
      {
        'name': 'gridadmin.h5',
        'size': gridAdminData['size'],
        'url': gridAdminData['get_url'],
      },
    );
    simulationFiles.value = data;
  }

  void launchUrl(String url) {
    html.window.open(url, '');
  }

  void onSearchSummit(String? keyword) {
    currentKeyword = keyword;
    getSimulations();
  }
}
