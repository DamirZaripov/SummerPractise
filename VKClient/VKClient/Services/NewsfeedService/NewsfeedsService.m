//
//  NewsfeedsService.m
//  VKClient
//
//  Created by Damir Zaripov on 13.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import "NewsfeedsService.h"
#import "News.h"
#import "VKError.h"
#import "FetchNewsfeedRequest.h"
#import "ApiProvider.h"
#import "NewsParser.h"
#import "Helpers.h"
#import "Comment.h"
#import "FetchCommentsRequest.h"
#import "CommentParser.h"

@interface NewsfeedsService()
@property (strong, nonatomic) ApiProvider *api;
@property (strong, nonatomic) id<INewsParser> newsParser;
@property (strong, nonatomic) id<ICommentParser> commentParser;
@end

@implementation NewsfeedsService

- (instancetype)init {
    self = [super init];
    if (self) {
        self.api = [ApiProvider new];
        self.newsParser = [NewsParser new];
        self.commentParser = [CommentParser new];
    }
    return self;
}

- (void)fetchNewsWithCount:(NSNumber *)count
                 maxPhotos:(NSNumber *)maxPhotos
                 startFrom:(NSString *)startFrom
                 onSuccess:(void (^)(NSArray<News *> *news, NSString *startFrom))onSuccess
                 onFailure:(void (^)(VKError *error))onFailure {
    FetchNewsfeedRequest *request = [FetchNewsfeedRequest requestWithCount:count maxPhotos:maxPhotos startFrom:startFrom];
    
    __weak typeof(self) wself = self;
    [self.api makeRequest:request onSuccess:^(NSData *data) {
        if (!wself) { return; }
        __strong typeof(wself) sself = wself;
        
        NSArray<News *> *news = [sself.newsParser parseFromData:data];
        NSString *startFrom = sself.newsParser.startFrom;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (news != nil) {
                safe_block(onSuccess, news, startFrom);
            } else {
                VKError *error = [VKError errorWithTitle:@"Ошибка" message:@"Не удалось получить список новостей"];
                safe_block(onFailure, error);
            }
        });
    } onFailure:^(VKError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            safe_block(onFailure, error);            
        });
    }];
}

- (void)fetchCommentsWithPostID:(NSNumber *)postID
                        ownerID:(NSNumber *)ownerID
                       extended:(BOOL)extended
                         fields:(NSArray<NSString *> *)fields
                      onSuccess:(void (^)(NSArray<Comment *> *comments))onSuccess
                      onFailure:(void (^)(VKError *error))onFailure {
    FetchCommentsRequest *request = [FetchCommentsRequest requestWithPostID:postID ownerID:ownerID extended:[NSNumber numberWithBool:extended] fields:fields];
    
    __weak typeof(self) wself = self;
    [self.api makeRequest:request onSuccess:^(NSData *data) {
        if (!wself) { return; }
        __strong typeof(wself) sself = wself;
        
        NSArray<Comment *> *comments = [sself.commentParser parseFromData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (comments != nil) {
                safe_block(onSuccess, comments);
            } else {
                VKError *error = [VKError errorWithTitle:@"Ошибка" message:@"Не удалось получить список комментариев"];
                safe_block(onFailure, error);
            }
        });
    } onFailure:^(VKError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            safe_block(onFailure, error);
        });
    }];
}

- (void)fetchCommentsWithPostID:(NSNumber *)postID
                        ownerID:(NSNumber *)ownerID
                      onSuccess:(void (^)(NSArray<Comment *> *comments))onSuccess
                      onFailure:(void (^)(VKError *error))onFailure {
    [self fetchCommentsWithPostID:postID ownerID:ownerID extended:true fields:@[@"first_name", @"last_name", @"photo_50", @"name"] onSuccess:onSuccess onFailure:onFailure];
}

@end
