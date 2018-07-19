//
//  NewsParser.h
//  VKClient
//
//  Created by Damir Zaripov on 13.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class News;

@protocol INewsParser
@property (readonly) NSString *startFrom;

- (NSArray<News *> *)parseFromData:(NSData *)data;
@end

@interface NewsParser : NSObject<INewsParser>

@end
