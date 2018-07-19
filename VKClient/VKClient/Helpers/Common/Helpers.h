//
//  Helpers.h
//  VKClient
//
//  Created by Damir Zaripov on 13.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import <Foundation/Foundation.h>

#define safe_block(block, ...) block ? block(__VA_ARGS__) : nil

NSString *DateString(NSDate *date);
