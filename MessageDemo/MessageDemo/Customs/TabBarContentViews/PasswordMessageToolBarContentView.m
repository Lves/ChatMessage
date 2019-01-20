//
//  PasswordMessageToolBarContentView.m
//  MessageDemo
//
//  Created by LvesLi on 2019/1/18.
//  Copyright © 2019 LvesLi. All rights reserved.
//

#import "PasswordMessageToolBarContentView.h"
#import "NSBundle+JSQMessages.h"
#import "BaseTextField.h"
@interface PasswordMessageToolBarContentView ()
@property (weak, nonatomic) IBOutlet BaseTextField *textField;
@end


@implementation PasswordMessageToolBarContentView
@synthesize textField;
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([PasswordMessageToolBarContentView class])
                          bundle:[NSBundle bundleForClass:[PasswordMessageToolBarContentView class]]];
}
#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.textField setReturnKeyType:UIReturnKeyDone];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.backgroundColor = [UIColor clearColor];
    self.textField.placeholder = @"请输入密码";
//    self.textField.accessibilityLabel = [NSBundle jsq_localizedStringForKey:@"new_message"];
}


@end
