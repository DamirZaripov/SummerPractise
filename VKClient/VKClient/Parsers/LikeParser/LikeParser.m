//
//  LikeParser.m
//  VKClient
//
//  Created by Damir Zaripov on 14.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import "LikeParser.h"

@implementation LikeParser

- (NSNumber *)parseLikeCountFromData:(NSData *)data {
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) { return nil; }
    
     if ([object isKindOfClass:[NSDictionary class]]) {
         NSDictionary *results = object;
         NSDictionary *response = [results objectForKey:@"response"];
         NSNumber *likes = [response objectForKey:@"likes"];
         return likes;
     }
    
    return nil;
}

@end
