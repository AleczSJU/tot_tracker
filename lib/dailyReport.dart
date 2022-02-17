import 'package:flutter/material.dart';

class DailyReportPage extends StatefulWidget {
  const DailyReportPage({Key? key}) : super(key: key);

  @override
  _DailyReportPageState createState() => _DailyReportPageState();
}

class _DailyReportPageState extends State<DailyReportPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: BackButton(
              color: Colors.white,
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text('Daily Reports'),
            bottom: PreferredSize(
                child: TabBar(
                    isScrollable: true,
                    unselectedLabelColor: Colors.white.withOpacity(0.3),
                    indicatorColor: Colors.white,
                    tabs: [
                      Tab(
                        child: Text('Angelfish'),
                      ),
                      Tab(
                        child: Text('Starfish'),
                      ),
                      Tab(
                        child: Text('Seahorses'),
                      ),
                      Tab(
                        child: Text('Narwhals'),
                      ),
                      Tab(
                        child: Text('Sharks'),
                      ),
                      Tab(
                        child: Text('Sea Otters'),
                      ),
                      Tab(
                        child: Text('Sea Turtles'),
                      ),
                      Tab(
                        child: Text('Sea Dragons'),
                      )
                    ]),
                preferredSize: Size.fromHeight(30.0)),
          ),
          body: TabBarView(
            children: <Widget>[
              Container(
                child: Center(
                  child: Text('Tab 1'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Tab 2'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Tab 3'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Tab 4'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Tab 5'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Tab 6'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Tab 7'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Tab 8'),
                ),
              ),
            ],
          )),
    );
  }
}