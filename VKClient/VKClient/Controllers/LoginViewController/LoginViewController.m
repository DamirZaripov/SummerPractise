//
//  LoginViewController.m
//  VKClient
//
//  Created by Damir Zaripov on 12.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import "LoginViewController.h"
#import "UserDefaultsManager.h"
#import "UIAlertController+Extensions.h"

NSString *const clientID = @"6630801";
NSString *const scope = @"wall,friends";
NSString *const newsfeedSegueIdentifier = @"newsfeedSegue";

@interface LoginViewController ()
@property (strong, nonatomic) id<IUserDefaultsManager> userDefaultsManager;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userDefaultsManager = [[UserDefaultsManager alloc] init];
}
    
- (IBAction) onLoginButtonClick:(UIButton *)sender {
    CGFloat screenHeight = UIScreen.mainScreen.bounds.size.height;
    CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;
    
    UIWebView *authWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -screenHeight, screenWidth, screenHeight)];
    authWebView.alpha = 0;
    authWebView.tag = 1024;
    authWebView.delegate = self;
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    closeButton.alpha = 0;
    [self.view addSubview:authWebView];
    [authWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://oauth.vk.com/authorize?client_id=%@&scope=%@&redirect_uri=oauth.vk.com/blank.html&display=touch&response_type=token", clientID, scope]]]];
    [self.view.window makeKeyAndVisible];
    closeButton.frame = CGRectMake(5, 15, 50, 50);
    closeButton.tag = 1025;
    [closeButton addTarget:self action:@selector(closeWebView) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setTitle:@"X" forState:UIControlStateNormal];
    [self.view addSubview:closeButton];
    [UIView animateWithDuration:1.0 animations:^{
        authWebView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
        authWebView.alpha = 1.0;
        closeButton.alpha = 1.0;
    }];
}
    
- (void) closeWebView {
    UIView *webView = [self.view viewWithTag:1024];
    UIView *closeButton = [self.view viewWithTag:1025];
    
    __weak typeof(self) wself = self;
    [UIView animateWithDuration:0.4 animations:^{
        webView.alpha = 0;
        closeButton.alpha = 0;
    } completion:^(BOOL finished) {
        if (!wself) { return; }
        __strong typeof(wself) sself = wself;
        
        [webView removeFromSuperview];
        [closeButton removeFromSuperview];
        
        [sself performSegueWithIdentifier:newsfeedSegueIdentifier sender:nil];
    }];
}
    
#pragma mark - UIWebViewDelegate
    
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *currentURl = webView.request.URL.absoluteString;
    NSRange textRange = [[currentURl lowercaseString] rangeOfString:[@"access_token" lowercaseString]];
    if (textRange.location != NSNotFound) {
        NSArray *data = [currentURl componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"=&"]];
        [self.userDefaultsManager setAccessToken:[data objectAtIndex:1]];
        [self.userDefaultsManager setUserID:[data objectAtIndex:3]];

        NSDate *expiresIn = [NSDate dateWithTimeIntervalSinceNow:[[data objectAtIndex:5] doubleValue]];
        self.userDefaultsManager.expiresIn = expiresIn;
        
        NSLog(@"Access token: %@", [data objectAtIndex:1]);
        NSLog(@"UserID: %@", [data objectAtIndex:3]);
        NSLog(@"Expires in: %@", [data objectAtIndex:5]);
        
        [self closeWebView];
    } else {
        textRange = [[currentURl lowercaseString] rangeOfString:[@"access_denied" lowercaseString]];
        if (textRange.location != NSNotFound) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Ошибка" message:@"Не удалось авторизоваться, проверьте интернет соединение"];
            [self presentViewController:alert animated:true completion:nil];
        }
    }
}

@end
