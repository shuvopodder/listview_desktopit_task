import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'detailsView.dart';
import 'getData.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({Key? key}) : super(key: key);

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {

  final controller = ScrollController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var fetchData = Provider.of<getData>(context, listen: false);
    fetchData.getListData();
    controller.addListener(() async {
      if(controller.position.maxScrollExtent==controller.offset)
        {
          //getData();
          await context.read<getData>().getListData();
        }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text("List View Page"),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Center(
          child: Consumer<getData>(
              builder:(context,value,child){
                return value.data.isEmpty
                    ? const CircularProgressIndicator()
                    : ListView.builder(
                    controller: controller,
                    itemCount: value.data.length,
                    itemBuilder: (context,i){
                      return ListTile(
                        title: Text(value.data[i].id),
                        subtitle: Text(value.data[i].author),
                        trailing: Icon(Icons.more_vert_outlined),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context)=>
                                  detailsView(
                                      id: (value.data[i].id),
                                      url: (value.data[i].url),
                                      author: (value.data[i].author),
                                      width: (value.data[i].width),
                                      height: (value.data[i].height))));
                        },
                      );
                    });
              }
          ),
        ),
      ),
    );
  }
  Future<void> _onRefresh() async{
    await Future.delayed(const Duration(seconds: 2));
    //await context.read<getData>().getListData();
    setState(() {

    });
  }
}


