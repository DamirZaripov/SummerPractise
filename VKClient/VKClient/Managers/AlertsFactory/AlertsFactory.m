//
//  AlertsFactory.m
//  VKClient
//
//  Created by Damir Zaripov on 13.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import "AlertsFactory.h"
#import "VKError.h"
#import "UIAlertController+Extensions.h"

@implementation AlertsFactory

- (UIViewController *) buildErrorAlertWithVKError:(VKError *)error {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:error.title message:error.message];
    return alert;
}

@end
