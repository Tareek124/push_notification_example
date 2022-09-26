// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> callOnFcmApiSendPushNotifications({
  required String title,
  required String imageUrl,
  required String description,
  required String price,
}) async {
  const postUrl = 'https://fcm.googleapis.com/fcm/send';
  final data = {
    "to":
        "c2Y6A07uTX-H2GN0xcoDCB:APA91bH4-1M_kFhzhoV_EPgFt9iUeviRnLsOJkhMGWzkuQY4mefsJbczXSmlxjPrTexnhkLA0FHhB1VLn8hKbuEZ0RmJ3UoojSpeZ-J7PvqKi5g3J7hOjcLLS-BJXYHvM5hRI0hyOSsV",
    "notification": {
      "title": title,
      "body": description,
      "image": imageUrl,
    },
    "data": {
      "type": '0rder',
      "id": "28",
      "click_action": 'FLUTTER_NOTIFICATION_CLICK',
      'title': title,
      'imageurl': imageUrl,
      'description': description,
      'price': price,
    },
  };

  final headers = {
    'content-type': 'application/json',
    'Authorization':
        'key=AAAANOszFWI:APA91bFJ98BjWsj7xGRNA4EtHLF8WXHS5vyY_ahoxSgRT_PNEVirbFspH8LLn1N1v7HKnlkKLDJiZ5QPG7twCHedeiLN6mY9D19cM5OH5q8SIM-OYTasxddk1iZTH8hiocTeGZmL-nas' // 'key=YOUR_SERVER_KEY'
  };

  final response = await http.post(Uri.parse(postUrl),
      body: json.encode(data),
      encoding: Encoding.getByName('utf-8'),
      headers: headers);

  if (response.statusCode == 200) {
    print('Push Notification Succeded');
  } else {
    print('Push Notification Error');
  }
}
