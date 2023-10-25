

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
@immutable
class BaseError extends Equatable {
    final String? message;

    const BaseError({
        this.message,
    });
    BaseError copyWith({
        String? message,
    }) => 
        BaseError(
            message: message ?? this.message,
        );

    factory BaseError.fromJson(Map<String, dynamic> json) => BaseError(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };

@override
List<Object?> get props => [message];
}