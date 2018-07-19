//
//  NewsTableViewCell.m
//  VKClient
//
//  Created by Damir Zaripov on 12.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "News.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Helpers.h"
#import "PhotoCollectionViewCell.h"
#import "NewsTableViewCellOutput.h"

NSString *const photoCellIdenitfier = @"photoCellIdentifier";

@interface NewsTableViewCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *likeToTextTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *likeToCollectionViewTopConstraint;

@property (strong, nonatomic) News *news;
@property (weak, nonatomic) id<NewsTableViewCellOutput> output;
@property (strong, nonatomic) NSIndexPath *indexPath;
@end

@implementation NewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self prepareCollectionView];
    
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.width / 2;
    self.avatarImageView.clipsToBounds = true;
}

- (void) prepareWithNews:(News *)news output:(id<NewsTableViewCellOutput>)output indexPath:(NSIndexPath *)indexPath {
    self.news = news;
    self.output = output;
    self.indexPath = indexPath;
    
    [self.avatarImageView sd_setImageWithURL:news.source.avatarURL placeholderImage:[UIImage imageNamed:@"avatar"]];
    
    if (news.source.surname != nil) {
        self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", news.source.name, news.source.surname];
    } else {
        self.nameLabel.text = news.source.name;
    }
    
    self.dateLabel.text = DateString(news.date);
    self.newsTextLabel.text = news.text;
    self.likesCountLabel.text = [NSString stringWithFormat:@"%@", news.likesCount];
    
    if (!news.canLike && !news.liked) {
        [self.likeButton setHidden:true];
    }
    
    self.likeButton.selected = news.liked;
    if (news.liked) {
        [self.likeButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    } else {
        [self.likeButton setImage:[UIImage imageNamed:@"unlike"] forState:UIControlStateNormal];
    }
    
    if (news.imagesURL.count > 0) {
        [self.photoCollectionView setHidden:false];
        [self.pageControl setHidden:false];
        self.pageControl.numberOfPages = news.imagesURL.count;
        self.likeToTextTopConstraint.priority = UILayoutPriorityDefaultLow;
        self.likeToCollectionViewTopConstraint.priority = UILayoutPriorityDefaultHigh;
    } else {
        [self.photoCollectionView setHidden:true];
        [self.pageControl setHidden:true];
        self.likeToTextTopConstraint.priority = UILayoutPriorityDefaultHigh;
        self.likeToCollectionViewTopConstraint.priority = UILayoutPriorityDefaultLow;
    }
    
    [self.photoCollectionView reloadData];
}

- (void) setLikesCount:(NSNumber *)likesCount {
    self.likesCountLabel.text = [NSString stringWithFormat:@"%@", likesCount];
}

- (void) setLike:(BOOL)like {
    if (like) {
        [self.likeButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    } else {
        [self.likeButton setImage:[UIImage imageNamed:@"unlike"] forState:UIControlStateNormal];
    }
    self.likeButton.selected = like;
}

- (IBAction)onLikeButtonClick:(UIButton *)sender {
    if (sender.selected) {
        [self.likeButton setImage:[UIImage imageNamed:@"unlike"] forState:UIControlStateNormal];
    } else {
        [self.likeButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    }
    sender.selected = !sender.selected;
    [self.output didLikeButtonClickedAtIndexPath:self.indexPath liked:sender.selected];
}

#pragma mark - UICollectionView methods

- (void)prepareCollectionView {
    self.photoCollectionView.delegate = self;
    self.photoCollectionView.dataSource = self;
    UINib *photoNib = [UINib nibWithNibName:@"PhotoCollectionViewCell" bundle:nil];
    [self.photoCollectionView registerNib:photoNib forCellWithReuseIdentifier:photoCellIdenitfier];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.news.imagesURL.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:photoCellIdenitfier forIndexPath:indexPath];
    [cell.photoImageView sd_setImageWithURL:self.news.imagesURL[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.photoCollectionView.frame.size.width, self.photoCollectionView.frame.size.height);
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    self.pageControl.currentPage = indexPath.row;
}

@end
