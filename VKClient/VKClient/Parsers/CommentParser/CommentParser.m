//
//  CommentParser.m
//  VKClient
//
//  Created by Damir Zaripov on 14.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import "CommentParser.h"
#import "Comment.h"
#import "SourceParser.h"

@interface CommentParser()
@property (strong, nonatomic) id<ISourceParser> sourceParser;
@end

@implementation CommentParser

- (instancetype)init {
    self = [super init];
    if (self) {
        self.sourceParser = [SourceParser new];
    }
    return self;
}

- (NSArray<Comment *> *)parseFromData:(NSData *)data {
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) { return nil; }
    
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *results = object;
        NSDictionary *response = [results objectForKey:@"response"];
        NSArray *items = [response objectForKey:@"items"];
        NSArray *profiles = [response objectForKey:@"profiles"];
        NSArray *groups = [response objectForKey:@"groups"];
        
        NSMutableArray<Comment *> *comments = [NSMutableArray array];
        NSMutableDictionary *sources = [NSMutableDictionary dictionary];
        
        [sources addEntriesFromDictionary:[self.sourceParser parseProfilesFromArray:profiles]];
        [sources addEntriesFromDictionary:[self.sourceParser parseGroupFromArray:groups]];
        
        for (NSDictionary *item in items) {
            NSNumber *fromID = [item objectForKey:@"from_id"];
            Source *source = [sources objectForKey:fromID];
            NSNumber *dateSeconds = [item objectForKey:@"date"];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[dateSeconds doubleValue]];
            NSString *text = [item objectForKey:@"text"];
            
            Comment *comment = [[Comment alloc] initWithSource:source text:text date:date];
            [comments addObject:comment];
        }
        return comments;
    }
    
    return nil;
}

@end
