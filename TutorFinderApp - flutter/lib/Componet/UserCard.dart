import 'package:flutter/material.dart';

class UserCard extends StatefulWidget {
  final String userName;
  final String email;
  final String status;
  final String imgPath;
  final Function onpress;

  const UserCard(
      this.userName, this.email, this.status, this.imgPath, this.onpress,
      {super.key});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  Color color = Colors.black;

  @override
  void initState() {
    super.initState();
    color = getStatusColor(widget.status);
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.blue;
      case 'In Progress':
        return Colors.amber;
      case 'Completed':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      case 'On Hold':
        return Colors.orange;
      case 'Denied':
        return Colors.grey;
      default:
        return Colors.black; // Default color for unknown status
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onpress(),
      child: Card(
        elevation: 5,
        borderOnForeground: true,
        shadowColor: Colors.black,
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    image: DecorationImage(
                      image: NetworkImage(widget.imgPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      widget.userName,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                    Text(
                      widget.email,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                    Row(
                      children: [
                        Text(
                          "${widget.status}",
                          style: TextStyle(color: color, fontSize: 18),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
