import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:travelo_mobile/utils/util.dart';

class GalleryWidget extends StatefulWidget {
  final List<String> images;
  const GalleryWidget({super.key, required this.images});

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoViewGallery.builder(
        itemCount: widget.images.length,
        builder: (context, index) {
          final img = widget.images[index];
          return PhotoViewGalleryPageOptions(
            imageProvider: imageFromBase64String(img).image,
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.contained * 4,
          );
        },
      ),
    );
  }
}
