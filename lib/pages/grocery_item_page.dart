import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooderlich/models/grocery_item_model.dart';
import 'package:fooderlich/widgets/grocery_tile.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../models/app_state_manager.dart';

class GroceryItemPage extends ConsumerStatefulWidget {
  final Function(GroceryItem) onCreate;
  final Function(GroceryItem) onUpdate;
  final GroceryItem? originalItem;
  final bool isUpdating;
  final int index;
  const GroceryItemPage({
    super.key,
    required this.onCreate,
    required this.onUpdate,
    this.originalItem,
    this.index = -1,
  }) : isUpdating = (originalItem != null);
  //*Si isUpdating es verdadero, orignalItem es diferente a null

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GroceryItemPageState();
}

class _GroceryItemPageState extends ConsumerState<GroceryItemPage> {
  //*Controlamos el valor de la caja de texto
  final nameController = TextEditingController();
  //*Almacena el nombre del elemento
  String name = "";
  //*Nivel de importancia
  Importance importance = Importance.low;
  //*Fecha y hora actual
  DateTime dueDate = DateTime.now();
  //*Hora actual
  TimeOfDay _timeOfDay = TimeOfDay.now();
  Color currentColor = Colors.green;
  //*Cantidad de un articulo
  int currentSliderValue = 0;

  @override
  void initState() {
    super.initState();

    final originalItem = widget.originalItem;
    //*Cuando originalItem no es nulo, el usuario esta editando un elemento existente
    if (originalItem != null) {
      nameController.text = originalItem.name;
      name = originalItem.name;
      currentSliderValue = originalItem.quantity;
      importance = originalItem.importance;
      currentColor = originalItem.color;
      final date = originalItem.date;
      _timeOfDay = TimeOfDay(hour: date.hour, minute: date.minute);
      dueDate = date;
    }
    nameController.addListener(() {
      setState(() {
        name = nameController.text;
      });
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              final groceryItem = GroceryItem(
                id: widget.originalItem?.id ?? const Uuid().v1(),
                name: nameController.text,
                importance: importance,
                color: currentColor,
                quantity: currentSliderValue,
                date: DateTime(
                  dueDate.year,
                  dueDate.month,
                  dueDate.day,
                  _timeOfDay.hour,
                  _timeOfDay.minute,
                ),
                isComplete: false,
              );
              if (widget.isUpdating) {
                widget.onUpdate(groceryItem);
              } else {
                widget.onCreate(groceryItem);
              }

              context.goNamed(
                'home',
                params: {
                  'tab': '${FooderlichTab.toBuy}',
                },
              );
            },
          )
        ],
        elevation: 0.0,
        title: Text(
          "Grocery Item",
          style: GoogleFonts.lato(fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            //*TextField
            buildNameField(),
            //*Chips
            buildImportanceField(),
            //*DatePicker
            buildDateField(context),
            //*Selector de Hora
            buildTimeField(context),
            //*ColorPicker
            buildColorPicker(context),
            //*Slider
            buildQuantityField(),
            //*Tile
            GroceryTile(
              item: GroceryItem(
                id: widget.originalItem?.id ?? const Uuid().v1(),
                name: nameController.text,
                importance: importance,
                color: currentColor,
                quantity: currentSliderValue,
                date: DateTime(
                  dueDate.year,
                  dueDate.month,
                  dueDate.day,
                  _timeOfDay.hour,
                  _timeOfDay.minute,
                ),
                isComplete: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //*Metodo que retorna un TextField
  Widget buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Item Name",
          style: GoogleFonts.lato(fontSize: 28),
        ),
        TextField(
          controller: nameController,
          cursorColor: currentColor,
          decoration: InputDecoration(
            hintText: "E.g. Apple,Bananas, 1 Bag of Salt",
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: currentColor),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: currentColor),
            ),
          ),
        )
      ],
    );
  }

  //*Metodo que retorna una seleccion de Chips
  //*Selecciona la Importancia del producto
  Widget buildImportanceField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Importance",
          style: GoogleFonts.lato(fontSize: 28.0),
        ),
        const SizedBox(
          height: 10,
        ),
        Wrap(
          spacing: 10.0,
          children: [
            ChoiceChip(
              selectedColor: Colors.black,
              selected: importance == Importance.low,
              label: const Text(
                "low",
                style: TextStyle(color: Colors.white),
              ),
              onSelected: (selected) {
                setState(() {
                  importance = Importance.low;
                });
              },
            ),
            ChoiceChip(
              selectedColor: Colors.black,
              selected: importance == Importance.medium,
              label: const Text(
                'medium',
                style: TextStyle(color: Colors.white),
              ),
              onSelected: (selected) {
                setState(() => importance = Importance.medium);
              },
            ),
            ChoiceChip(
              selectedColor: Colors.black,
              selected: importance == Importance.high,
              label: const Text(
                'high',
                style: TextStyle(color: Colors.white),
              ),
              onSelected: (selected) {
                setState(() => importance = Importance.high);
              },
            ),
          ],
        ),
      ],
    );
  }

  //*Metodo para seleccionar una fecha limite para comprar el articulo
  Widget buildDateField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Date",
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
            TextButton(
              child: const Text("Select"),
              onPressed: () async {
                final currentDate = DateTime.now();
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: currentDate,
                  firstDate: currentDate,
                  //*Fecha limite del DataPicker
                  lastDate: DateTime(currentDate.year + 5),
                );
                setState(() {
                  //*Si la fecha seleccionada es diferente de null
                  //*Establece esa fecha
                  if (selectedDate != null) {
                    dueDate = selectedDate;
                  }
                });
              },
            ),
          ],
        ),
        Text(
          DateFormat("yyyy-MM-dd").format(dueDate),
        ),
      ],
    );
  }

  //*Metodo para seleccionar la hora
  Widget buildTimeField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Time of Day",
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
            TextButton(
              child: const Text("Select"),
              onPressed: () async {
                final timeOfDay = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                setState(() {
                  if (timeOfDay != null) {
                    _timeOfDay = timeOfDay;
                  }
                });
              },
            ),
          ],
        ),
        Text(
          _timeOfDay.format(context),
        ),
      ],
    );
  }

  //*Funcion para seleccionar el Color
  Widget buildColorPicker(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            //*Container que mostrara el color seleccionado
            //*Por defecto color verde
            Container(
              height: 50,
              width: 10,
              color: currentColor,
            ),
            const SizedBox(width: 8),
            Text(
              "Color",
              style: GoogleFonts.lato(fontSize: 28),
            ),
          ],
        ),
        TextButton(
          child: const Text("Select"),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: BlockPicker(
                    pickerColor: Colors.white,
                    //*Seleccionar el color
                    onColorChanged: (color) {
                      setState(
                        () {
                          currentColor = color;
                        },
                      );
                    },
                  ),
                  actions: [
                    TextButton(
                      child: const Text("Save"),
                      onPressed: () {
                        Navigator.of(context).pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }

  //*Metodo Slider para seleccionar la cantidad de articulos
  Widget buildQuantityField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              "Quantity",
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              currentSliderValue.toInt().toString(),
              style: GoogleFonts.lato(fontSize: 18),
            ),
          ],
        ),
        Slider(
          inactiveColor: currentColor.withOpacity(0.5),
          activeColor: currentColor,
          value: currentSliderValue.toDouble(),
          min: 0.0,
          max: 100.0,
          divisions: 100,
          label: currentSliderValue.toInt().toString(),
          onChanged: (double value) {
            setState(() {
              currentSliderValue = value.toInt();
            });
          },
        )
      ],
    );
  }
}
