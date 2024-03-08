import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unify/provider/theme_provider.dart';

class ContactDevScreen extends StatelessWidget {
  const ContactDevScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage("lib/assets/images/profile.jpg"),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Sahil Hussain",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text(
                "Instagram",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                "https://www.instagram.com/sahilll.h",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            ListTile(
              title: Text(
                "LinkedIn",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                "https://www.linkedin.com/in/shellinox",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            ListTile(
              title: Text(
                "Github",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                "https://github.com/shellinox",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: textController,
              decoration: InputDecoration(
                  hintText: "Have a suggestion? Tell us..",
                  hintStyle: context.watch<ThemeProvider>().isDarkMode
                      ? Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white54)
                      : Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black54),
                  contentPadding: const EdgeInsets.all(14),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor))),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(3)),
                child: const Center(
                    child: Text(
                  "Share Feedback",
                  style: TextStyle(color: Colors.black),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
