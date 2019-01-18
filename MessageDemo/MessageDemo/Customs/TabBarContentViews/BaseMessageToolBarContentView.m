//
//  BaseMessageToolBarContentView.m
//  MessageDemo
//
//  Created by LvesLi on 2019/1/18.
//  Copyright © 2019 LvesLi. All rights reserved.
//

#import "BaseMessageToolBarContentView.h"
#import "JSQMessages.h"

@interface BaseMessageToolBarContentView ()
@property (weak, nonatomic) IBOutlet JSQMessagesComposerTextView *textView;
@end

@implementation BaseMessageToolBarContentView

#pragma mark - UIView overrides

- (void)setNeedsDisplay
{
    [super setNeedsDisplay];
    [self.textView setNeedsDisplay];
}
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([BaseMessageToolBarContentView class])
                          bundle:[NSBundle bundleForClass:[BaseMessageToolBarContentView class]]];
}
#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];

    self.backgroundColor = [UIColor clearColor];
}

@end
