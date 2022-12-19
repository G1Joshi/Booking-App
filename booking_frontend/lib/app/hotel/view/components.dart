import 'package:booking_frontend/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Form(
              key: context.read<HotelBloc>().formKey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: InputField(
                      labelText: 'City',
                      controller: context.read<HotelBloc>().cityController,
                    ),
                  ),
                  Expanded(
                    child: InputField(
                      labelText: 'Checkin',
                      controller: context.read<HotelBloc>().checkinController,
                    ),
                  ),
                  Expanded(
                    child: InputField(
                      labelText: 'Checkout',
                      controller: context.read<HotelBloc>().checkoutController,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: InputField(
                      labelText: 'Rooms',
                      controller: context.read<HotelBloc>().roomController,
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
                        if (context
                                .read<HotelBloc>()
                                .formKey
                                .currentState
                                ?.validate() ??
                            false) {
                          context.read<HotelBloc>().add(const SearchHotel());
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
