//
//  CustomMessagesInputToolbar.m
//  MessageDemo
//
//  Created by LvesLi on 2019/1/18.
//  Copyright © 2019 LvesLi. All rights reserved.
//

#import "CustomMessagesInputToolbar.h"
#import "JSQMessagesComposerTextView.h"
#import "JSQMessagesToolbarButtonFactory.h"
#import "UIColor+JSQMessages.h"
#import "UIImage+JSQMessages.h"
#import "UIView+JSQMessages.h"

#import "MobileInputContentView.h"
#import "PasswordMessageToolBarContentView.h"
#import "CountryToolBarContentView.h"


@interface CustomMessagesInputToolbar()<CountryToolBarContentViewDelegate>
@property (assign, nonatomic) BOOL jsq_isObserving;
@property (nonatomic, assign) ToolbarContentViewType contentViewType;
@property (strong, nonatomic) MobileInputContentView *mobileInputContentView;
@property (strong, nonatomic) PasswordMessageToolBarContentView *passwordBarContentView;
@property (strong, nonatomic) CountryToolBarContentView *countryToolBarContentView;
@end


@implementation CustomMessagesInputToolbar
#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    self.jsq_isObserving = NO;
    
    //去掉Toolbar的顶部border
    self.clipsToBounds = YES;
//    self.layer.borderWidth = 1;
//    self.layer.borderColor = [[UIColor whiteColor] CGColor];
}

-(MobileInputContentView *)mobileInputContentView{
    if (_mobileInputContentView == nil) {
        _mobileInputContentView = [[MobileInputContentView nib] instantiateWithOwner:nil options:nil].firstObject;
        _mobileInputContentView.backgroundColor = [UIColor whiteColor];
    }
    return _mobileInputContentView;
}
-(PasswordMessageToolBarContentView *)passwordBarContentView{
    if (_passwordBarContentView == nil) {
        _passwordBarContentView = [[PasswordMessageToolBarContentView nib] instantiateWithOwner:nil options:nil].firstObject;
        _passwordBarContentView.backgroundColor = [UIColor whiteColor];
    }
    return _passwordBarContentView;
}
-(CountryToolBarContentView *)countryToolBarContentView{
    if (_countryToolBarContentView == nil) {
        _countryToolBarContentView = [[CountryToolBarContentView nib] instantiateWithOwner:nil options:nil].firstObject;
        _countryToolBarContentView.backgroundColor = [UIColor orangeColor];
        _countryToolBarContentView.delegate = self;
    }
    return _countryToolBarContentView;
}


#pragma mark - Setters
- (void)setCententViewType:(ToolbarContentViewType)type delegate:(id)delegate{
    self.contentViewType = type;
    if (self.contentView) {
        [self.contentView removeFromSuperview];
    }
    if (type == ToolbarContentViewTypeMobile) {
        self.contentView = self.mobileInputContentView;
    }else if (type == ToolbarContentViewTypePassword){
        self.contentView = self.passwordBarContentView;
    }else if (type == ToolbarContentViewTypeCountry){
        self.contentView = self.countryToolBarContentView;
    }
    [self setupContentView];
    self.contentView.textField.delegate = delegate;
}


#pragma mark - CountryToolBarContentViewDelegate
-(void)countryToolBarContentView:(CountryToolBarContentView *)contentView didPressCuntryType:(CuntryType)cuntryType{
    if ([self.delegate respondsToSelector:@selector(messagesInputToolbar:didPressCuntryType:)]) {
        [self.delegate messagesInputToolbar:self didPressCuntryType:cuntryType];
    }
}

#pragma mark - Input toolbar

-(void)setupContentView{
    self.contentView.frame = self.frame;
    [self addSubview:self.contentView];
    [self jsq_pinAllEdgesOfSubview:self.contentView];
    [self setNeedsUpdateConstraints];
}


@end
