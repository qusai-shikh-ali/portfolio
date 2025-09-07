import 'package:flutter/material.dart';

class SubjectCard extends StatefulWidget {
  final String subjectsName;
  final String hourlyWage;
  final String imgPath;
  final int rate;
  final Function onpress;

  const SubjectCard(
      this.subjectsName, this.hourlyWage, this.imgPath, this.rate, this.onpress,
      {super.key});

  @override
  State<SubjectCard> createState() => _SubjectCardState();
}

class _SubjectCardState extends State<SubjectCard> {
  @override
  void initState() {
    super.initState();
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
                      widget.subjectsName,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                    Row(
                      children: [
                        Text(
                          "${widget.hourlyWage}€",
                          style: const TextStyle(
                              color: Colors.green, fontSize: 18),
                        ),
                        const Text(
                          "/Hour",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        )
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
