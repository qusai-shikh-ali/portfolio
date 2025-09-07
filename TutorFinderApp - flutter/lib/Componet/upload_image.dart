import 'package:flutter/material.dart';

class UploadImage extends StatefulWidget {
  const UploadImage(this.createData, this.imgPath, {super.key});
  final Function createData;
  final imgPath;
  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  var image = 'images/nour.png';

  photo() {
    if (widget.imgPath is String) {
      return CircleAvatar(
        backgroundImage: NetworkImage(widget.imgPath),
      );
    } else if (widget.imgPath != null) {
      return CircleAvatar(
        backgroundImage: FileImage(widget.imgPath),
      );
    } else {
      return CircleAvatar(
        backgroundImage: AssetImage('images/nour.png'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () async {
            widget.createData();
            // Update the selected image after it's chosen
            setState(() {
              print(widget.imgPath);
            });
          },
          child: Stack(
            children: [
              Positioned(
                child: SizedBox(height: 150, width: 150, child: photo()),
              ),
              const Positioned(
                top: 120,
                left: 90,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 18.0,
                  child: Icon(
                    Icons.camera_alt,
                    size: 20.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              const Positioned(
                top: 155,
                left: 25,
                child: Text(
                  "click to upload",
                  style: TextStyle(color: Colors.grey),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
