//
//  Source.m
//  VKClient
//
//  Created by Damir Zaripov on 13.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import "Source.h"

@interface Source()
@property (nonatomic, strong) NSURL *avatarURL;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *surname;
@end

@implementation Source

- (instancetype)initWithAvatarURL:(NSURL *)avatarURL
                             name:(NSString *)name
                          surname:(NSString *)surname {
    self = [super init];
    if (self) {
        self.avatarURL = avatarURL;
        self.name = name;
        self.surname = surname;
    }
    return self;
}

@end
