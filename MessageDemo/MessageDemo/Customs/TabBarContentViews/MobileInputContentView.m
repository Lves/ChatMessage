//
//  MobileInputContentView.m
//  MessageDemo
//
//  Created by LvesLi on 2019/1/17.
//  Copyright © 2019 LvesLi. All rights reserved.
//

#import "MobileInputContentView.h"
#import "NSBundle+JSQMessages.h"

@interface MobileInputContentView ()
@property (weak, nonatomic) IBOutlet JSQMessagesComposerTextView *textView;
@end


@implementation MobileInputContentView

#pragma mark - Class methods

#pragma mark - UIView overrides

- (void)setNeedsDisplay
{
    [super setNeedsDisplay];
    [self.textView setNeedsDisplay];
}
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([MobileInputContentView class])
                          bundle:[NSBundle bundleForClass:[MobileInputContentView class]]];
}
#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.backgroundColor = [UIColor clearColor];
    self.textView.placeHolder = [NSBundle jsq_localizedStringForKey:@"new_message"];
    self.textView.accessibilityLabel = [NSBundle jsq_localizedStringForKey:@"new_message"];
    self.textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.textView.textColor = [UIColor lightGrayColor];
}

@end
