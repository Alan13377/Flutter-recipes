import 'package:flutter/material.dart';
import 'package:fooderlich/models/grocery_item_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

//**Tile del producto agregado */
class GroceryTile extends StatelessWidget {
  final GroceryItem item;
  final Function(bool?)? onComplete;
  final TextDecoration textDecoration;
  GroceryTile({
    super.key,
    required this.item,
    this.onComplete,
  }) : textDecoration =
            item.isComplete ? TextDecoration.lineThrough : TextDecoration.none;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //*Informacion
          Row(
            children: [
              Container(width: 5.0, color: item.color),
              // 3
              const SizedBox(width: 16.0),
              // 4
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 5
                  Text(
                    item.name,
                    style: GoogleFonts.lato(
                      decoration: textDecoration,
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  buildDate(),
                  const SizedBox(height: 4.0),
                  buildImportance(),
                ],
              ),
            ],
          ),
          //*Cantidad y CheckBox
          Row(
            children: [
              Text(
                item.quantity.toString(),
                style: GoogleFonts.lato(
                  decoration: textDecoration,
                  fontSize: 21.0,
                ),
              ),
              buildCheckbox(),
            ],
          ),
        ],
      ),
    );
  }

  //*Metodo que devuelve un widget al tile que muestra la importancia seleccionada
  Widget buildImportance() {
    if (item.importance == Importance.low) {
      return Text(
        "low",
        style: GoogleFonts.lato(
          decoration: textDecoration,
        ),
      );
    } else if (item.importance == Importance.medium) {
      return Text(
        "Medium",
        style: GoogleFonts.lato(
          decoration: textDecoration,
          fontWeight: FontWeight.w800,
        ),
      );
    } else if (item.importance == Importance.high) {
      return Text(
        'High',
        style: GoogleFonts.lato(
          color: Colors.red,
          fontWeight: FontWeight.w900,
          decoration: textDecoration,
        ),
      );
    } else {
      throw Exception('This importance type does not exist');
    }
  }

  //*Metodo que retorna la fecha
  Widget buildDate() {
    final dateFormatter = DateFormat("MMMM dd h:mm a");
    final dateString = dateFormatter.format(item.date);
    return Text(
      dateString,
      style: TextStyle(decoration: textDecoration),
    );
  }

  //* Metodo que retorna un Checkbox y su estado
  Widget buildCheckbox() {
    return Checkbox(
      value: item.isComplete,
      onChanged: onComplete,
    );
  }
}
