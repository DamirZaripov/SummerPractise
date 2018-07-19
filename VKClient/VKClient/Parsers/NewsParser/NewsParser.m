//
//  NewsParser.m
//  VKClient
//
//  Created by Damir Zaripov on 13.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import "NewsParser.h"
#import "News.h"
#import "SourceParser.h"

@interface NewsParser()
@property (nonatomic, strong) NSString *startFrom;
@property (nonatomic, strong) id<ISourceParser> sourceParser;
@end

@implementation NewsParser

- (instancetype)init {
    self = [super init];
    if (self) {
        self.sourceParser = [SourceParser new];
    }
    return self;
}

- (NSArray<News *> *)parseFromData:(NSData *)data {
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) { return nil; }
    
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *results = object;
        NSDictionary *response = [results objectForKey:@"response"];
        NSArray *items = [response objectForKey:@"items"];
        NSArray *profiles = [response objectForKey:@"profiles"];
        NSArray *groups = [response objectForKey:@"groups"];
        self.startFrom = [response objectForKey:@"next_from"];
        
        NSMutableArray<News *> *news = [NSMutableArray array];
        NSMutableDictionary *sources = [NSMutableDictionary dictionary];
        
        [sources addEntriesFromDictionary:[self.sourceParser parseProfilesFromArray:profiles]];
        [sources addEntriesFromDictionary:[self.sourceParser parseGroupFromArray:groups]];
        
        for (NSDictionary *item in items) {
            NSNumber *sourceID = [item objectForKey:@"source_id"];
            NSNumber *postID = [item objectForKey:@"post_id"];
            Source *source = [sources objectForKey:[NSNumber numberWithInteger:labs([sourceID integerValue])]];
            NSNumber *dateSecods = [item objectForKey:@"date"];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[dateSecods doubleValue]];
            NSString *text = [item objectForKey:@"text"];
            
            NSMutableArray<NSURL *> *imagesURL = [NSMutableArray array];
            if ([item objectForKey:@"attachments"] != nil) {
                NSArray *attachments = [item objectForKey:@"attachments"];
                for (NSDictionary *attachment in attachments) {
                    NSString *type = [attachment objectForKey:@"type"];
                    if ([type isEqualToString:@"photo"]) {
                        NSDictionary *photo = [attachment objectForKey:@"photo"];
                        NSArray *sizes = [photo objectForKey:@"sizes"];
                        NSDictionary *size = sizes.lastObject;
                        NSURL *imageURL = [size objectForKey:@"url"];
                        [imagesURL addObject:imageURL];
                    }
                }
            }
            
            NSDictionary *likes = [item objectForKey:@"likes"];
            NSNumber *likedNum = [likes objectForKey:@"user_likes"];
            NSNumber *canLikeNum = [likes objectForKey:@"can_like"];
            NSNumber *likesCount = [likes objectForKey:@"count"];
            BOOL liked = [likedNum boolValue];
            BOOL canLike = [canLikeNum boolValue];
            
            News *post = [[News alloc] initWithSource:source date:date text:text imagesURL:imagesURL liked:liked canLike:canLike postID:postID ownerID:sourceID likesCount:likesCount];
            [news addObject:post];
        }
        
        return news;
    }
    return nil;
}

@end
