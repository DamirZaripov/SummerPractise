//
//  VKError.h
//  VKClient
//
//  Created by Damir Zaripov on 13.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VKError : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *message;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message;
+ (instancetype)errorWithTitle:(NSString *)title message:(NSString *)message;

@end
