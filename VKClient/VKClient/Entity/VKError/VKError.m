//
//  VKError.m
//  VKClient
//
//  Created by Damir Zaripov on 13.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import "VKError.h"

@implementation VKError

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message {
    self = [super init];
    if (self) {
        self.title = title;
        self.message = message;
    }
    return self;
}

+ (instancetype)errorWithTitle:(NSString *)title message:(NSString *)message {
    return [[self alloc] initWithTitle:title message:message];
}

@end
