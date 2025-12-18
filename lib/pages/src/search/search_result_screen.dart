import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_butailing/widgets/search_result_view.dart';

@RoutePage()
class SearchResultScreen extends StatefulWidget {
  final String keyword;
  const SearchResultScreen({super.key, required this.keyword});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.keyword), centerTitle: true),
      body: SearchResultView(keyword: widget.keyword),
    );
  }
}
