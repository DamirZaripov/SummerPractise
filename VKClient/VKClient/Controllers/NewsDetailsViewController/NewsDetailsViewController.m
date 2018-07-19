//
//  NewsDetailsViewController.m
//  VKClient
//
//  Created by Damir Zaripov on 14.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import "NewsDetailsViewController.h"
#import "Comment.h"
#import "NewsTableViewCell.h"
#import "CommentTableViewCell.h"
#import "NewsfeedsService.h"
#import "AlertsFactory.h"
#import "LikeService.h"
#import "ActivityIndicator.h"

NSInteger const newsSection = 0;
NSInteger const commentsSection = 1;
NSInteger const headerHeight = 56;
CGFloat const newsEstimatedRowHeight = 280;
CGFloat const commentEstimatedRowHeight = 89;
NSString *const detailNewsCellIdentifier = @"newsCellIdentifier";
NSString *const commentCellIdentifier = @"commentCellIdentifier";

@interface NewsDetailsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray<Comment *> *comments;
@property (strong, nonatomic) id<INewsfeedService> newsfeedService;
@property (strong, nonatomic) id<IAlertsFactory> alertsFactory;
@property (strong, nonatomic) id<ILikeService> likeService;
@end

@implementation NewsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.newsfeedService = [NewsfeedsService new];
    self.alertsFactory = [AlertsFactory new];
    self.likeService = [LikeService new];
    
    [self prepareTableView];
    [self fetchComments];
}

- (void)fetchComments {
    [ActivityIndicator showActivityIndicatorAddedTo:self.view];
    
    __weak typeof(self) wself = self;
    [self.newsfeedService fetchCommentsWithPostID:self.news.postID ownerID:self.news.ownerID onSuccess:^(NSArray<Comment *> *comments) {
        if (!wself) { return; }
        __strong typeof(wself) sself = wself;
        
        sself.comments = comments;
        [sself.tableView reloadData];
        [ActivityIndicator hideActivityIndicatorFrom:sself.view];
    } onFailure:^(VKError *error) {
        if (!wself) { return; }
        __strong typeof(wself) sself = wself;
        
        [ActivityIndicator hideActivityIndicatorFrom:sself.view];
        [sself presentViewController:[sself.alertsFactory buildErrorAlertWithVKError:error] animated:true completion:nil];
    }];
}

#pragma mark - UITableView Methods

- (void) prepareTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UINib *newsNib = [UINib nibWithNibName:@"NewsTableViewCell" bundle:nil];
    UINib *commentNib = [UINib nibWithNibName:@"CommentTableViewCell" bundle:nil];
    
    [self.tableView registerNib:newsNib forCellReuseIdentifier:detailNewsCellIdentifier];
    [self.tableView registerNib:commentNib forCellReuseIdentifier:commentCellIdentifier];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == newsSection) {
        return 1;
    } else if (section == commentsSection) {
        return self.comments.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == newsSection) {
        NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:detailNewsCellIdentifier forIndexPath:indexPath];
        cell.newsTextLabel.numberOfLines = 0;
        [cell prepareWithNews:self.news output:self indexPath:indexPath];
        return cell;
    } else if (indexPath.section == commentsSection) {
        CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:commentCellIdentifier forIndexPath:indexPath];
        [cell prepareWithComment:self.comments[indexPath.row]];
        return cell;
    }
    
    return [UITableViewCell new];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == newsSection) {
        return @"Новость";
    } else if (section == commentsSection) {
        return @"Комментарии";
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return headerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == newsSection) {
        return newsEstimatedRowHeight;
    } else if (indexPath.section == commentsSection) {
        return commentEstimatedRowHeight;
    }
    return 0;
}

#pragma mark - NewsTableViewCellOuput Methods

- (void)didLikeButtonClickedAtIndexPath:(NSIndexPath *)indexPath liked:(BOOL)liked {
    NewsTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    __weak typeof(self) wself = self;
    if (liked) {
        [self.likeService addLikeToPostWithID:self.news.postID ownerID:self.news.ownerID type:@"post" onSuccess:^(NSNumber *likesCount) {
            if (!wself) { return; }
            __strong typeof(wself) sself = wself;
            
            [sself.news setLiked:liked];
            [sself.news setLikesCount:likesCount];
            [cell setLikesCount:likesCount];
        } onFailue:^(VKError *error) {
            [cell setLike:false];
        }];
    } else {
        [self.likeService deleteLikeFromPostWithID:self.news.postID ownerID:self.news.ownerID type:@"post" onSuccess:^(NSNumber *likesCount) {
            if (!wself) { return; }
            __strong typeof(wself) sself = wself;
            
            [sself.news setLiked:liked];
            [sself.news setLikesCount:likesCount];
            [cell setLikesCount:likesCount];
        } onFailue:^(VKError *error) {
            [cell setLike:true];
        }];
    }
}

@end
