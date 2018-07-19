//
//  NewsTableViewCell.h
//  VKClient
//
//  Created by Damir Zaripov on 12.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class News;
@protocol NewsTableViewCellOutput;

@interface NewsTableViewCell : UITableViewCell<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *newsTextLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *likesCountLabel;


- (void) prepareWithNews:(News *)news output:(id<NewsTableViewCellOutput>)output indexPath:(NSIndexPath *)indexPath;
- (void) setLikesCount:(NSNumber *)likesCount;
- (void) setLike:(BOOL)like;
@end
