//
//  CustomMessagesInputToolbar.h
//  MessageDemo
//
//  Created by LvesLi on 2019/1/18.
//  Copyright © 2019 LvesLi. All rights reserved.
//

#import "JSQMessagesInputToolbar.h"
#import "BaseMessageToolBarContentView.h"
#import "MobileInputContentView.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ToolbarContentViewType) {
    ToolbarContentViewTypePassword,
    ToolbarContentViewTypeMobile,
};

@interface CustomMessagesInputToolbar : UIToolbar
@property (weak, nonatomic, nullable) BaseMessageToolBarContentView *contentView;

- (void)setCententViewType:(ToolbarContentViewType)type delegate:(id)delegate;

@end

NS_ASSUME_NONNULL_END
