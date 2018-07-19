//
//  AlertsFactory.h
//  VKClient
//
//  Created by Damir Zaripov on 13.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VKError;

@protocol IAlertsFactory
- (UIViewController *) buildErrorAlertWithVKError:(VKError *)error;
@end

@interface AlertsFactory : NSObject<IAlertsFactory>

@end
