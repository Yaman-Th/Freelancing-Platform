import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OScreen extends StatefulWidget {
  @override
  _OScreenState createState() => _OScreenState();
}

class _OScreenState extends State<OScreen> {
  Future<List<Proposal>> fetchOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('http://localhost:8000/api/proposals'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> outerData = json.decode(response.body);

      if (outerData.isNotEmpty && outerData[0] is List) {
        final List<dynamic> data = outerData[0];

        List<Proposal> orders =
            data.map((orderJson) => Proposal.fromJson(orderJson)).toList();
        return orders;
      } else {
        throw Exception('Unexpected JSON format');
      }
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<void> approveOrder(int postId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.put(
      Uri.parse('http://localhost:8000/api/proposals/accept/$postId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      setState(() {
        futureOrders = fetchOrders();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to approve the order')),
      );
    }
  }

  Future<void> rejectOrder(int postId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.put(
      Uri.parse('http://localhost:8000/api/proposals/reject/$postId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data['message'])),
      );

      setState(() {
        futureOrders = fetchOrders();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to reject the order')),
      );
    }
  }

  late Future<List<Proposal>> futureOrders;

  @override
  void initState() {
    super.initState();
    futureOrders = fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Proposal>>(
        future: futureOrders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No orders found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final order = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Center(
                          child: Text(
                            'Order: ${order.id}',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Status: ${order.status}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          order.comment!,
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Date: ${order.date}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                approveOrder(order.postId!);
                              },
                              child: Text(
                                'Accept',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                rejectOrder(order.postId!);
                              },
                              child: Text(
                                'Reject',
                                style: TextStyle(color: Colors.red),
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
        },
      ),
    );
  }
}

class Proposal {
  int? id;
  int? postId;
  int? freelancerId;
  String? comment;
  String? status;
  String? date;
  String? createdAt;
  String? updatedAt;

  Proposal(
      {this.id,
      this.postId,
      this.freelancerId,
      this.comment,
      this.status,
      this.date,
      this.createdAt,
      this.updatedAt});

  Proposal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['post_id'];
    freelancerId = json['freelancer_id'];
    comment = json['comment'];
    status = json['status'];
    date = json['date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['post_id'] = this.postId;
    data['freelancer_id'] = this.freelancerId;
    data['comment'] = this.comment;
    data['status'] = this.status;
    data['date'] = this.date;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
