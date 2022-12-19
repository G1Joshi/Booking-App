import 'package:booking_frontend/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  static final formKey = GlobalKey<FormState>();
  static final cityController = TextEditingController();
  static final checkinController = TextEditingController();
  static final checkoutController = TextEditingController();
  static final roomController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: InputField(
                      labelText: 'City',
                      controller: cityController,
                    ),
                  ),
                  Expanded(
                    child: InputField(
                      labelText: 'Checkin',
                      controller: checkinController,
                    ),
                  ),
                  Expanded(
                    child: InputField(
                      labelText: 'Checkout',
                      controller: checkoutController,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: InputField(
                      labelText: 'Rooms',
                      controller: roomController,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 50,
              width: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: BlocBuilder<HotelBloc, HotelState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          context.read<HotelBloc>().add(
                                SearchHotel(
                                  city: cityController.text,
                                  checkin: checkinController.text,
                                  checkout: checkinController.text,
                                  rooms: int.parse(roomController.text),
                                ),
                              );
                        }
                      },
                      child: state is HotelsLoaded
                          ? const Text(
                              'Search',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
