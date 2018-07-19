//
//  Comment.m
//  VKClient
//
//  Created by Damir Zaripov on 14.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import "Comment.h"

@interface Comment()
@property (strong, nonatomic) Source *source;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSDate *date;
@end

@implementation Comment

- (instancetype)initWithSource:(Source *)source text:(NSString *)text date:(NSDate *)date {
    self = [super init];
    if (self) {
        self.source = source;
        self.text = text;
        self.date = date;
    }
    return self;
}

@end
