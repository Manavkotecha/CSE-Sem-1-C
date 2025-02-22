import 'package:flutter/material.dart';

class Aboutus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        centerTitle: true,
        backgroundColor: Color(0xFFB24592),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title and Logo
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100), // Circular Image
                    child: Image.asset(
                      'assets/images/heart.jpeg',
                      height: 130,
                      width: 130,
                      fit: BoxFit.cover, // Ensures image fits properly
                    ),
                  ),
                  const SizedBox(height: 16), // Spacing
                  const Text(
                    'Forever Together',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB24592),
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black38,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Find your perfect match with us',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Meet Our Team Section
              _buildCard(
                title: 'Meet Our Team',
                children: [
                  buildKeyValueRow('Developed by', 'Manav Kotecha (23010101145)'),
                  buildKeyValueRow('Mentored by', 'Prof. Mehul Bhundiya (Computer Engineering Department), School of Computer Science'),
                  buildKeyValueRow('Explored by', 'ASWDC, School Of Computer Science'),
                  buildKeyValueRow('Eulogized by', 'Darshan University, Rajkot, Gujarat - INDIA'),
                ],
              ),
              SizedBox(height: 16),

              // About ASWDC Section
              _buildCard(
                title: 'About ASWDC',
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Image.asset(
                          'assets/images/du.jpg', // Update image path
                        ),
                      ),
                      Expanded(
                        child: Image.asset(
                          'assets/images/aswdc.jpg', // Update image path
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'ASWDC is Application, Software and Website Development Center @ Darshan University run by Students and Staff of School Of Computer Science.',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Sole purpose of ASWDC is to bridge the gap between university curriculum & industry demands. Students learn cutting-edge technologies, develop real-world applications & experience a professional environment @ ASWDC under the guidance of industry experts & faculty members.',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Contact Us Section
              _buildCard(
                title: 'Contact Us',
                children: [
                  buildContactRow(Icons.email, 'aswdc@darshan.ac.in'),
                  buildContactRow(Icons.phone, '+91-9727747317'),
                  buildContactRow(Icons.language, 'www.darshan.ac.in'),
                ],
              ),
              SizedBox(height: 16),

              // Other Links Section
              _buildCard(
                title: 'Other Links',
                children: [
                  buildLinkRow(Icons.share, 'Share App'),
                  buildLinkRow(Icons.apps, 'More Apps'),
                  buildLinkRow(Icons.star, 'Rate Us'),
                  buildLinkRow(Icons.thumb_up, 'Like us on Facebook'),
                  buildLinkRow(Icons.update, 'Check For Update'),
                ],
              ),
              SizedBox(height: 16),

              // Footer
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: '© 2025 Darshan University\nAll Rights Reserved - Privacy Policy\nMade with ',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 14, // Adjust size to fit with text
                        ),
                      ),
                      const TextSpan(
                        text: ' in India',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required List<Widget> children}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFB24592),
              ),
            ),
            Divider(color: Color(0xFFB24592)),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget buildKeyValueRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: Text('$key: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
          Expanded(flex: 3, child: Text(value, style: TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  Widget buildContactRow(IconData icon, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFFB24592)),
          SizedBox(width: 8),
          Text(info, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget buildLinkRow(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFFB24592)),
          SizedBox(width: 8),
          Text(title, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
