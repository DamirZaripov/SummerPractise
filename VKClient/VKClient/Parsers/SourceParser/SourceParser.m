//
//  SourceParser.m
//  VKClient
//
//  Created by Damir Zaripov on 14.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import "SourceParser.h"
#import "Source.h"

@implementation SourceParser

- (NSDictionary *)parseProfilesFromArray:(NSArray *)profiles {
    NSMutableDictionary *sources = [NSMutableDictionary dictionary];
    
    for (NSDictionary *profile in profiles) {
        NSURL *avatarURL = [NSURL URLWithString:[profile objectForKey:@"photo_50"]];
        NSString *name = [profile objectForKey:@"first_name"];
        NSString *surname = [profile objectForKey:@"last_name"];
        NSNumber *sourceID = [profile objectForKey:@"id"];
        Source *source = [[Source alloc] initWithAvatarURL:avatarURL name:name surname:surname];
        [sources setObject:source forKey:sourceID];
    }
    return sources;
}

- (NSDictionary *)parseGroupFromArray:(NSArray *)groups {
    NSMutableDictionary *sources = [NSMutableDictionary dictionary];
    
    for (NSDictionary *group in groups) {
        NSURL *avatarURL = [NSURL URLWithString:[group objectForKey:@"photo_50"]];
        NSString *name = [group objectForKey:@"name"];
        NSNumber *sourceID = [group objectForKey:@"id"];
        Source *source = [[Source alloc] initWithAvatarURL:avatarURL name:name surname:nil];
        [sources setObject:source forKey:sourceID];
    }
    return sources;
}

@end
