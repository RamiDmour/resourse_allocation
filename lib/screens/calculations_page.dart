import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resourse_allocation/components/container_card.dart';
import 'package:resourse_allocation/components/pie_chart.dart';
import 'package:resourse_allocation/utils/PieElement.dart';
import 'package:resourse_allocation/utils/ResourceAllocator.dart';

class CalculationsPage extends StatelessWidget {
  final int years;
  ResourceAllocator _allocator;
  CalculationsPage({Key key, this.years}) : super(key: key) {
    var allocator = ResourceAllocator();

    allocator.allocateResources(years);
    this._allocator = allocator;
  }

  List<Widget> _buildAllocations() {
    List<Widget> allocations = [];

    for (var i = 0; i < _allocator.allocationPlan.length; i++) {
      allocations.add(Text(
          'Предприятие номер ${i + 1}: ${_allocator.allocationPlan[i]} ед.'));
    }

    return allocations;
  }

  Widget _buildChart() {
    List<PieElement> series =
        _allocator.allocationPlan.asMap().entries.map((entry) {
      return PieElement(
          index: entry.key,
          title: "Предприятие ${entry.key + 1}",
          value: entry.value,
          color:
              Color((Random().nextDouble() * 0xFFFFF).toInt()).withOpacity(1));
    }).toList();

    return MyPieChart(series: series);
  }

  @override
  Widget build(BuildContext context) {
    int resoursesToAllocation =
        _allocator.allocationPlan.reduce((value, element) => value + element);
    return Scaffold(
      appBar: AppBar(title: Text('Расчёты за $years лет')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Container(
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      Text('Результат',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 36,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 48),
                        child: ContainerCard(
                          child: Center(
                              child: Text(
                                  'Количество денег к распределению: $resoursesToAllocation')),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: ContainerCard(
                          child: Center(
                              child: Column(
                            children: [
                              ..._buildAllocations(),
                            ],
                          )),
                        ),
                      ),
                      ContainerCard(
                        child: Center(
                            child: Text(
                                'Максимальная прибыль за $years лет: ${_allocator.profit}')),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 90, left: 32),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(child: _buildChart())),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
