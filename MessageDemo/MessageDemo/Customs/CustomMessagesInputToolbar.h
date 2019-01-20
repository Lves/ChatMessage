//
//  CustomMessagesInputToolbar.h
//  MessageDemo
//
//  Created by LvesLi on 2019/1/18.
//  Copyright © 2019 LvesLi. All rights reserved.
//

#import "JSQMessagesInputToolbar.h"
#import "BaseMessageToolBarContentView.h"
#import "CountryToolBarContentView.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ToolbarContentViewType) {
    ToolbarContentViewTypePassword,
    ToolbarContentViewTypeMobile,
    ToolbarContentViewTypeCountry,
};




@class CustomMessagesInputToolbar;

@protocol MessagesInputToolbarDelegate <UIToolbarDelegate>
@required
- (void)messagesInputToolbar:(CustomMessagesInputToolbar *)toolbar
      didPressCuntryType:(CuntryType)cuntryType;

@end

@interface CustomMessagesInputToolbar : UIToolbar
@property (nonatomic, weak) id<MessagesInputToolbarDelegate> delegate;
@property (weak, nonatomic, nullable) BaseMessageToolBarContentView *contentView;
- (void)setCententViewType:(ToolbarContentViewType)type delegate:(id)delegate;
@end

NS_ASSUME_NONNULL_END
