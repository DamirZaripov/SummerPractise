//
//  LikeService.h
//  VKClient
//
//  Created by Damir Zaripov on 14.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ILikeService
- (void)addLikeToPostWithID:(NSNumber *)postID
                    ownerID:(NSNumber *)ownerID
                       type:(NSString *)type
                  onSuccess:(void (^)(NSNumber *likesCount))onSuccess
                   onFailue:(void (^)(VKError *error))onFailure;

- (void)deleteLikeFromPostWithID:(NSNumber *)postID
                         ownerID:(NSNumber *)ownerID
                            type:(NSString *)type
                       onSuccess:(void (^)(NSNumber *likesCount))onSuccess
                        onFailue:(void (^)(VKError *error))onFailure;
@end

@interface LikeService : NSObject<ILikeService>

@end
