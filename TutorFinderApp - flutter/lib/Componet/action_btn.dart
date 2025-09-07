import 'package:firebaseconnations/Componet/constants.dart';
import 'package:flutter/material.dart';

class ActionBtn extends StatelessWidget {
  const ActionBtn(this.onPress, this.textBtn, this.icon, this.color,
      {super.key});
  final Function onPress;
  final String textBtn;
  final IconData? icon;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 200,
      child: FloatingActionButton(
        onPressed: () => onPress(),
        backgroundColor: color ?? Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textBtn,
              style: kTextActionBtn,
            ),
            const SizedBox(
              width: 10,
            ),
            if (icon != null)
              Icon(
                icon!,
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }
}
