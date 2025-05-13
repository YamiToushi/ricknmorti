import 'package:flutter/material.dart';
import 'package:ricknmorti/models/character.dart';

void showCharacterDetails(BuildContext context, Character character) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,

    builder: (context) => DraggableScrollableSheet(
      expand: true,
      builder: (context, scrollController) => SingleChildScrollView(
        controller: scrollController,
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(character.image),
              SizedBox(height: 8),
              Text(
                character.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text('Status: ${character.status}'),
              Text('Species: ${character.species}'),
           
            ],
          ),
        ),
      ),
    ),
  );
}
