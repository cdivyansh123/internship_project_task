import 'package:expense_management_system/screens/view_group_screen.dart';
import 'package:expense_management_system/widgets/Custom_icon_button.dart';
import 'package:flutter/material.dart';


class GroupScreen extends StatefulWidget {
  const GroupScreen({Key? key}) : super(key: key);

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Groups"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
         child: Column(
           children: [
             MyButton(icon: Icons.add, label: "Create Group", onPressed: (){
               //todo
             }),
             SizedBox(height: 10,),
             MyButton(icon: Icons.group, label: "View all Groups", onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewGroup()));
               //todo
             })
           ],
         ),
        ),
      ),
    );
  }
}
