//
//  ApiProvider.h
//  VKClient
//
//  Created by Damir Zaripov on 13.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VKError.h"
#import "Request.h"

@interface ApiProvider : NSObject

- (void) makeRequest:(id<Request>)request onSuccess:(void (^)(NSData* data))onSuccess onFailure:(void (^)(VKError *error))onFailure;

@end
