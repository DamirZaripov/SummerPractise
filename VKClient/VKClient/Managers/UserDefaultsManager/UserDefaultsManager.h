//
//  UserDefaultsManager.h
//  VKClient
//
//  Created by Damir Zaripov on 12.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum: NSUInteger {
    UserDefaultsAccessToken,
    UserDefaultsUserID,
    UserDefaultsExpiresIn
} UserDefaultsKey;

@protocol IUserDefaultsManager
@property (nonatomic) NSString *accessToken;
@property (nonatomic) NSString *userID;
@property (nonatomic) NSDate *expiresIn;

- (void) clearAll;
@end

@interface UserDefaultsManager : NSObject<IUserDefaultsManager>
    
@end
