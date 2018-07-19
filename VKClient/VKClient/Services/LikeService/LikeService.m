//
//  LikeService.m
//  VKClient
//
//  Created by Damir Zaripov on 14.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import "ApiProvider.h"
#import "LikeService.h"
#import "VKError.h"
#import "AddLikeRequest.h"
#import "LikeParser.h"
#import "Helpers.h"
#import "DeleteLikeRequest.h"

@interface LikeService()
@property (strong, nonatomic) ApiProvider *api;
@property (strong, nonatomic) id<ILikeParser> likeParser;
@end

@implementation LikeService

- (instancetype)init {
    self = [super init];
    if (self) {
        self.api = [ApiProvider new];
        self.likeParser = [LikeParser new];
    }
    return self;
}

- (void)addLikeToPostWithID:(NSNumber *)postID
                    ownerID:(NSNumber *)ownerID
                       type:(NSString *)type
                  onSuccess:(void (^)(NSNumber *likesCount))onSuccess
                   onFailue:(void (^)(VKError *error))onFailure {
    AddLikeRequest *request = [AddLikeRequest requestWithType:type ownerID:ownerID itemID:postID];
    
    __weak typeof(self) wself = self;
    [self.api makeRequest:request onSuccess:^(NSData *data) {
        if (!wself) { return; }
        __strong typeof(wself) sself = wself;
        
        NSNumber *likesCount = [sself.likeParser parseLikeCountFromData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (likesCount != nil) {
                safe_block(onSuccess, likesCount);
            } else {
                VKError *error = [VKError errorWithTitle:@"Ошибка" message:@"Не удалось поставить отметить понравившуюся запись"];
                safe_block(onFailure, error);
            }
        });
    } onFailure:^(VKError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            safe_block(onFailure, error);
        });
    }];
}

- (void)deleteLikeFromPostWithID:(NSNumber *)postID
                         ownerID:(NSNumber *)ownerID
                            type:(NSString *)type
                       onSuccess:(void (^)(NSNumber *likesCount))onSuccess
                        onFailue:(void (^)(VKError *error))onFailure {
    DeleteLikeRequest *request = [DeleteLikeRequest requestWithType:type ownerID:ownerID itemID:postID];
    
    __weak typeof(self) wself = self;
    [self.api makeRequest:request onSuccess:^(NSData *data) {
        if (!wself) { return; }
        __strong typeof(wself) sself = wself;
        
        NSNumber *likesCount = [sself.likeParser parseLikeCountFromData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (likesCount != nil) {
                safe_block(onSuccess, likesCount);
            } else {
                VKError *error = [VKError errorWithTitle:@"Ошибка" message:@"Не удалось убрать отметку нравится с записи"];
                safe_block(onFailure, error);
            }
        });
    } onFailure:^(VKError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            safe_block(onFailure, error);
        });
    }];
}

@end
