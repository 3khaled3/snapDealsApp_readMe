import "dart:convert";
import "dart:developer";
import "dart:io";

import "package:dartz/dartz.dart";
import "package:http/http.dart" as http;
import "package:http_parser/http_parser.dart";
import 'package:flutter/foundation.dart';
import 'package:mime/mime.dart';

import "package:snap_deals/core/utils/hive_helper.dart";

enum HttpResponseStatus {
  noInternet,
  success,
  unAuthorized,
  invalidData,
  failure
}

isConnectedToInternet() async {
  try {
    if (!kIsWeb) {
      var result = await InternetAddress.lookup("google.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    }
    return true;
  } on SocketException catch (_) {
    return false;
  }
}

class FailureModel {
  String? message;
  HttpResponseStatus responseStatus;
  FailureModel({required this.responseStatus, this.message});
}

abstract class HttpHelper {
  // todo: post
  static Future<http.Response> postData({
    required String linkUrl,
    required Map data,
    required String? token,
  }) async {
    var headers = {
      if (token != null) 'Authorization': 'Bearer $token',
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var response = await http.post(
      Uri.parse(linkUrl),
      body: json.encode(data),
      headers: headers,
    );

    print("Response Status: ${response.statusCode}");
    print("Response Body: ${response.body}");

    return response;
  }

  // todo: get
  static Future<http.Response> getData({
    required String linkUrl,
    required String? token,
  }) async {
    var headers = {
      if (token != null) 'Authorization': 'Bearer $token', // Bearer scheme

      'Accept': 'application/json',
    };

    var response = await http.get(Uri.parse(linkUrl), headers: headers);

    print("Response Status: ${response.statusCode}");
    log("Response Body: ${response.body}");

    return response;
  }

  // todo: put
  static Future<http.Response> putData({
    required String linkUrl,
    required Map<String, dynamic> data,
    required String? token,
  }) async {
    var headers = {
      if (token != null) 'Authorization': 'Bearer $token', // Bearer scheme

      'accept': 'application/json',
      'Content-Type': 'application/json'
    };

    var response = await http.put(Uri.parse(linkUrl),
        body: json.encode(data), headers: headers);
      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("data : $data");
      print("linkUrl : $linkUrl");
    return response;
  }

  // todo: patch
  static Future<http.Response> patchData({
    required String linkUrl,
    required Map<String, dynamic> data,
    required String? token,
  }) async {
    var headers = {
      if (token != null) 'Authorization': 'Bearer $token', // Bearer scheme

      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };

    String jsonBody = json.encode(data);

    var response =
        await http.patch(Uri.parse(linkUrl), body: jsonBody, headers: headers);

    return response;
  }

  // todo: delete
  static Future<http.Response> deleteData({
    required String linkUrl,
    Map? data,
    required String? token,
  }) async {
    var headers = {
      if (token != null) 'Authorization': 'Bearer $token', // Bearer scheme

      'Accept': 'application/json',
    };

    var response =
        await http.delete(Uri.parse(linkUrl), body: data, headers: headers);

    print("Response Status: ${response.statusCode}");
    print("Response Body: ${response.body}");
    return response;
  }

  // todo: patch file
  static Future<http.Response> patchFile({
    required String linkUrl,
    required File file,
    required String name,
    required String? token,
    String? fieldName,
    Map<String, dynamic>? field,
  }) async {
    try {
      // Log the upload attempt
      print("Attempting to upload file...");

      // Create the multipart request
      var request = http.MultipartRequest('PATCH', Uri.parse(linkUrl));
      if (token != null) request.headers['Authorization'] = token;

      // Check if file exists
      if (!await file.exists()) {
        throw Exception("File not found at path: ${file.path}");
      }

      print("resss 1");

      // Determine the MIME type of the file
      var mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
      print("Detected MIME type: $mimeType");

      // Split the MIME type into type and subtype
      var mimeTypeData = mimeType.split('/');
      if (mimeTypeData.length != 2) {
        throw Exception("Invalid MIME type: $mimeType");
      }

      // Add the file to the request
      request.files.add(await http.MultipartFile.fromPath(
        name,
        file.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
      ));

      // Add the field
      if (fieldName != null && field != null) {
        request.fields[fieldName] = json.encode(field);
      }

      // Send the request
      final response = await request.send();

      // Convert the response to http.Response
      final http.Response res = await http.Response.fromStream(response);

      // Decode the response body
      var resFile = json.decode(res.body);

      // Log the response details
      print("Response Status: ${response.statusCode}");
      print("Response Headers: ${response.headers}");
      print("Response Body: ${res.body}");

      // Check for success
      if (response.statusCode != 200) {
        print("Failed to upload file: ${resFile['message']}");
      }

      return res;
    } catch (e) {
      // Log any errors
      print("Error in patchFile: $e");
      rethrow;
    }
  }

  // todo: patch file
  static Future<http.Response> putFile({
    required String linkUrl,
    required File file,
    required String name,
    required String? token,
    String? fieldName,
    Map<String, dynamic>? field,
  }) async {
    try {
      // Log the upload attempt
      print("Attempting to upload file...");

      // Create the multipart request
      var request = http.MultipartRequest('PUT', Uri.parse(linkUrl));

      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      // Check if file exists
      if (!await file.exists()) {
        throw Exception("File not found at path: ${file.path}");
      }

      print("resss 1");

      // Determine the MIME type of the file
      var mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
      print("Detected MIME type: $mimeType");

      // Split the MIME type into type and subtype
      var mimeTypeData = mimeType.split('/');
      if (mimeTypeData.length != 2) {
        throw Exception("Invalid MIME type: $mimeType");
      }

      // Add the file to the request
      request.files.add(await http.MultipartFile.fromPath(
        name,
        file.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
      ));

      // Add the field
      if (fieldName != null && field != null) {
        request.fields[fieldName] = json.encode(field);
      }

      // Send the request
      final response = await request.send();

      // Convert the response to http.Response
      final http.Response res = await http.Response.fromStream(response);

      // Decode the response body
      var resFile = json.decode(res.body);

      // Log the response details
      print("Response Status: ${response.statusCode}");
      print("Response Headers: ${response.headers}");
      print("Response Body: ${res.body}");

      // Check for success
      if (response.statusCode != 200) {
        print("Failed to upload file: ${resFile['message']}");
      }

      return res;
    } catch (e) {
      // Log any errors
      print("Error in patchFile: $e");
      rethrow;
    }
  }

  static Future<http.Response> editProfileFile({
    required String linkUrl,
    File? file,
    required String name,
    required String? token,
    Map<String, dynamic>? field,
  }) async {
    try {
      print("Attempting to upload file...");

      var request = http.MultipartRequest('PUT', Uri.parse(linkUrl));

      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      // Attach the image file if it exists
      if (file != null && await file.exists()) {
        var mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
        var mimeTypeData = mimeType.split('/');

        request.files.add(await http.MultipartFile.fromPath(
          name,
          file.path,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
        ));
      }

      // Add form fields
      if (field != null) {
        field.forEach((key, value) {
          request.fields[key] = value.toString();
        });
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      return response;
    } catch (e) {
      print("Error in putFile: $e");
      rethrow;
    }
  }

  // todo: post file
  static Future<http.Response> postFile({
    required String linkUrl,
    required File file,
    required String name,
    required String? token,
    required Map<String, dynamic> field, // لا داعي لـ fieldName
  }) async {
    try {
      print("Attempting to upload file...");

      var request = http.MultipartRequest('POST', Uri.parse(linkUrl));

      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      // 👇 إرسال كل key-value كـ field منفصل
      field.forEach((key, value) {
        request.fields[key] = value.toString(); // يجب أن يكونوا Strings
      });
      log("field: $field");
      final mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
      final mimeTypeData = mimeType.split('/');

      request.files.add(await http.MultipartFile.fromPath(
        name,
        file.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
      ));

      print("Sending request with fields: ${request.fields}");

      final response = await request.send();
      final http.Response res = await http.Response.fromStream(response);

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${res.body}");

      return res;
    } catch (e) {
      print("Error in postFile: $e");
      rethrow;
    }
  }

  // todo: post form
  // todo: patch form
  // todo: put form

  // todo: handle request
  static Future<Either<FailureModel, Map<String, dynamic>>> handleRequest(
    Future<http.Response> Function(String? token) requestFunction,
  ) async {
    try {
      if (await isConnectedToInternet()) {
        String customToken = HiveHelper.instance.getItem('customToken') ?? "";
        print("Custom Token: $customToken");
        // Perform the request with the token
        http.Response response = await requestFunction(customToken);

        if (response.statusCode == 200 ||
            response.statusCode == 201 ||
            response.statusCode == 204) {
          // Use utf8.decode to properly handle special characters in the response
          var decodedBody = utf8.decode(response.bodyBytes);

          // Log the response body for debugging
          if (decodedBody.trim().isEmpty) {
            return const Right(<String, dynamic>{});
          }
          return Right(jsonDecode(decodedBody));
        } else if (response.statusCode == 400 || response.statusCode == 401) {
          String? message = jsonDecode(utf8.decode(response.bodyBytes))['message'];

          return Left(FailureModel(
              responseStatus: HttpResponseStatus.invalidData,
              message: message));
        } else {
          String? message = jsonDecode(utf8.decode(response.bodyBytes))['message'];

          return Left(FailureModel(
              responseStatus: HttpResponseStatus.failure, message: message));
        }
      } else {
        return Left(
            FailureModel(responseStatus: HttpResponseStatus.noInternet));
      }
    } catch (e) {
      // Catch any error and provide a fallback response
      print("Error in handleRequest: $e");
      return Left(FailureModel(responseStatus: HttpResponseStatus.failure));
    }
  }
}
