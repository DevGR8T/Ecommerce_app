import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  List profileactions = [
    'Edit Profile',
    'Shopping Address',
    'Wishlist',
    'Order History',
    'Notification',
    'Cards'
  ];
  List<IconData> profileicons = [
    Icons.person,
    Icons.location_on,
    Icons.favorite,
    Icons.history,
    Icons.notifications,
    Icons.credit_card,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 70,
            ),
            CircleAvatar(
              radius: 55,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('images/elizabeth.jpg'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Charlotte Reuter',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 5,
                    backgroundColor: Colors.green,
                  ),
                  Text('  Active Status'),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ListTile(
                      leading: Icon(profileicons[index]),
                      title: Text(
                        profileactions[index],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
