//
//  DeleteLikeRequest.h
//  VKClient
//
//  Created by Damir Zaripov on 14.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request.h"

@interface DeleteLikeRequest : NSObject<Request>

- (instancetype)initWithType:(NSString *)type ownerID:(NSNumber *)ownerID itemID:(NSNumber *)itemID;
+ (instancetype)requestWithType:(NSString *)type ownerID:(NSNumber *)ownerID itemID:(NSNumber *)itemID;

@end
