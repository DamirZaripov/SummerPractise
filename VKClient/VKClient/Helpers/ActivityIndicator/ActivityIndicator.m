//
//  ActivityIndicator.m
//  VKClient
//
//  Created by Damir Zaripov on 15.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import "ActivityIndicator.h"

NSInteger const activityTag = 56;

@implementation ActivityIndicator

+ (void) showActivityIndicatorAddedTo:(UIView *)view {
    UIView *container = [UIView new];
    container.frame = view.frame;
    container.center = view.center;
    container.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
    container.tag = activityTag;
    
    UIView *loadingView = [UIView new];
    loadingView.frame = CGRectMake(0, 0, 80, 80);
    loadingView.center = view.center;
    loadingView.backgroundColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:0.7];
    loadingView.clipsToBounds = true;
    loadingView.layer.cornerRadius = 10;
    
    UIActivityIndicatorView *actInd = [UIActivityIndicatorView new];
    actInd.frame = CGRectMake(0, 0, 40, 40);
    actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    actInd.center = CGPointMake(loadingView.frame.size.width / 2, loadingView.frame.size.height / 2);
    [loadingView addSubview:actInd];
    [container addSubview:loadingView];
    [view addSubview:container];
    [actInd startAnimating];
}

+ (void) hideActivityIndicatorFrom:(UIView *)view {
    UIView *activityContainer = [view viewWithTag:activityTag];
    [activityContainer removeFromSuperview];
}

@end
