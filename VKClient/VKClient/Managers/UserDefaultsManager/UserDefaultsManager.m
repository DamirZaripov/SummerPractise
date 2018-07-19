//
//  UserDefaultsManager.m
//  VKClient
//
//  Created by Damir Zaripov on 12.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import "UserDefaultsManager.h"

@implementation UserDefaultsManager {
    NSUserDefaults *_userDefaults;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}
    
- (void) setAccessToken:(NSString *)accessToken {
    [_userDefaults setObject:accessToken forKey:[self stringForKey:UserDefaultsAccessToken]];
}
    
- (NSString *)accessToken {
    return [_userDefaults objectForKey:[self stringForKey:UserDefaultsAccessToken]];
}
    
- (void)setUserID:(NSString *)userID {
    [_userDefaults setObject:userID forKey:[self stringForKey:UserDefaultsUserID]];
}
    
- (NSString *)userID {
    return [_userDefaults objectForKey:[self stringForKey:UserDefaultsUserID]];
}
    
- (void)setExpiresIn:(NSDate *)expiresIn {
    [_userDefaults setObject:expiresIn forKey:[self stringForKey:UserDefaultsExpiresIn]];
    [_userDefaults synchronize];
}
    
- (NSDate *)expiresIn {
    return [_userDefaults objectForKey:[self stringForKey:UserDefaultsExpiresIn]];
}
    
- (NSString *) stringForKey:(UserDefaultsKey)key {
    switch (key) {
        case UserDefaultsAccessToken: return @"kAccessToken";
        case UserDefaultsUserID     : return @"kUserID";
        case UserDefaultsExpiresIn  : return @"kExpiresIn";
    }
}

- (void) clearAll {
    NSDictionary *dict = [_userDefaults dictionaryRepresentation];
    for (id key in dict) {
        [_userDefaults removeObjectForKey:key];
    }
    [_userDefaults synchronize];
}
    
@end
