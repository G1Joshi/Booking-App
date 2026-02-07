import 'package:booking_frontend/app/app.dart';
import 'package:booking_frontend/data/data.dart';
import 'package:booking_frontend/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HotelPage extends StatelessWidget {
  const HotelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HotelBloc()..add(const GetAllHotels()),
      child: const HotelView(),
    );
  }
}

class HotelView extends StatefulWidget {
  const HotelView({super.key});

  @override
  State<HotelView> createState() => _HotelViewState();
}

class _HotelViewState extends State<HotelView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is SignedOut) {
          await Navigator.pushReplacement(
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
                Colors.blue.shade500,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SearchBarView(),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 1.15,
                        width: MediaQuery.of(context).size.width,
                        child: BlocBuilder<HotelBloc, HotelState>(
                          builder: (context, state) {
                            if (state is HotelsLoaded) {
                              return Row(
                                children: [
                                  Drawer(child: filtersList()),
                                  const SizedBox(width: 32),
                                  Expanded(
                                    child: state.hotels.isEmpty
                                        ? Center(
                                            child: Text(
                                              'No Hotels Available',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue.shade900,
                                              ),
                                            ),
                                          )
                                        : hotelsList(state.hotels),
                                  ),
                                ],
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ListView filtersList() {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Select Filters',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        FilterTile(
          title: 'Star Category',
          filters: FilterModel.starCategory,
        ),
        FilterTile(
          title: 'Property Type',
          filters: FilterModel.propertyType,
        ),
        FilterTile(
          title: 'Budget (Per Night)',
          filters: FilterModel.budget,
        ),
        FilterTile(
          title: 'User Rating',
          filters: FilterModel.userRating,
        ),
      ],
    );
  }

  ListView hotelsList(List<Hotel> hotels) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: hotels.length,
      separatorBuilder: (context, index) => const SizedBox(height: 32),
      itemBuilder: (context, index) {
        final hotel = hotels[index];
        return GestureDetector(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute<HotelDetailsPage>(
                builder: (context) => HotelDetailsPage(id: hotel.id),
              ),
            );
          },
          child: Card(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    hotel.coverImage,
                    fit: BoxFit.cover,
                    height: 200,
                    width: 300,
                  ),
                ),
                const SizedBox(width: 32),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
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
                    const SizedBox(height: 8),
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
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
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
                            hotel.propertyType,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
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
              ],
            ),
          ),
        );
      },
    );
  }
}
