//
//  NewsfeedViewController.h
//  VKClient
//
//  Created by Damir Zaripov on 12.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsTableViewCellOutput.h"

@interface NewsfeedViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, NewsTableViewCellOutput>

@end
