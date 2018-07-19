//
//  UIAlertController+Extensions.h
//  VKClient
//
//  Created by Damir Zaripov on 12.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Helpers)
+ (instancetype) alertControllerWithTitle:(NSString *)title message:(NSString *)message;
@end
