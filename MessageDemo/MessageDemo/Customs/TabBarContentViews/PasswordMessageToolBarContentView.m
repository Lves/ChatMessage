//
//  PasswordMessageToolBarContentView.m
//  MessageDemo
//
//  Created by LvesLi on 2019/1/18.
//  Copyright © 2019 LvesLi. All rights reserved.
//

#import "PasswordMessageToolBarContentView.h"
#import "NSBundle+JSQMessages.h"
@interface PasswordMessageToolBarContentView ()
@property (weak, nonatomic) IBOutlet JSQMessagesComposerTextView *textView;
@end


@implementation PasswordMessageToolBarContentView

- (void)setNeedsDisplay
{
    [super setNeedsDisplay];
    [self.textView setNeedsDisplay];
}
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([PasswordMessageToolBarContentView class])
                          bundle:[NSBundle bundleForClass:[PasswordMessageToolBarContentView class]]];
}
#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.backgroundColor = [UIColor clearColor];
    self.textView.placeHolder = [NSBundle jsq_localizedStringForKey:@"new_message"];
    self.textView.accessibilityLabel = [NSBundle jsq_localizedStringForKey:@"new_message"];
}


@end
