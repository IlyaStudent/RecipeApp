import 'package:flutter/material.dart';
import 'package:project/models/recepie.dart';
import 'package:project/pages/recipe_page.dart';
import 'package:project/services/data_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _mealTypeFilter = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipe book"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _buildUI(),
      ),
    );
  }

  Widget _buildUI() {
    return Padding(
      padding: const EdgeInsets.all(
        10.0,
      ),
      child: Column(
        children: [
          _recipeTypeButtons(),
          _recipesList(),
        ],
      ),
    );
  }

  Widget _recipeTypeButtons() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.05,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5.0,
            ),
            child: FilledButton(
              onPressed: () {
                setState(() {
                  if (_mealTypeFilter.isEmpty) {
                    _mealTypeFilter = "snack";
                  } else {
                    _mealTypeFilter = "";
                  }
                });
              },
              child: const Text("🥕 Snack"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5.0,
            ),
            child: FilledButton(
              onPressed: () {
                setState(() {
                  if (_mealTypeFilter.isEmpty) {
                    _mealTypeFilter = "breakfast";
                  } else {
                    _mealTypeFilter = "";
                  }
                });
              },
              child: const Text("🍳 Breakfast"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5.0,
            ),
            child: FilledButton(
              onPressed: () {
                setState(() {
                  if (_mealTypeFilter.isEmpty) {
                    _mealTypeFilter = "lunch";
                  } else {
                    _mealTypeFilter = "";
                  }
                });
              },
              child: const Text("🍖 Lunch"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5.0,
            ),
            child: FilledButton(
              onPressed: () {
                setState(() {
                  if (_mealTypeFilter.isEmpty) {
                    _mealTypeFilter = "dinner";
                  } else {
                    _mealTypeFilter = "";
                  }
                });
              },
              child: const Text("🥩 Dinner"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _recipesList() {
    return Expanded(
        child: FutureBuilder(
      future: DataService().getRecepies(_mealTypeFilter),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text(
              "Unable to load data",
            ),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            Recepie recipe = snapshot.data![index];
            return ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return RecipePage(
                      recepie: recipe,
                    );
                  },
                ));
              },
              contentPadding: const EdgeInsets.only(
                top: 20.0,
              ),
              isThreeLine: true,
              subtitle: Text(
                "${recipe.cuisine}\nDifficulty: ${recipe.difficulty}",
              ),
              leading: Image.network(
                recipe.image,
              ),
              trailing: Text(
                "${recipe.rating.toString()} ⭐️",
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              title: Text(
                recipe.name,
              ),
            );
          },
        );
      },
    ));
  }
}
