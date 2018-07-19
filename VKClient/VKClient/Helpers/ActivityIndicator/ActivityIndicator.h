//
//  ActivityIndicator.h
//  VKClient
//
//  Created by Damir Zaripov on 15.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityIndicator : NSObject

+ (void) showActivityIndicatorAddedTo:(UIView *)view;
+ (void) hideActivityIndicatorFrom:(UIView *)view;

@end
