//
//  NewsfeedViewController.m
//  VKClient
//
//  Created by Damir Zaripov on 12.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import "NewsfeedViewController.h"
#import "News.h"
#import "NewsTableViewCell.h"
#import "NewsfeedsService.h"
#import "AlertsFactory.h"
#import "UserDefaultsManager.h"
#import "NewsDetailsViewController.h"
#import "LikeService.h"
#import "ActivityIndicator.h"

NSString *const newsCellIdentifier = @"newsCellIdentifier";
NSString *const detailsNewsSegueIdentifier = @"detailsNewsSegue";

@interface NewsfeedViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSIndexPath *lastSelectedIndexPath;
@property (strong, nonatomic) NSMutableArray<News *> *news;
@property (strong, nonatomic) NSString *startFrom;
@property (nonatomic) BOOL isLoading;
@property (strong, nonatomic) id<INewsfeedService> newsfeedService;
@property (strong, nonatomic) id<IAlertsFactory> alertsFactory;
@property (strong, nonatomic) id<IUserDefaultsManager> userDefaultsManager;
@property (strong, nonatomic) id<ILikeService> likeService;
@end

@implementation NewsfeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.news = [NSMutableArray array];
    self.newsfeedService = [NewsfeedsService new];
    self.alertsFactory = [AlertsFactory new];
    self.userDefaultsManager = [UserDefaultsManager new];
    self.likeService = [LikeService new];
    
    [self prepareTableView];
    [self fetchNewsWithAppending:false];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.lastSelectedIndexPath) {
        [self.tableView reloadRowsAtIndexPaths:@[self.lastSelectedIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void) fetchNewsWithAppending:(BOOL)appending {
    self.isLoading = true;
    __weak typeof(self) wself = self;
    [self.newsfeedService fetchNewsWithCount:@20 maxPhotos:@6 startFrom:self.startFrom onSuccess:^(NSArray<News *> *news, NSString *startFrom) {
        if (!wself) { return; }
        __strong typeof(wself) sself = wself;
        
        if (appending) {
            [sself.news addObjectsFromArray:news];
        } else {
            sself.news = [news mutableCopy];
        }
        sself.startFrom = startFrom;
        [sself.tableView reloadData];
        sself.isLoading = false;
    } onFailure:^(VKError *error) {
        if (!wself) { return; }
        __strong typeof(wself) sself = wself;
        
        sself.isLoading = false;
        [sself presentViewController:[sself.alertsFactory buildErrorAlertWithVKError:error] animated:true completion:nil];
    }];
}

- (IBAction)onLogoutButtonClick:(UIBarButtonItem *)sender {
    [self.userDefaultsManager clearAll];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
    
    if ([self isOpenModal]) {
        [self dismissViewControllerAnimated:true completion:nil];
    } else {
        __weak typeof(self) wself = self;
        [self presentViewController:loginViewController animated:true completion:^{
            if (!wself) { return; }
            __strong typeof(wself) sself = wself;
            [sself.presentingViewController dismissViewControllerAnimated:true completion:nil];
        }];
    }
}

- (BOOL)isOpenModal {
    if ([self presentingViewController]) {
        return true;
    }
    if ([[[self navigationController] presentingViewController] presentedViewController] == [self navigationController]) {
        return true;
    }
    return false;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:detailsNewsSegueIdentifier]) {
        NewsDetailsViewController *detailsViewController = segue.destinationViewController;
        detailsViewController.news = sender;
    }
}

- (void)setIsLoading:(BOOL)isLoading {
    _isLoading = isLoading;
    if (isLoading) {
        [ActivityIndicator showActivityIndicatorAddedTo:self.view];
    } else {
        [ActivityIndicator hideActivityIndicatorFrom:self.view];
    }
}

#pragma mark - UITableView methods

- (void)prepareTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 280;
    
    UINib *newsCellNib = [UINib nibWithNibName:@"NewsTableViewCell" bundle:nil];
    [self.tableView registerNib:newsCellNib forCellReuseIdentifier:newsCellIdentifier];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.news.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:newsCellIdentifier forIndexPath:indexPath];
    [cell prepareWithNews:self.news[indexPath.row] output:self indexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    self.lastSelectedIndexPath = indexPath;
    [self performSegueWithIdentifier:detailsNewsSegueIdentifier sender:self.news[indexPath.row]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat actualPosition = scrollView.contentOffset.y;
    CGFloat contentHeight = scrollView.contentSize.height - self.tableView.frame.size.height;
    if (actualPosition >= contentHeight && !self.isLoading) {
        [self fetchNewsWithAppending:true];
    }
}

#pragma mark - NewsTableViewCellOuput Methods

- (void)didLikeButtonClickedAtIndexPath:(NSIndexPath *)indexPath liked:(BOOL)liked {
    News *news = self.news[indexPath.row];
    NewsTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    __weak typeof(self) wself = self;
    if (liked) {
        [self.likeService addLikeToPostWithID:news.postID ownerID:news.ownerID type:@"post" onSuccess:^(NSNumber *likesCount) {
            if (!wself) { return; }
            __strong typeof(wself) sself = wself;
            
            [sself.news[indexPath.row] setLiked:liked];
            [sself.news[indexPath.row] setLikesCount:likesCount];
            [cell setLikesCount:likesCount];
        } onFailue:^(VKError *error) {
            [cell setLike:false];
        }];
    } else {
        [self.likeService deleteLikeFromPostWithID:news.postID ownerID:news.ownerID type:@"post" onSuccess:^(NSNumber *likesCount) {
            if (!wself) { return; }
            __strong typeof(wself) sself = wself;
            
            [sself.news[indexPath.row] setLiked:liked];
            [sself.news[indexPath.row] setLikesCount:likesCount];
            [cell setLikesCount:likesCount];
        } onFailue:^(VKError *error) {
            [cell setLike:true];
        }];
    }
}

@end
