//
//  FetchNewsfeedRequest.h
//  VKClient
//
//  Created by Damir Zaripov on 13.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request.h"

@interface FetchNewsfeedRequest : NSObject<Request>

- (instancetype)initWithCount:(NSNumber *)count maxPhotos:(NSNumber *)maxPhotos startFrom:(NSString *)startFrom;
+ (instancetype)requestWithCount:(NSNumber *)count maxPhotos:(NSNumber *)maxPhotos startFrom:(NSString *)startFrom;

@end
