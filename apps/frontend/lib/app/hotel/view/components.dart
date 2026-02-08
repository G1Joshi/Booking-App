import 'package:booking_frontend/app/app.dart';
import 'package:booking_models/booking_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';

class SearchBarView extends StatelessWidget {
  const SearchBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
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
                      labelText: 'Distance',
                      controller: HotelBloc.distanceController,
                    ),
                  ),
                  Expanded(
                    child: InputField(
                      labelText: 'Checkin',
                      controller: HotelBloc.checkinController,
                    ),
                  ),
                  Expanded(
                    child: InputField(
                      labelText: 'Checkout',
                      controller: HotelBloc.checkoutController,
                    ),
                  ),
                  Expanded(
                    child: InputField(
                      labelText: 'Rooms',
                      controller: HotelBloc.roomController,
                    ),
                  ),
                  Expanded(
                    child: InputField(
                      labelText: 'Guests',
                      controller: HotelBloc.guestController,
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
                      child: state is HotelsSearching
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Search',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterTile extends StatefulWidget {
  const FilterTile({
    required this.title,
    required this.filters,
    super.key,
  });

  final String title;
  final List<FilterModel> filters;

  @override
  State<FilterTile> createState() => _FilterTileState();
}

class _FilterTileState extends State<FilterTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.filters.length,
          itemBuilder: (context, index) {
            final data = widget.filters[index];
            return CheckboxListTile(
              dense: true,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(data.name),
              value: data.isSelected,
              onChanged: (value) => setState(() {
                data.isSelected = !data.isSelected;
                context.read<HotelBloc>().add(const FilterHotel());
              }),
            );
          },
        ),
      ],
    );
  }
}

class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Drawer(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: ListView.builder(
                itemBuilder: (_, _) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 50,
                        height: 50,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 120,
                              height: 10,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 2,
                              ),
                            ),
                            Container(
                              width: 80,
                              height: 10,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 2,
                              ),
                            ),
                            Container(
                              width: 40,
                              height: 10,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 32),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: ListView.builder(
                itemBuilder: (_, _) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 300,
                        height: 200,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 4,
                              height: 40,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 2,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 2,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: 40,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RatingAndReviewForm extends StatefulWidget {
  const RatingAndReviewForm({required this.id, super.key});

  final int id;

  @override
  State<RatingAndReviewForm> createState() => _RatingAndReviewFormState();
}

class _RatingAndReviewFormState extends State<RatingAndReviewForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width / 2,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Form(
        key: context.read<HotelBloc>().reviewFormKey,
        child: Column(
          children: [
            RatingBar.builder(
              initialRating: context.read<HotelBloc>().rating,
              minRating: 0.5,
              allowHalfRating: true,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.blueAccent,
              ),
              onRatingUpdate: (rating) {
                context.read<HotelBloc>().rating = rating;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              minLines: 2,
              maxLines: 3,
              controller: context.read<HotelBloc>().reviewController,
              validator: (value) =>
                  value == null || value.isEmpty ? "Value can't be null" : null,
              decoration: const InputDecoration(
                labelText: 'Your Review',
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 50,
              width: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: ElevatedButton(
                  onPressed: () {
                    if (context
                            .read<HotelBloc>()
                            .reviewFormKey
                            .currentState
                            ?.validate() ??
                        false) {
                      context.read<HotelBloc>().add(AddReview(widget.id));
                    }
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
