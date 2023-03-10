import 'package:flutter/material.dart';
import 'profile-page.dart';
import 'movie_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // set to false to remove debug banner
      home: Scaffold(
        body: MyHomePage(title: "myApp"),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/*Funções auxiliare spara limpar o texto da search bar*/
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
  static List<MovieModel> main_movies_list = [
    MovieModel("La la land", 2016, 8, "assets/llland.png"),
    MovieModel("Inception", 2010, 8.8, "assets/inception.png"),
    MovieModel("Silence of the Lambs", 1991, 8.6, "assets/silenceLambs.png"),
    MovieModel("Incendies", 2010, 8.3, "assets/Incendies.png")
  ];

  List<MovieModel> display_list = List.from(main_movies_list);

  void updateList(String value) {
    setState(() {
      display_list = main_movies_list
          .where((element) =>
              element.movie_title!.toLowerCase().contains(value.toLowerCase()))
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
              child: display_list.isEmpty
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
                      itemCount: display_list.length,
                      itemBuilder: (context, index) => ListTile(
                        contentPadding: const EdgeInsets.all(8.0),
                        title: Text(
                          display_list[index].movie_title!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          '${display_list[index].movie_release_year}',
                          style: const TextStyle(
                            color: Colors.white60,
                          ),
                        ),
                        trailing: Text(
                          '${display_list[index].rating}',
                          style: const TextStyle(color: Colors.amber),
                        ),
                        leading:
                            Image.asset('${display_list[index].movie_poster}'),
                      ),
                    ), // <-- add comma here
            )
          ],
        ),
      ),
    );
  }
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(6, 10, 43, 1),
      body: Stack(
        children: [
          Positioned(
            bottom: 5,
            left: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
              child: Container(
                width: 65,
                height: 65,
                color: Colors.transparent,
                child: Image.asset(
                  'assets/profile-icon.png',
                  width: 65.0,
                  height: 65.0,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -5,
            right: -15,
            child: Image.asset(
              'assets/logo.png',
              width: 90.0,
              height: 90.0,
            ),
          ),
          Positioned(
            bottom: 5,
            right: 170,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchPage()),
                );
              },
              child: Container(
                width: 65,
                height: 65,
                color: Colors.transparent,
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 50.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
