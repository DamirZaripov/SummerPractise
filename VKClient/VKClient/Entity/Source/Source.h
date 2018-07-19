//
//  Source.h
//  VKClient
//
//  Created by Damir Zaripov on 13.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Source : NSObject
@property (readonly) NSURL *avatarURL;
@property (readonly) NSString *name;
@property (readonly) NSString *surname;

- (instancetype)initWithAvatarURL:(NSURL *)avatarURL
                             name:(NSString *)name
                          surname:(NSString *)surname;

@end
