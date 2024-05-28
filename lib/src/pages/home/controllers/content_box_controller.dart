import 'dart:convert';

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

  int currentPage = 1; // Trang hiện tại, bắt đầu từ 1
  int itemsPerPage = 10; // Số lượng bản ghi trên mỗi trang
  int numberOfPage = 0;

  ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<List<SimulationModel>> getSimulations() async {
    isLoading.value = true;
    simulations.clear();

    final body = await _threeDiService.getSimulations(
      limit: itemsPerPage,
      offset: currentPage * itemsPerPage,
    );
    final data = json.decode(body);

    numberOfPage = ((data['count'] + itemsPerPage - 1) / itemsPerPage).toInt();

    for (final item in data['results']) {
      final simulation = SimulationModel(
        id: item['simulation']['id'].toString(),
        name: item['simulation']['name'].toString(),
        model: '',
        tags: List.from(item['simulation']['tags']),
        username: item['user_name'].toString(),
        started: item['started'].toString(),
        finished: item['finished'].toString(),
        totalTime: item['total_time'],
        type: item['simulation_type'].toString(),
        status: item['status'].toString(),
      );

      simulations.add(simulation);

      _threeDiService
          .getModelById(id: item['simulation']['threedimodel_id'].toString())
          .then(
        (modelDataString) {
          final modelInfo = jsonDecode(modelDataString);
          simulation.model = modelInfo['name'];
          notifyListeners();
        },
      );
    }

    isLoading.value = false;
    return [];
  }
}
