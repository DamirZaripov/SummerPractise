//
//  FetchCommentsRequest.m
//  VKClient
//
//  Created by Damir Zaripov on 14.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import "FetchCommentsRequest.h"

@implementation FetchCommentsRequest {
    NSNumber *_postID;
    NSNumber *_ownerID;
    NSNumber *_extended;
    NSArray<NSString *> *_fields;
}

- (instancetype) initWithPostID:(NSNumber *)postID ownerID:(NSNumber *)ownerID extended:(NSNumber *)extended fields:(NSArray<NSString *> *)fields {
    self = [super init];
    if (self) {
        _postID = postID;
        _ownerID = ownerID;
        _extended = extended;
        _fields = fields;
    }
    return self;
}

+ (instancetype) requestWithPostID:(NSNumber *)postID ownerID:(NSNumber *)ownerID extended:(NSNumber *)extended fields:(NSArray<NSString *> *)fields {
    return [[self alloc] initWithPostID:postID ownerID:ownerID extended:extended fields:fields];
}

- (NSString *)httpMethod {
    return @"GET";
}

- (NSString *)endPoint {
    return @"wall.getComments";
}

- (NSDictionary *)paramsWithAuthToken:(NSString *)authToken version:(NSString *)version {
    return @{@"post_id": _postID,
             @"owner_id": _ownerID,
             @"extended": _extended,
             @"fields": [_fields componentsJoinedByString:@","],
             @"access_token": authToken,
             @"v": version};
}

- (NSDictionary *)headers {
    return @{};
}

@end
