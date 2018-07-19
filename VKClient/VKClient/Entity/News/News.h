//
//  News.h
//  VKClient
//
//  Created by Damir Zaripov on 12.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Source.h"

@interface News : NSObject
@property (readonly) Source *source;
@property (readonly) NSDate *date;
@property (readonly) NSString *text;
@property (readonly) NSArray<NSURL *> *imagesURL;
@property (readonly) BOOL liked;
@property (readonly) BOOL canLike;
@property (readonly) NSNumber *postID;
@property (readonly) NSNumber *ownerID;
@property (readonly) NSNumber *likesCount;

- (instancetype)initWithSource:(Source *)source
                          date:(NSDate *)date
                          text:(NSString *)text
                     imagesURL:(NSArray<NSURL *> *)imagesURL
                         liked:(BOOL)liked
                       canLike:(BOOL)canLike
                        postID:(NSNumber *)postID
                       ownerID:(NSNumber *)ownerID
                    likesCount:(NSNumber *)likesCount;

- (void)setLiked:(BOOL)liked;
- (void)setLikesCount:(NSNumber *)likesCount;

@end
