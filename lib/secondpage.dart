import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'model.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final dio = Dio();
  List<Data> listMyData = [];
  bool isLoading = false;
  Future<List<Data>> getData() async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 3));
    try {
      final response = await dio.get(
        'https://dummy.restapiexample.com/api/v1/employees',
        options: Options(
          sendTimeout: const Duration(seconds: 2),
          receiveTimeout: const Duration(seconds: 2),
        ),
      );
      if (response.statusCode == 200) {
        debugPrint(response.data.toString());
        List listData = response.data['data'] as List;
        listMyData = listData.map((e) => Data.fromJson(e)).toList();
        debugPrint(listMyData.toString());
        setState(() {});
      } else if (response.statusCode == 500) {
        debugPrint('internal server down');
      }
      setState(() => isLoading = false);
      return listMyData;
    } on DioException catch (e) {
      setState(() => isLoading = false);
      if (e.response != null) {} else {
        debugPrint('----e> $e');
        debugPrint('-----requestOptions> ${e.requestOptions}');
        debugPrint('-----message> ${e.message}');
      }
      return listMyData;
    }
  }
  @override
  void initState(){
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
        centerTitle: true,
      ),
      body: isLoading? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
              color: Colors.white,
            ),
          ),
        ],
      ) :  ListView.builder(
        itemCount: listMyData.length,
        itemBuilder: (_, index){
          return
            Padding(padding: EdgeInsets.all(8),
              child: Card(
                color: Colors.cyan,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('employee_Id: ${listMyData[index].id.toString()}'),
                          Text('employee_Name: ${listMyData[index].employeeName.toString()}'),
                          Text('employee_Salary: ${listMyData[index].employeeSalary.toString()}'),
                          Text('employee_Age: ${listMyData[index].employeeAge.toString()}'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
        },
      ),

      //Center(
      //   child: SingleChildScrollView(
      //     child: Padding(padding:  EdgeInsets.all(8.0),
      //       child: Table(
      //           border: TableBorder.all(color: Colors.black),
      //           defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      //           children:[
      //             TableRow(
      //               decoration: BoxDecoration(
      //                 color: Colors.red,
      //               ),
      //               children: [
      //                 TableCell(
      //                     verticalAlignment: TableCellVerticalAlignment.middle,
      //                     child: Padding(padding: EdgeInsets.all(8.0),
      //                       child: Text('employee_Id'),
      //                     )
      //                 ),
      //                 TableCell(
      //                     verticalAlignment: TableCellVerticalAlignment.middle,
      //                     child: Padding(padding: EdgeInsets.all(8.0),
      //                       child: Text('employee_Name'),
      //                     )
      //                 ),
      //                 TableCell(
      //                     verticalAlignment: TableCellVerticalAlignment.middle,
      //                     child: Padding(padding: EdgeInsets.all(8.0),
      //                       child: Text('employee_Salary'),
      //                     )
      //                 ),
      //                 TableCell(
      //                     verticalAlignment: TableCellVerticalAlignment.middle,
      //                     child: Padding(padding: EdgeInsets.all(8.0),
      //                       child: Text('employee_Age'),
      //                     )
      //                 ),
      //               ],
      //             ),
      //             ...List.generate(30, (index) =>
      //             TableRow(
      //               children: [
      //                 TableCell(
      //                     verticalAlignment: TableCellVerticalAlignment.middle,
      //                     child: Padding(padding: EdgeInsets.all(8.0),
      //                     child: Text('${listMyData[index].id.toString()}'),
      //                     )
      //                 ),
      //                 TableCell(
      //                     verticalAlignment: TableCellVerticalAlignment.middle,
      //                     child: Padding(padding: EdgeInsets.all(8.0),
      //                       child: Text('cell 2'),
      //                     )
      //                 ),
      //
      //                 TableCell(
      //                     verticalAlignment: TableCellVerticalAlignment.middle,
      //                     child: Padding(padding: EdgeInsets.all(8.0),
      //                       child: Text('cell 3'),
      //                     )
      //                 ),
      //                 TableCell(
      //                     verticalAlignment: TableCellVerticalAlignment.middle,
      //                     child: Padding(padding: EdgeInsets.all(8.0),
      //                       child: Text('cell 3'),
      //                     )
      //                 ),
      //               ]
      //             )
      //
      //             )
      //           ]
      //       ),
      //     ),
      //   ),
      // ),


    );
  }
}
