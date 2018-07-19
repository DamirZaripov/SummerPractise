//
//  Request.h
//  VKClient
//
//  Created by Damir Zaripov on 12.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Request <NSObject>
    @property (strong, nonatomic, readonly) NSString *httpMethod;
    @property (strong, nonatomic, readonly) NSString *endPoint;
    @property (strong, nonatomic, readonly) NSDictionary *headers;
- (NSDictionary *) paramsWithAuthToken: (NSString *) authToken version:(NSString *)version;
@end
