//
//  LikeParser.h
//  VKClient
//
//  Created by Damir Zaripov on 14.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ILikeParser
- (NSNumber *)parseLikeCountFromData:(NSData *)data;
@end

@interface LikeParser : NSObject<ILikeParser>

@end
