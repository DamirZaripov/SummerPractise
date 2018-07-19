//
//  NewsfeedsService.h
//  VKClient
//
//  Created by Damir Zaripov on 13.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class News, VKError, Comment;

@protocol INewsfeedService
- (void)fetchNewsWithCount:(NSNumber *)count
                 maxPhotos:(NSNumber *)maxPhotos
                 startFrom:(NSString *)startFrom
                 onSuccess:(void (^)(NSArray<News *> *news, NSString *startFrom))onSuccess
                 onFailure:(void (^)(VKError *error))onFailure;

- (void)fetchCommentsWithPostID:(NSNumber *)postID
                        ownerID:(NSNumber *)ownerID
                       extended:(BOOL)extended
                         fields:(NSArray<NSString *> *)fields
                      onSuccess:(void (^)(NSArray<Comment *> *comments))onSuccess
                      onFailure:(void (^)(VKError *error))onFailure;
- (void)fetchCommentsWithPostID:(NSNumber *)postID
                        ownerID:(NSNumber *)ownerID
                      onSuccess:(void (^)(NSArray<Comment *> *comments))onSuccess
                      onFailure:(void (^)(VKError *error))onFailure;
@end

@interface NewsfeedsService : NSObject<INewsfeedService>

@end
