//
//  News.m
//  VKClient
//
//  Created by Damir Zaripov on 12.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import "News.h"

@interface News()
@property (nonatomic, strong) Source *source;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSArray<NSURL *> *imagesURL;
@property (nonatomic) BOOL liked;
@property (nonatomic) BOOL canLike;
@property (nonatomic, strong) NSNumber *postID;
@property (nonatomic, strong) NSNumber *ownerID;
@property (nonatomic, strong) NSNumber *likesCount;
@end

@implementation News

- (instancetype)initWithSource:(Source *)source
                          date:(NSDate *)date
                          text:(NSString *)text
                     imagesURL:(NSArray<NSURL *> *)imagesURL
                         liked:(BOOL)liked
                       canLike:(BOOL)canLike
                        postID:(NSNumber *)postID
                       ownerID:(NSNumber *)ownerID
                    likesCount:(NSNumber *)likesCount {
    self = [super init];
    if (self) {
        self.source = source;
        self.date = date;
        self.text = text;
        self.imagesURL = imagesURL;
        self.liked = liked;
        self.canLike = canLike;
        self.postID = postID;
        self.ownerID = ownerID;
        self.likesCount = likesCount;
    }
    return self;
}

- (void)setLiked:(BOOL)liked {
    _liked = liked;
}

- (void)setLikesCount:(NSNumber *)likesCount {
    _likesCount = likesCount;
}

@end
