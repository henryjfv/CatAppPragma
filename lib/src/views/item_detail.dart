import 'package:cats_app/src/models/cat.dart';
import 'package:flutter/material.dart';

class ItemDetail extends StatelessWidget {
  final Cat itemCat;
  const ItemDetail({super.key, required this.itemCat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(itemCat.name ?? "No name"),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            color: Colors.grey,
            child: Center(
              child: itemCat.referenceImageId != ""
                  ? (SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Image.network(
                        "https://cdn2.thecatapi.com/images/${itemCat.referenceImageId}.jpg",
                        errorBuilder: (context, error, stackTrace) =>
                            const Text("No imagen"),
                        fit: BoxFit.cover,
                      ),
                    ))
                  : Text("No image"),
            ),
          ),
          Expanded(
              child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              _buildText('Origin', itemCat.origin),
              _buildText('Description', itemCat.description),
              _buildText('Weight', itemCat.weight?.toString()),
              _buildText('Temperament', itemCat.temperament),
              _buildText('Country Codes', itemCat.countryCodes),
              _buildText('Country Code', itemCat.countryCode),
              _buildText('Life Span', itemCat.lifeSpan),
              _buildText('Indoor', itemCat.indoor?.toString()),
              _buildText('Lap', itemCat.lap?.toString()),
              _buildText('Alt Names', itemCat.altNames),
              _buildText('Adaptability', itemCat.adaptability?.toString()),
              _buildText('Affection Level', itemCat.affectionLevel?.toString()),
              _buildText('Child Friendly', itemCat.childFriendly?.toString()),
              _buildText('Dog Friendly', itemCat.dogFriendly?.toString()),
              _buildText('Energy Level', itemCat.energyLevel?.toString()),
              _buildText('Grooming', itemCat.grooming?.toString()),
              _buildText('Health Issues', itemCat.healthIssues?.toString()),
              _buildText('Intelligence', itemCat.intelligence?.toString()),
              _buildText('Shedding Level', itemCat.sheddingLevel?.toString()),
              _buildText('Social Needs', itemCat.socialNeeds?.toString()),
              _buildText(
                  'Stranger Friendly', itemCat.strangerFriendly?.toString()),
              _buildText('Vocalisation', itemCat.vocalisation?.toString()),
              _buildText('Experimental', itemCat.experimental?.toString()),
              _buildText('Hairless', itemCat.hairless?.toString()),
              _buildText('Natural', itemCat.natural?.toString()),
              _buildText('Rare', itemCat.rare?.toString()),
              _buildText('Rex', itemCat.rex?.toString()),
              _buildText('Suppressed Tail', itemCat.suppressedTail?.toString()),
              _buildText('Short Legs', itemCat.shortLegs?.toString()),
              _buildText('Wikipedia URL', itemCat.wikipediaUrl),
              _buildText('Hypoallergenic', itemCat.hypoallergenic?.toString()),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildText(String label, String? value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            value ?? 'N/A',
            style: TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}
