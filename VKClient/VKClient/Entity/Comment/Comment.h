//
//  Comment.h
//  VKClient
//
//  Created by Damir Zaripov on 14.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Source.h"

@interface Comment : NSObject
@property (readonly) Source *source;
@property (readonly) NSString *text;
@property (readonly) NSDate *date;

- (instancetype)initWithSource:(Source *)source text:(NSString *)text date:(NSDate *)date;
@end
