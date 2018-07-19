//
//  FetchCommentsRequest.h
//  VKClient
//
//  Created by Damir Zaripov on 14.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request.h"

@interface FetchCommentsRequest : NSObject<Request>

- (instancetype) initWithPostID:(NSNumber *)postID ownerID:(NSNumber *)ownerID extended:(NSNumber *)extended fields:(NSArray<NSString *> *)fields;
+ (instancetype) requestWithPostID:(NSNumber *)postID ownerID:(NSNumber *)ownerID extended:(NSNumber *)extended fields:(NSArray<NSString *> *)fields;

@end
