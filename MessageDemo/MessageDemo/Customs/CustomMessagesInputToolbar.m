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

@interface CustomMessagesInputToolbar()
@property (assign, nonatomic) BOOL jsq_isObserving;
@property (nonatomic, assign) ToolbarContentViewType contentViewType;
@property (strong, nonatomic) MobileInputContentView *mobileInputContentView;
@property (strong, nonatomic) PasswordMessageToolBarContentView *passwordBarContentView;
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
    }
    [self setupContentView];
    self.contentView.textField.delegate = delegate;
}


#pragma mark - Actions

- (void)jsq_leftBarButtonPressed:(UIButton *)sender
{
//    [self.delegate messagesInputToolbar:self didPressLeftBarButton:sender];
}

- (void)jsq_rightBarButtonPressed:(UIButton *)sender
{
//    [self.delegate messagesInputToolbar:self didPressRightBarButton:sender];
}

#pragma mark - Input toolbar

-(void)setupContentView{
    self.contentView.frame = self.frame;
    [self addSubview:self.contentView];
    [self jsq_pinAllEdgesOfSubview:self.contentView];
    [self setNeedsUpdateConstraints];
    [self jsq_addObservers];
}


#pragma mark - Key-value observing

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == kJSQMessagesInputToolbarKeyValueObservingContext) {
        if (object == self.contentView) {
            
            if ([keyPath isEqualToString:NSStringFromSelector(@selector(leftBarButtonItem))]) {
//
//                [self.contentView.leftBarButtonItem removeTarget:self
//                                                          action:NULL
//                                                forControlEvents:UIControlEventTouchUpInside];
//
//                [self.contentView.leftBarButtonItem addTarget:self
//                                                       action:@selector(jsq_leftBarButtonPressed:)
//                                             forControlEvents:UIControlEventTouchUpInside];
            }
            else if ([keyPath isEqualToString:NSStringFromSelector(@selector(rightBarButtonItem))]) {
                
//                [self.contentView.rightBarButtonItem removeTarget:self
//                                                           action:NULL
//                                                 forControlEvents:UIControlEventTouchUpInside];
//
//                [self.contentView.rightBarButtonItem addTarget:self
//                                                        action:@selector(jsq_rightBarButtonPressed:)
//                                              forControlEvents:UIControlEventTouchUpInside];
            }
            
//            [self updateSendButtonEnabledState];
        }
    }
}

- (void)jsq_addObservers
{
    if (self.jsq_isObserving) {
        return;
    }
    
    [self.contentView addObserver:self
                       forKeyPath:NSStringFromSelector(@selector(leftBarButtonItem))
                          options:0
                          context:kJSQMessagesInputToolbarKeyValueObservingContext];
    
    [self.contentView addObserver:self
                       forKeyPath:NSStringFromSelector(@selector(rightBarButtonItem))
                          options:0
                          context:kJSQMessagesInputToolbarKeyValueObservingContext];
    
    self.jsq_isObserving = YES;
}

- (void)jsq_removeObservers
{
    if (!_jsq_isObserving) {
        return;
    }
    
    @try {
        [self.contentView removeObserver:self
                          forKeyPath:NSStringFromSelector(@selector(leftBarButtonItem))
                             context:kJSQMessagesInputToolbarKeyValueObservingContext];
        
        [self.contentView removeObserver:self
                          forKeyPath:NSStringFromSelector(@selector(rightBarButtonItem))
                             context:kJSQMessagesInputToolbarKeyValueObservingContext];
    }
    @catch (NSException *__unused exception) { }
    
    _jsq_isObserving = NO;
}

@end
