//
//  ApiProvider.m
//  VKClient
//
//  Created by Damir Zaripov on 13.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import "ApiProvider.h"
#import "UserDefaultsManager.h"

NSString *const BASE_URL = @"https://api.vk.com/method/";
NSString *const VERSION = @"5.80";

@interface ApiProvider()
@property (strong, nonatomic) id<IUserDefaultsManager> userDefaultsManager;
@end

@implementation ApiProvider

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userDefaultsManager = [UserDefaultsManager new];
    }
    return self;
}

- (void) makeRequest:(id<Request>)request onSuccess:(void (^)(NSData* data))onSuccess onFailure:(void (^)(VKError *error))onFailure {
    NSDictionary *parameters = [request paramsWithAuthToken:self.userDefaultsManager.accessToken version:VERSION];
    
    NSURLComponents *components = [NSURLComponents componentsWithString:[BASE_URL stringByAppendingPathComponent:request.endPoint]];
    components.queryItems = [self prepareParameters:parameters];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:components.URL];
    
    NSLog(@"*** Start Request ***");
    NSLog(@"URL: %@", urlRequest.URL.absoluteString);
    NSLog(@"Method: %@", request.httpMethod);
    NSLog(@"Parameters: %@", parameters);
    NSLog(@"*** End Request Info ***");
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        NSLog(@"*** Start Response ***");
        NSLog(@"Status code: %ld", [httpResponse statusCode]);
        NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSLog(@"*** End Response ***");
        
        if (data == nil) {
            VKError *error = [VKError errorWithTitle:@"Ошибка" message:@"Нет данных от сервера"];
            onFailure(error);
        } else {
            onSuccess(data);
        }
    }];
    [task resume];
}

- (NSArray<NSURLQueryItem*> *) prepareParameters:(NSDictionary *)parameters {
    NSMutableArray<NSURLQueryItem*> *items = [NSMutableArray array];
    for (NSString *key in parameters.allKeys) {
        id value = [parameters objectForKey:key];
        if ([value isKindOfClass:[NSNumber class]]) {
            value = [value stringValue];
        }
        NSURLQueryItem *item = [NSURLQueryItem queryItemWithName:key value:value];
        [items addObject:item];
    }
    return items;
}

@end
