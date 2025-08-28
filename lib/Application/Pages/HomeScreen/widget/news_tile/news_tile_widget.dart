import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gap/gap.dart';

class NewsTileWidget extends StatelessWidget {
  const NewsTileWidget({super.key});

  Future<String> fetchImageUrl(String relativePath) async {
    try {
      if (relativePath.isEmpty) {
        return '';
      }
      final ref = FirebaseStorage.instance.ref(relativePath);
      String downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error fetching image URL: $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double tileHeight = screenWidth * 0.45;
    double tileWidth = screenWidth * 0.8;
    double textSizeHeading = screenWidth * 0.035;
    double textSizeSubtitle = screenWidth * 0.025;
    double imageSize = tileHeight * 0.4;

    return Center(
        child: SizedBox(
          height: tileHeight,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('NewsTile').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text("No news available"));
              }

              var documents = snapshot.data!.docs;

              return SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    children: List.generate(documents.length, (index) {
      var newsData = documents[index].data() as Map<String, dynamic>;
      var news1 = newsData['News1'] as Map<String, dynamic>;

      String heading = news1['Heading'] ?? '';
      String subject = news1['subject'] ?? '';
      String imagePath = news1['Imageurl'] ?? '';
      String url = news1['url'] ?? '';

      return SizedBox( // Replacing Expanded with SizedBox
        width: tileWidth, // Specify width for each tile
        child: NewsTile(
          heading: heading,
          subject: subject,
          imagePath: imagePath,
          tileWidth: tileWidth,
          tileHeight: tileHeight,
          textSizeHeading: textSizeHeading,
          textSizeSubtitle: textSizeSubtitle,
          imageSize: imageSize,
          fetchImageUrl: fetchImageUrl,
          url: url,
        ),
      );
    }),
  ),
);

            },
          ),
        ),
      );
}
}
class NewsTile extends StatefulWidget {
  final String heading;
  final String subject;
  final String imagePath;
  final double tileWidth;
  final double tileHeight;
  final double textSizeHeading;
  final double textSizeSubtitle;
  final double imageSize;
  final Future<String> Function(String) fetchImageUrl;
  final String url;

  const NewsTile({
    super.key,
    required this.heading,
    required this.subject,
    required this.imagePath,
    required this.tileWidth,
    required this.tileHeight,
    required this.textSizeHeading,
    required this.textSizeSubtitle,
    required this.imageSize,
    required this.fetchImageUrl,
    required this.url,
  });

  @override
  State<NewsTile> createState() => _NewsTileState();
}

class _NewsTileState extends State<NewsTile> {
  void _openWebView(String url) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InAppWebViewScreen(url: url)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      elevation: 3,
      color: const Color.fromARGB(255, 130, 133, 172),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: widget.tileWidth,
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.heading,
                        style: TextStyle(
                          fontSize: widget.textSizeHeading,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.subject,
                        style: TextStyle(
                          fontSize: widget.textSizeSubtitle,
                          color: Colors.white,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.fade,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                FutureBuilder<String>(
                  future: widget.fetchImageUrl(widget.imagePath),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.grey,
                      );
                    }
                    return ClipOval(
                      child: Image.network(
                        snapshot.data!,
                        width: widget.imageSize,
                        height: widget.imageSize,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.error,
                            size: 50,
                            color: Colors.red,
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
           Gap(3),
            GestureDetector(
              onTap: () {
                if (widget.url.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No URL provided')),
                  );
                } else {
                  _openWebView(widget.url);
                }
              },
              child: Text(
                'Read More',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: widget.textSizeSubtitle,
                  decoration: TextDecoration.underline,
                  
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InAppWebViewScreen extends StatelessWidget {
  final String url;

  const InAppWebViewScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News WebView'),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(url)),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            javaScriptEnabled: true,
            useShouldOverrideUrlLoading: true,
          ),
        ),
      ),
    );
  }
}