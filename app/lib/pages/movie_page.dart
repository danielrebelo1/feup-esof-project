import 'package:flutter/material.dart';
import 'package:project/reusableWidgets/custom_nav_bar.dart';
import 'package:project/reusableWidgets/movie_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'utelly-api.dart';



class MoviePage extends StatefulWidget {
  final String email;
  final String username;
  final String password;
  final List topRatedMovies;
  final int currentIndex;
  final String path = 'https://image.tmdb.org/t/p/w500';
  final MediaModel? mediaModel;
  const MoviePage(
      {Key? key,
      required this.email,
        required this.username,
      required this.password,
      required this.topRatedMovies,
      required this.currentIndex,
      this.mediaModel})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MoviePageState();
}


class _MoviePageState extends State<MoviePage> {
  List<String> result = [];

  List<String> updateList(String url) {
    if (url == "") {
      setState(() {
        result = [];
      });
    } else {
      getPlatforms(url).then((results) {
        setState(() {
          result = results;
        });
      }).catchError((error) {
        print(error);
      });
    }
    print(result);
    return result;
  }

  String userComment = "";
  TextEditingController commentController = TextEditingController();
  CollectionReference comments = FirebaseFirestore.instance.collection('comments');

  @override
  Widget build(BuildContext context) {

    String utellyApiPath = 'https://utelly-tv-shows-and-movies-availability-v1.p.rapidapi.com/idlookup/source_id=' + widget.mediaModel!.id.toString() + '&source=tmdb&country=us';
    print(utellyApiPath);
    List<String> platforms = updateList(utellyApiPath);
    if (platforms.isEmpty) {
      platforms.add("netflix.png");
    }
    return Scaffold(
      bottomNavigationBar: CustomNavBar(
        email: widget.email,
        username: widget.username,
        password: widget.password,
      ),
      backgroundColor: const Color.fromRGBO(6, 10, 43, 1),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Opacity(
                opacity: 0.4,
                child: (widget.mediaModel?.poster != "null"
                        ? Image.network(
                            widget.mediaModel?.poster ?? "",
                            height: MediaQuery.of(context).size.height * 0.35,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            alignment: const Alignment(0, 0.7),
                          )
                        : Image.asset(
                            'assets/no-image.png',
                            height: MediaQuery.of(context).size.height * 0.35,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            alignment: const Alignment(0, 0.7),
                          ))),
            SingleChildScrollView(
              child: SafeArea(
                child: Column(children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: (widget.mediaModel?.poster != "null"
                                      ? Image.network(
                                          widget.mediaModel?.poster ?? "",
                                          height: 220,
                                          width: 180)
                                      : Image.asset('assets/no-image.png',
                                          height: 220, width: 180))),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Transform.translate(
                                offset: const Offset(0, 20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset('assets/' + platforms[0],
                                    height: 55,
                                    width: 50,
                                  ),
                                ),
                              ),
                              /*
                              const SizedBox(width: 15),
                              Transform.translate(
                                offset: const Offset(0, 20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset("assets/netflix.png",
                                      height: 55, width: 50),
                                ),
                              ),
                              */
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                widget.mediaModel?.mediaTitle ?? "",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.04,
                                ),
                              ),
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.height * 0.02),
                            Text(
                              widget.mediaModel?.mediaReleaseYear
                                          .toString().substring(0, 4) ??
                                      "",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.05),
                            Text(
                              widget.mediaModel?.rating.toString() ?? "",
                              style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.04,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.mediaModel?.description.toString() ?? "",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.height * 0.025,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      // Call function to dismiss the keyboard
                    },
                    child:
                  TextField(
                    onChanged: (value){userComment = value;},
                    maxLines: null,
                    controller: commentController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Give us your opinion',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () async{
                          await comments.add({
                            'content': userComment,
                            'idMovie': widget.mediaModel!.id ?? -1,
                            'timestamp': DateTime.now(),
                            'userID' : widget.email,
                          }).then((value) => print("Comment added!"));
                          setState(() {
                            userComment = ''; // Clear userComment after adding the comment
                          });
                          commentController.clear(); // Clear the text field
                          FocusScope.of(context).unfocus();
                          // Add your publish comment logic here
                        },
                        icon: Icon(Icons.arrow_forward),
                      ),
                    ),
                  ),
                  ),
                SizedBox(height: 16.0),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('comments')
                        .where('idMovie', isEqualTo: widget.mediaModel?.id ?? -1).orderBy('timestamp', descending: true)// replace 'comments' with your collection name
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      // Extract comments from the snapshot
                      final comments = snapshot.data?.docs;

                      return Container(
                        child: Column(
                          children: [
                            SizedBox(height: 16.0),
                            if (comments != null && comments.isNotEmpty)
                              ...comments.map((commentDoc) {
                                final commentData = commentDoc.data() as Map<String, dynamic>;
                                final content = commentData['content'] as String;
                                final timestamp = commentData['timestamp'] as Timestamp;
                                final time_now = DateTime.now();
                                final time_elapsed = time_now.difference(timestamp.toDate());
                                final time_elapsed_sec = time_elapsed.abs().inSeconds;
                                final commentTime;
                                if (time_elapsed_sec == 0) commentTime = "just now";
                                else if (time_elapsed_sec < 60) commentTime = "$time_elapsed_sec seconds ago";
                                else if (time_elapsed_sec < 3600) {
                                  final minutes = (time_elapsed_sec / 60).round();
                                  commentTime = '$minutes ${minutes == 1 ? 'minute' : 'minutes'} ago';
                                }
                                else if(time_elapsed_sec < 86400){
                                  final hours = (time_elapsed_sec / (60 * 60)).round();
                                  commentTime = '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
                                }
                                else{
                                  final days = (time_elapsed_sec / (60 * 60 * 24)).round();
                                  commentTime = '$days ${days == 1 ? 'day' : 'days'} ago';
                                }
                                final userID = commentData['userID'] as String;
                                return Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),                                      padding: EdgeInsets.symmetric(vertical: 8.0),
                                        child: StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection('users')
                                            .where('email', isEqualTo: userID)
                                            .snapshots(),
                                        builder: (BuildContext context, userSnapshot) {
                                          if (userSnapshot.hasError) {
                                            return Text('Error: ${userSnapshot.error}');
                                          }

                                          if (userSnapshot.connectionState == ConnectionState.waiting) {
                                            return CircularProgressIndicator();
                                          }
                                          String username;
                                          if (userSnapshot.data!.docs.isEmpty) {username = "Anonymous";}
                                          username = userSnapshot.data!.docs[0]['username'];
                                          return ListTile(
                                            title: Text(
                                              username,
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Text(content),
                                            trailing: Text(
                                              commentTime,
                                              style: TextStyle(color: Colors.grey),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 8.0), // added SizedBox with desired height
                                  ],
                                );
                              }).toList(),
                          ],
                        ),
                      );

                    },
                  ),
                ]
              ),
            ),
            )],
        ),
      ),
    );
  }
}
