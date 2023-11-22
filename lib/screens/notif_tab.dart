import 'package:flutter/material.dart';
import 'package:medzone/widgets/text_widget.dart';

class NotificationsTab extends StatelessWidget {
  const NotificationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: 'Notifications',
                      fontSize: 24,
                      fontFamily: 'Bold',
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.warning,
                      ),
                      color: Colors.red,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 500,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.notifications),
                          title: TextWidget(
                              text: 'Title of Notification', fontSize: 14),
                          subtitle: TextWidget(text: 'John Doe', fontSize: 12),
                          trailing:
                              TextWidget(text: '11/22/2023', fontSize: 10),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
