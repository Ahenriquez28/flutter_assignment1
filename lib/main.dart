import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tabs Assignment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: DefaultTabController(
        length: 4, 
        child: _TabsNonScrollableDemo(),
      ),
    );
  }
}

class _TabsNonScrollableDemo extends StatefulWidget {
  @override
  __TabsNonScrollableDemoState createState() =>
      __TabsNonScrollableDemoState();
}

class __TabsNonScrollableDemoState extends State<_TabsNonScrollableDemo>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController _tabController;
  final RestorableInt tabIndex = RestorableInt(0);
  final TextEditingController _textController = TextEditingController();

  @override
  String get restorationId => 'tab_non_scrollable_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 4, 
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    tabIndex.dispose();
    _textController.dispose();
    super.dispose();
  }
  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert Dialog'),
          content: Text('This is an alert dialog in Tab 1!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('You clicked OK!')),
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabs = ['Tab 1', 'Tab 2', 'Tab 3', 'Tab 4'];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Tabs Demo'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            for (final tab in tabs) Tab(text: tab),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [

          _buildTab1(),
          
          _buildTab2(),
          
          _buildTab3(),
          
          _buildTab4(),
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Container(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Home pressed')),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Search pressed')),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.settings, color: Colors.white),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Settings pressed')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildTab1() {
    return Container(
      color: Colors.red.shade50,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Tab 1',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'This tab features a text widget with custom styling',
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.red.shade700,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () => _showAlertDialog(context),
              icon: Icon(Icons.notifications_active),
              label: Text('Show Alert Dialog'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildTab2() {
    return Container(
      color: Colors.green.shade50,
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Tab 2: Image & Input',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade900,
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    'https://picsum.photos/250/250',
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 250,
                        height: 250,
                        color: Colors.green.shade200,
                        child: Icon(
                          Icons.image,
                          size: 100,
                          color: Colors.green.shade700,
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 30),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    labelText: 'Enter your text',
                    hintText: 'Type something...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.edit, color: Colors.green),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  if (_textController.text.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('You entered: ${_textController.text}'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter some text!')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab3() {
    return Container(
      color: Colors.blue.shade50,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tab 3: Interactive Button',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Button pressed in Tab 3 tab!'),
                    backgroundColor: Colors.blue,
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Click me'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab4() {
    final List<Map<String, dynamic>> items = [
      {
        'title': 'Item 1',
        'subtitle': 'This is the first item in the list',
        'icon': Icons.star,
        'color': Colors.orange,
      },
      {
        'title': 'Item 2',
        'subtitle': 'This is the second item in the list',
        'icon': Icons.favorite,
        'color': Colors.red,
      },
      {
        'title': 'Item 3',
        'subtitle': 'This is the third item in the list',
        'icon': Icons.thumb_up,
        'color': Colors.blue,
      },
      {
        'title': 'Item 4',
        'subtitle': 'This is the fourth item in the list',
        'icon': Icons.emoji_events,
        'color': Colors.amber,
      },
      {
        'title': 'Item 5',
        'subtitle': 'This is the fifth item in the list',
        'icon': Icons.cake,
        'color': Colors.pink,
      },
    ];

    return Container(
      color: Colors.purple.shade50,
      child: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: items[index]['color'],
                child: Icon(
                  items[index]['icon'],
                  color: Colors.white,
                ),
              ),
              title: Text(
                items[index]['title'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(items[index]['subtitle']),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${items[index]['title']} tapped!'),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}