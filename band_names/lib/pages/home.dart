import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:band_names/services/socket_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: "1", name: "Metallica", votes: 5),
    Band(id: "2", name: "Matallica 2", votes: 2),
    Band(id: "3", name: "Mitallica 3", votes: 4),
    Band(id: "4", name: "Mutallica 4", votes: 6),
    Band(id: "5", name: "Motallica 5", votes: 10),
  ];

  @override
  void initState() {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.on("active-bands", _handleActiveBands);

    super.initState();
  }

  _handleActiveBands(dynamic payload) {
    this.bands = (payload as List).map((band) => Band.fromMap(band)).toList();

    setState(() {});
  }

  @override
  void dispose() {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.off("active-bands");

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Band Names", style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: socketService.serverStatus == ServerStatus.Online
                ? Icon(Icons.check_circle, color: Colors.blue[300])
                : Icon(Icons.offline_bolt, color: Colors.red[800]),
          )
        ],
      ),
      body: Column(
        children: [
          _showGraph(),
          Expanded(
            child: ListView.builder(
              itemCount: bands.length,
              itemBuilder: (context, index) => bandTile(bands[index]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewBand,
        child: Icon(Icons.add),
        elevation: 1,
        highlightElevation: 1,
      ),
    );
  }

  Widget bandTile(Band band) {
    final socketService = Provider.of<SocketService>(context, listen: false);

    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) =>
          socketService.socket.emit("delete-band", {"id": band.id}),
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: Align(
          child: Text(
            "Delete Band",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          alignment: Alignment.centerLeft,
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text(
          "${band.votes}",
          style: TextStyle(fontSize: 20),
        ),
        onTap: () => socketService.socket.emit("vote-band", {"id": band.id}),
      ),
    );
  }

  addNewBand() {
    final textController = TextEditingController();

    if (Platform.isAndroid) {
      return showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("New Band Name"),
          content: TextField(controller: textController),
          actions: [
            MaterialButton(
              onPressed: () => addBandToList(textController.text),
              child: Text("Add"),
              elevation: 5,
              textColor: Colors.blue,
            )
          ],
        ),
      );
    } else {
      showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: Text("New Band Name"),
          content: CupertinoTextField(controller: textController),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("Add"),
              onPressed: () => addBandToList(textController.text),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  void addBandToList(String bandName) {
    final socketService = Provider.of<SocketService>(context, listen: false);

    if (bandName.length > 1) {
      socketService.socket.emit("add-band", {"name": bandName});
    }

    Navigator.pop(context);
  }

  Widget _showGraph() {
    Map<String, double> dataMap = Map();

    bands.forEach(
      (element) {
        dataMap.putIfAbsent(element.name, () => element.votes.toDouble());
      },
    );

    final List<Color> colorList = [
      Colors.blue[50]!,
      Colors.blue[200]!,
      Colors.pink[50]!,
      Colors.pink[200]!,
      Colors.yellow[50]!,
      Colors.yellow[200]!,
    ];

    return Container(
      padding: EdgeInsets.only(top: 10),
      width: double.infinity,
      height: 200,
      child: PieChart(
        dataMap: dataMap,
        animationDuration: Duration(milliseconds: 800),
        chartLegendSpacing: 32,
        chartRadius: MediaQuery.of(context).size.width / 3.2,
        colorList: colorList,
        initialAngleInDegree: 0,
        chartType: ChartType.ring,
        ringStrokeWidth: 20,
        centerText: "BANDS",
        legendOptions: LegendOptions(
          showLegendsInRow: false,
          legendPosition: LegendPosition.right,
          showLegends: true,
          legendShape: BoxShape.circle,
          legendTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        chartValuesOptions: ChartValuesOptions(
          showChartValueBackground: true,
          showChartValues: true,
          showChartValuesInPercentage: false,
          showChartValuesOutside: false,
          decimalPlaces: 0,
        ),
        // gradientList: ---To add gradient colors---
        // emptyColorGradient: ---Empty Color gradient---
      ),
    );
  }
}
