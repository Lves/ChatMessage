//
//  NSString+Vole.m
//  MessageDemo
//
//  Created by XINGLE LI on 2019/1/20.
//  Copyright © 2019 LvesLi. All rights reserved.
//

#import "NSString+Vole.h"

@implementation NSString (Vole)

+(NSString *)getStartStringWithLength:(NSUInteger) length{
    NSString *result = @"";
    for (NSUInteger index = 0; index < length; index ++) {
        result = [result stringByAppendingString:@"*"];
    }
    return result;
}
@end
