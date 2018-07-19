//
//  CommentParser.h
//  VKClient
//
//  Created by Damir Zaripov on 14.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Comment;

@protocol ICommentParser
- (NSArray<Comment *> *)parseFromData:(NSData *)data;
@end

@interface CommentParser : NSObject<ICommentParser>

@end
