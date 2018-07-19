//
//  FetchNewsfeedRequest.m
//  VKClient
//
//  Created by Damir Zaripov on 13.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import "FetchNewsfeedRequest.h"

@implementation FetchNewsfeedRequest {
    NSNumber *_count;
    NSNumber *_maxPhotos;
    NSString *_startFrom;
}

- (instancetype)initWithCount:(NSNumber *)count maxPhotos:(NSNumber *)maxPhotos startFrom:(NSString *)startFrom {
    self = [super init];
    if (self) {
        _count = count;
        _maxPhotos = maxPhotos;
        _startFrom = startFrom;
    }
    return self;
}

+ (instancetype)requestWithCount:(NSNumber *)count maxPhotos:(NSNumber *)maxPhotos startFrom:(NSString *)startFrom {
    return [[self alloc] initWithCount:count maxPhotos:maxPhotos startFrom:startFrom];
}

- (NSString *)httpMethod {
    return @"GET";
}

- (NSString *)endPoint {
    return @"newsfeed.get";
}

- (NSDictionary *)paramsWithAuthToken:(NSString *)authToken version:(NSString *)version {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"post" forKey:@"filters"];
    [params setObject:_count forKey:@"count"];
    [params setObject:_maxPhotos forKey:@"max_photos"];
    [params setObject:authToken forKey:@"access_token"];
    [params setObject:version forKey:@"v"];
    
    if (_startFrom) {
        [params setObject:_startFrom forKey:@"start_from"];
    }
    return params;
}

- (NSDictionary *)headers {
    return @{};
}

@end
