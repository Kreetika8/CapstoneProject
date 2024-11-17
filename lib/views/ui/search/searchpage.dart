import 'package:classico/constants/app_constants.dart';
import 'package:classico/views/common/app_style.dart';
import 'package:classico/views/common/custom_field.dart';
import 'package:classico/views/common/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController search = TextEditingController();
  TextEditingController jobTitle = TextEditingController();
  TextEditingController company = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();

  @override
  void dispose() {
    search.dispose();
    jobTitle.dispose();
    company.dispose();
    city.dispose();
    state.dispose();
    super.dispose();
  }

  void _showAdvancedSearchDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Advanced Search"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Job Title Field
                TextFormField(
                  controller: jobTitle,
                  decoration: const InputDecoration(
                    labelText: "Job Title",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                // Company Field
                TextFormField(
                  controller: company,
                  decoration: const InputDecoration(
                    labelText: "Company",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                // City Field
                TextFormField(
                  controller: city,
                  decoration: const InputDecoration(
                    labelText: "City",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                // State Field
                TextFormField(
                  controller: state,
                  decoration: const InputDecoration(
                    labelText: "State",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Handle Search functionality (pass input to search)
                Navigator.of(context).pop();
              },
              child: const Text("Search"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color(kOrange.value),
        iconTheme: IconThemeData(color: Color(kLight.value)),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: CustomField(
            hintText: "Search for a work",
            controller: search,
            suffixIcon: GestureDetector(
              onTap: () {
                // Implement search functionality
              },
              child: const Icon(AntDesign.search1),
            ),
            obscureText: false,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(AntDesign.filter),
            onPressed: _showAdvancedSearchDialog,
          ),
        ],
        elevation: 0,

        
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/search.jpg",
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Center(
              child: ReusableText(
                text: "Search for desired Work",
                style: appstyle(24, Color(kDark.value), FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
