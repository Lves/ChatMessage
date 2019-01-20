//
//  BaseTextField.m
//  MessageDemo
//
//  Created by XINGLE LI on 2019/1/20.
//  Copyright © 2019 LvesLi. All rights reserved.
//

#import "BaseTextField.h"

@implementation BaseTextField
#pragma mark - UIMenuController

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    [UIMenuController sharedMenuController].menuItems = nil;
    return [super canPerformAction:action withSender:sender];
}

@end
