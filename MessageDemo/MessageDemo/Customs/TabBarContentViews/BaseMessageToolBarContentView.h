//
//  BaseMessageToolBarContentView.h
//  MessageDemo
//
//  Created by LvesLi on 2019/1/18.
//  Copyright © 2019 LvesLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "JSQMessagesComposerTextView.h"



@interface BaseMessageToolBarContentView : UIView
@property (weak, nonatomic, readonly, nullable) JSQMessagesComposerTextView *textView;
#pragma mark - Class methods
+ (UINib *)nib;
@end
