import 'package:booking_frontend/app/app.dart';
import 'package:booking_frontend/data/data.dart';
import 'package:booking_frontend/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HotelDetailsPage extends StatelessWidget {
  const HotelDetailsPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HotelBloc()..add(GetHotelDetails(id)),
      child: const HotelDetailsView(),
    );
  }
}

class HotelDetailsView extends StatefulWidget {
  const HotelDetailsView({super.key});

  @override
  State<HotelDetailsView> createState() => _HotelDetailsViewState();
}

class _HotelDetailsViewState extends State<HotelDetailsView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SignedOut) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute<HotelPage>(
              builder: (context) => const AuthPage(),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(const SignOut());
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.shade900,
                Colors.blue.shade700,
                Colors.blue.shade500
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: BlocBuilder<HotelBloc, HotelState>(
                    builder: (context, state) {
                      if (state is HotelDetailsLoaded) {
                        final hotel = state.hotel;
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      hotel.coverImage,
                                      fit: BoxFit.cover,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.5,
                                      width: MediaQuery.of(context).size.width /
                                          1.4,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    children: [
                                      hotelImage(
                                        state.hotel.details!.hotelImages[0],
                                        context,
                                      ),
                                      const SizedBox(height: 4),
                                      hotelImage(
                                        state.hotel.details!.hotelImages[1],
                                        context,
                                      ),
                                      const SizedBox(height: 4),
                                      hotelImage(
                                        state.hotel.details!.hotelImages[2],
                                        context,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          color: Colors.blue.shade600,
                                          child: Text(
                                            hotel.rating.toStringAsFixed(1),
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        getGrade(hotel.rating),
                                        style: TextStyle(
                                          color: Colors.blue.shade600,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Text(
                                        hotel.name,
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue.shade900,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Row(
                                        children: List.generate(
                                          hotel.star,
                                          (index) => const Icon(
                                            Icons.star_rate_rounded,
                                            size: 16,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Rooms Starting From: ',
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '₹${hotel.roomsStartingPrice}',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.green.shade900,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32),
                              const Text(
                                'Select Rooms',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              roomsList(state.hotel),
                              const SizedBox(height: 32),
                              const Text(
                                'User Ratings & Reviews',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              reviewsList(state.hotel),
                              const SizedBox(height: 16),
                              RatingAndReviewForm(id: state.hotel.id),
                            ],
                          ),
                        );
                      } else if (state is HotelsLoading) {
                        return const ShimmerLoader();
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ClipRRect hotelImage(String image, BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        image,
        fit: BoxFit.cover,
        height: MediaQuery.of(context).size.height / (1.5 * 3),
        width: MediaQuery.of(context).size.width / (1.5 * 3),
      ),
    );
  }

  ClipRRect roomImage(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        image,
        fit: BoxFit.cover,
        height: 50,
        width: 130,
      ),
    );
  }

  ListView roomsList(Hotel hotel) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: hotel.rooms?.length ?? 0,
      separatorBuilder: (context, index) => const SizedBox(height: 32),
      itemBuilder: (context, index) {
        final room = hotel.rooms![index];
        return Card(
          child: Row(
            children: [
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      room.roomImages[0],
                      fit: BoxFit.cover,
                      height: 200,
                      width: 400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      roomImage(room.roomImages[1]),
                      const SizedBox(width: 4),
                      roomImage(room.roomImages[2]),
                      const SizedBox(width: 4),
                      roomImage(room.roomImages[3]),
                    ],
                  )
                ],
              ),
              const SizedBox(width: 32),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    room.category,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        width: 4,
                        padding: const EdgeInsets.all(4),
                        color: Colors.blue.shade900,
                        child: const Text(
                          '',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        color: Colors.blue.shade100,
                        child: Text(
                          room.description,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${room.amenities}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Room Price: ',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        TextSpan(
                          text: '₹${room.price}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.green.shade900,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 40,
                    width: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Book',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  ListView reviewsList(Hotel hotel) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: hotel.reviews?.length ?? 0,
      separatorBuilder: (context, index) => const SizedBox(height: 32),
      itemBuilder: (context, index) {
        final review = hotel.reviews![index];
        return Card(
          child: ListTile(
            isThreeLine: true,
            leading: CircleAvatar(
              backgroundImage: NetworkImage(review.profileImage),
              radius: 25,
            ),
            title: Row(
              children: [
                Text(
                  review.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),
                const SizedBox(width: 8),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        color: Colors.blue.shade600,
                        child: Text(
                          review.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      getGrade(review.rating),
                      style: TextStyle(
                        color: Colors.blue.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
            subtitle: Text(
              review.review,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            trailing: SizedBox(
              height: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context
                      .read<HotelBloc>()
                      .add(DeleteReview(hotel.id, review.id));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                ),
                child: const Icon(Icons.delete),
              ),
            ),
          ),
        );
      },
    );
  }
}
