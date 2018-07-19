//
//  SourceParser.h
//  VKClient
//
//  Created by Damir Zaripov on 14.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ISourceParser
- (NSDictionary *)parseProfilesFromArray:(NSArray *)profiles;
- (NSDictionary *)parseGroupFromArray:(NSArray *)groups;
@end

@interface SourceParser : NSObject<ISourceParser>

@end
