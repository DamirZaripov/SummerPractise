//
//  NewsDetailsViewController.h
//  VKClient
//
//  Created by Damir Zaripov on 14.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"
#import "NewsTableViewCellOutput.h"

@interface NewsDetailsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, NewsTableViewCellOutput>
@property (strong, nonatomic) News *news;
@end
