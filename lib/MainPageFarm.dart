import 'dart:ui';
import 'package:det/pages/scanPlant.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(FarmApp());
}

class FarmApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Farm App',
      theme: ThemeData(
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Colors.green[50],
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.greenAccent),
      ),
      home: FarmPage(),
    );
  }
}

class FarmPage extends StatefulWidget {
  @override
  _FarmPageState createState() => _FarmPageState();
}

class _FarmPageState extends State<FarmPage> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    HomePage(),
    CropValuePage(),
    SmartFarmingPage(),
    WeatherPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       backgroundColor:Colors.lightGreen,
        title: Text('Farm App'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grass),
            label: 'Crops',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.agriculture),
            label: 'Your Farm',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_sunny),
            label: 'Weather',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Welcome to Your Farm',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 20),
              _buildWelcomeCard(context),
              SizedBox(height: 20),
              _buildPlantProductsSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeCard(BuildContext context) {
    return Card(
      elevation: 5.0,
      shadowColor: Colors.green[400],
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => scanPlant()),
          );
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: Image.network('https://img.freepik.com/free-photo/close-up-woman-examining-plant-growth-using-touchpad-while-working-plant-nursery_637285-1425.jpg?size=626&ext=jpg&ga=GA1.1.347972461.1701675275&semt=ais',
                height: 220,width: double.infinity,),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 0.0),
              child: Container(
                color: Colors.transparent,
              ),
            ),
            ListTile(
              title: Text(
                'Scan your crop',
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Scan your crop to identify the disease',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlantProductsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Products',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        SizedBox(height: 10),
        MyProduct(),
      ],
    );
  }
}

class PlantProduct {
  final String name;
  final String description;
  final String imageUrl;

  PlantProduct({
    required this.name,
    required this.description,
    required this.imageUrl,
  });
}

class MyProduct extends StatelessWidget {
  final List<PlantProduct> plantProducts = [
    PlantProduct(
        name: 'Katyayani Thiophanate Methyl',
        description: 'Fungicide for Plants Eyespot powdery Mildew, Blight or Gray Mold Apple Scab ',
        imageUrl: 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcRG28CI7kRN_j-sUqNqGWAlC78AACqvfjMXHqRs1Fx6yObnlhE4Kxx3CqPGuoQKvfdp7G0yMdtZCDoHYsEJLf5U1hhUUWXWNo19K3LH_jz5jkFHmFTlbZue4Q&usqp=CAE'
    ),
    PlantProduct(
      name: 'Phosphorus Free Lawn Fertilizer',
      description: 'Pro Care Phosphorus Free Lawn Fertilizer 28 - 0 - 4 is a highly effective lawn fertilizer perfect for all types of grass. Contains nitrogen, soluble potash, and iron to help the healthy growth of plants, allowing grasses to stay deep green even during months with high temperatures. ',
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBUSwKID119jf7C_0QYYHLwFxX_NEyXc0JiQ&usqp=CAU',
    ),
    PlantProduct(
      name: 'Premium Bio NPK ltr',
      description: 'BIO-NPK LIQUID (Biofertilizer) is a blend of microbes capable of fixing nitrogen, solubilizing phosphate, and mobilizing potash ',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAMW-WNDAGIhRReUNvb5t14UcK1kSR8DPFeQ&usqp=CAU',
    ),
    // Add more PlantProduct instances as needed
  ];

  @override
  Widget build(BuildContext context) {
    return PlantProductsList(plantProducts: plantProducts);
  }
}

class PlantProductsList extends StatelessWidget {
  final List<PlantProduct> plantProducts;

  PlantProductsList({required this.plantProducts});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        ...plantProducts.map((plantProduct) {
          return Card(
            elevation: 4.0,
            shadowColor: Colors.green[300],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  child: Image.network(
                    plantProduct.imageUrl,
                    fit: BoxFit.fitHeight,
                    height: 150,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plantProduct.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        plantProduct.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                // Add to Cart button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.green,
                    shadowColor: Colors.greenAccent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    minimumSize: Size(10, 40), //////// HERE
                  ),
                  onPressed: () {
                    // Implement the action when the "Add to Cart" button is pressed
                    _showSnackBar(context, 'Added to Cart: ${plantProduct.name}');
                  },

                  child: Text('Add to Cart'),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

class CropValuePage extends StatelessWidget {
  final List<Crop> crops = [
    Crop(name: 'Wheat', value: 200),
    Crop(name: 'Corn', value: 150),
    Crop(name: 'Rice', value: 180),
    // Add more crops as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView.builder(
        itemCount: crops.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4.0,
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListTile(
              title: Text(
                crops[index].name,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '\$${crops[index].value.toString()} per ton',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                _showCropDetails(context, crops[index]);
              },
            ),
          );
        },
      ),
    );
  }

  void _showCropDetails(BuildContext context, Crop crop) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(crop.name),
          content: Text('Current value: \$${crop.value.toString()} per ton'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class Crop {
  final String name;
  final double value; // Assuming value is in dollars per ton

  Crop({required this.name, required this.value});
}

class SmartFarmingPage extends StatefulWidget {
  @override
  _SmartFarmingPageState createState() => _SmartFarmingPageState();
}

class _SmartFarmingPageState extends State<SmartFarmingPage> {
  bool isIrrigationOn = false;

  @override
  Widget build(BuildContext context) {
    Color irrigationColor = isIrrigationOn ? Colors.green : Colors.red;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            _buildCard(
              icon: Icons.wb_sunny,
              title: 'Weather',
              subtitle: 'Temperature: 25°C, Humidity: 60%',
              onTap: () {
                _showSnackBar(context, 'Weather card tapped');
              },
            ),
            _buildCard(
              icon: Icons.eco,
              title: 'Crop Health',
              subtitle: 'Status: Good',
              onTap: () {
                _showSnackBar(context, 'Crop Health card tapped');
              },
            ),
            _buildCard(
              icon: Icons.opacity,
              title: 'Irrigation',
              subtitle: 'Status: ${isIrrigationOn ? 'On' : 'Off'}',
              color: irrigationColor,
              onTap: () {
                setState(() {
                  isIrrigationOn = !isIrrigationOn;
                });
                _showSnackBar(context, 'Irrigation is ${isIrrigationOn ? 'On' : 'Off'}');
              },
            ),
            _buildCard(
              icon: Icons.timeline,
              title: 'Harvest Prediction',
              subtitle: 'Estimated Time: 2 weeks',
              onTap: () {
                _showSnackBar(context, 'Harvest Prediction card tapped');
              },
            ),
            _buildCard(
              icon: Icons.search_outlined,
              title: 'Scan',
              subtitle: 'Scan your crop',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => scanPlant()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? color,
  }) {
    return Card(
      elevation: 4.0,
      color: color,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 34.0,
              ),
              SizedBox(height: 8.0),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

class WeatherPage extends StatelessWidget {
  const WeatherPage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Weather Forecast',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Image.network(
                    'https://img.freepik.com/free-psd/3d-icon-weather-conditions-with-rain_23-2150108725.jpg?w=740&t=st=1701759449~exp=1701760049~hmac=54f960a3c61c9a35ece5a896e10442fc59131a995cb930dd27ff887ad1b7ebd8', // Replace with your weather image asset
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 10),
                  Text('Details about the weather forecast go here.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
