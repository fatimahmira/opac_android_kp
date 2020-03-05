import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imgURL;
  final String nama;
  final String price;
  final TextStyle textStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.grey[800]
  );
ProductCard({this.imgURL="", this.nama ="", this.price=""});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 150,
          height: 250,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.9),
                    blurRadius: 6,
                    offset: Offset(1, 1))
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 150,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(imgURL),
                        fit: BoxFit.fill
                      )
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Text(nama, style: textStyle,),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5, right: 5),
                    child: Text(price, style: textStyle.copyWith(fontSize: 12),),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
