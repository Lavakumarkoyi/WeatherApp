import 'package:flutter/material.dart';

class FutureForecastScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF003FFE)),
          onPressed: () {},
        ),
        title: Text('5 - Day Forecasts', style: TextStyle(color: Color(0xFF003FFE))),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.blue),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          children: [
            // Main Weather Card
            Container(
              // padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF6F95FF),
                    Color.fromARGB(255, 53, 103, 255),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.8],
                ),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Tomorrow',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.wb_sunny, color: Colors.yellowAccent, size: 50),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CHICAGO',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Mostly Sunny',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    '24°/17°',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.grain, color: Colors.white),
                          SizedBox(height: 5),
                          Text(
                            '90%',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Precipitation',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.water_drop, color: Colors.white),
                          SizedBox(height: 5),
                          Text(
                            '90%',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Humidity',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.air, color: Colors.white),
                          SizedBox(height: 5),
                          Text(
                            '12 m/h',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Wind Speed',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Forecast List
            Expanded(
              child: ListView(
                children: [
                  _buildForecastItem('Mon', Icons.wb_sunny, 'Mostly clear', '29°/20°'),
                  _buildForecastItem('Tue', Icons.cloud, 'Thunderstorms', '31°/20°'),
                  _buildForecastItem('Wed', Icons.foggy, 'With Fog', '19°/20°'),
                  _buildForecastItem('Thu', Icons.wb_sunny, 'Mostly clear', '19°/20°'),
                  _buildForecastItem('Fri', Icons.wb_sunny, 'Mostly clear', '19°/20°'),
                  _buildForecastItem('Sat', Icons.wb_sunny, 'Mostly clear', '19°/20°'),
                  _buildForecastItem('Sun', Icons.wb_sunny, 'Mostly clear', '19°/20°'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForecastItem(String day, IconData icon, String description, String temperature) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0), // Increased padding between items
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(day,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 97, 96, 96))),
          Row(
            children: [
              Icon(icon, color: Colors.yellow, size: 24),
              SizedBox(width: 10),
              Text(description, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF474747))),
            ],
          ),
          Text(temperature, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF474747))),
        ],
      ),
    );
  }
}
