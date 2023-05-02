import 'package:expense_management_system/widgets/Custom_icon_button.dart';
import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../services/handle_ssl_certificate.dart';


class ViewGroup extends StatefulWidget {
  @override
  _ViewGroupState createState() => _ViewGroupState();
}

class _ViewGroupState extends State<ViewGroup> {
  List<dynamic> groupList = [];

  void callGroupListApi() async {
    final service = ApiServices();
    try {
      var response = await service
          .apiCallGroupList("3a0ad9f5-b95f-024b-11ae-a37a3e369f14");
      setState(() {
        groupList = response.result;
      });
    } catch (e) {
      // Handle error response
      print("API call failed with error");
    }
  }

  @override
  void initState() {
    super.initState();
    HttpService.setupHttpOverrides();
    callGroupListApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your groups'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(
                      icon: Icons.dashboard,
                      label: "Dashboard",
                      onPressed: () {
                        //todo
                      }),
                  SizedBox(
                    width: 10,
                  ),
                  MyButton(
                      icon: Icons.money,
                      label: "Expenses",
                      onPressed: () {
                        //todo
                      }),
                  SizedBox(
                    width: 10,
                  ),
                  MyButton(
                      icon: Icons.edit,
                      label: "Settle Up",
                      onPressed: () {
                        //todo
                      }),
                  SizedBox(
                    width: 10,
                  ),
                  MyButton(
                      icon: Icons.logout,
                      label: "Logout",
                      onPressed: () {
                        //todo
                      }),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: groupList.length,
                itemBuilder: (BuildContext context, int index) {
                  var group = groupList[index];
                  return ListTile(
                    title: Text('${group['name']}'),
                    subtitle: Text('${group['about']}'),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // todo: navigate to edit group page
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
