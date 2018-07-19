//
//  NewsTableViewCellOutput.h
//  VKClient
//
//  Created by Damir Zaripov on 14.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewsTableViewCellOutput

- (void) didLikeButtonClickedAtIndexPath:(NSIndexPath *)indexPath liked:(BOOL)liked;

@end
