import 'package:firebaseconnations/screen/Profile/ProfileTutorUS.dart';
import 'package:flutter/material.dart';

class TutorsListSub extends StatelessWidget {
  TutorsListSub(
      this.fname, this.lname, this.phoneNumber, this.rating, this.email);
  String fname, lname, phoneNumber, email;
  var rating;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProfileTutorUS(email)));
      },
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 30.0,
        backgroundColor: colorScheme.background,
        backgroundImage: NetworkImage(phoneNumber),
      ),
      title: Text(
        '$fname $lname',
        style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8.0,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            children: [
              const Icon(
                Icons.star,
                color: Colors.orangeAccent,
                size: 16,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                '$rating',
                style: textTheme.bodySmall!.copyWith(
                  color: colorScheme.onBackground.withOpacity(.5),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Icon(
                Icons.work,
                color: colorScheme.tertiary,
                size: 16,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                "3 Years",
                style: textTheme.bodySmall!.copyWith(
                  color: colorScheme.onBackground.withOpacity(.5),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: FilledButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProfileTutorUS(email)));
        },
        child: const Text("Book Now"),
      ),
    );
  }
}
