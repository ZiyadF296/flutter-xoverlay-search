import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'xwidgets/x-fad.dart';
import 'xwidgets/hover_extension.dart';

typedef void SelectedItemCallback(selected);

class RandomList extends StatefulWidget {
  final SelectedItemCallback selectedItemCallback;
  final Icon icon;
  final List<WordPair> dataList;
  final int selectedIndex;

  RandomList({
    @required this.icon,
    @required this.dataList,
    @required this.selectedIndex,
    this.selectedItemCallback,
    Key key,
  }) : super(key: key);

  @override
  _RandomListState createState() => _RandomListState(selectedIndex);
}

class _RandomListState extends State<RandomList> {
  int _selectedIndex = 0;

  _RandomListState(int selectedIndex) {
    _selectedIndex = selectedIndex;
  }

  @override
  Widget build(BuildContext context) => ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(0),
        itemCount: widget.dataList.length,
        itemBuilder: (context, index) {
          return XFAD(
            onHoverCallback: (bool value) => setState(() => _selectedIndex = index),
            child: Container(
              decoration: BoxDecoration(
                  color: _selectedIndex == index ? const Color.fromRGBO(220, 220, 220, 0.6) : Colors.transparent,
                  border: Border(
                    top: BorderSide(color: const Color.fromRGBO(220, 220, 220, 0.6)),
                    bottom: BorderSide(color: const Color.fromRGBO(220, 220, 220, 0.6)),
                    left: BorderSide(
                      color: _selectedIndex == index ? Theme.of(context).primaryColor : Colors.transparent,
                      width: 3,
                    ),
                  )),
              child: _tile(index),
            ).xShowPointerOnHover,
          );
        },
      );

  Widget _tile(index) => ListTile(
        hoverColor: Colors.transparent,
        leading: widget.icon,
        title: Text('${widget.dataList[index].first} - ${widget.dataList[index].second}'),
        onTap: () {
          if (widget.selectedItemCallback != null) widget.selectedItemCallback('${widget.dataList[index].first} - ${widget.dataList[index].second}');
        },
      );
}
