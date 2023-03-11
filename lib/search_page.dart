import 'package:flutter/material.dart';
import 'movie_model.dart';

/*Auxiliary functions to clean the search bar*/
TextEditingController _textEditingController = TextEditingController();

void clearTextInput() {
  _textEditingController.clear();
}

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  static List<MovieModel> mainMoviesList = [
    MovieModel("La la land", "2016", 8, "assets/llland.png"),
    MovieModel("Inception", "2010", 8.8, "assets/inception.png"),
    MovieModel("Silence of the Lambs", "1991", 8.6, "assets/silenceLambs.png"),
    MovieModel("Incendies", "2010", 8.3, "assets/Incendies.png")
  ];

  List<MovieModel> displayList = List.from(mainMoviesList);

  void updateList(String value) {
    setState(() {
      displayList = mainMoviesList
          .where((element) =>
          element.movieTitle.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(6, 10, 43, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(6, 10, 43, 1),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Search for a Movie or a Series",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: _textEditingController,
              onChanged: (value) => updateList(value),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xff302360),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "example: Mad men",
                prefixIcon: const Icon(Icons.search, size: 30.0),
                prefixIconColor: Colors.white,
                suffixIcon: const IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: clearTextInput,
                ),
                suffixIconColor: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: displayList.isEmpty
                  ? const Center(
                child: Text(
                  "No results found :(",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: displayList.length,
                itemBuilder: (context, index) => ListTile(
                  contentPadding: const EdgeInsets.all(8.0),
                  title: Text(
                    displayList[index].movieTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    displayList[index].movieReleaseYear,
                    style: const TextStyle(
                      color: Colors.white60,
                    ),
                  ),
                  trailing: Text(
                    '${displayList[index].rating}',
                    style: const TextStyle(color: Colors.amber),
                  ),
                  leading:
                  Image.asset(displayList[index].moviePoster),
                ),
              ), // <-- add comma here
            )
          ],
        ),
      ),
    );
  }
}
