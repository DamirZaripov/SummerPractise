//
//  AddLikeRequest.m
//  VKClient
//
//  Created by Damir Zaripov on 14.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import "AddLikeRequest.h"

@implementation AddLikeRequest {
    NSString *_type;
    NSNumber *_ownerID;
    NSNumber *_itemID;
}

- (instancetype)initWithType:(NSString *)type ownerID:(NSNumber *)ownerID itemID:(NSNumber *)itemID {
    self = [super init];
    if (self) {
        _type = type;
        _ownerID = ownerID;
        _itemID = itemID;
    }
    return self;
}

+ (instancetype)requestWithType:(NSString *)type ownerID:(NSNumber *)ownerID itemID:(NSNumber *)itemID {
    return [[self alloc] initWithType:type ownerID:ownerID itemID:itemID];
}

- (NSString *)httpMethod {
    return @"POST";
}

- (NSString *)endPoint {
    return @"likes.add";
}

- (NSDictionary *)paramsWithAuthToken:(NSString *)authToken version:(NSString *)version {
    return @{@"item_id": _itemID,
             @"owner_id": _ownerID,
             @"type": _type,
             @"access_token": authToken,
             @"v": version};
}

- (NSDictionary *)headers {
    return @{};
}

@end
