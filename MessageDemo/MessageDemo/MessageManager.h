//
//  MessageManager.h
//  MessageDemo
//
//  Created by XINGLE LI on 2019/1/20.
//  Copyright © 2019 LvesLi. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, ActionType) {
    ActionTypeNone,
    ActionTypeMobile,
    ActionTypePassword,
    ActionTypeVerificationCode,
    ActionTypeCountry,
};

@interface MessageModel : NSObject
@property (strong, nonatomic) NSMutableArray * _Nullable messages;
@property (assign, nonatomic) ActionType actionType;
@end


NS_ASSUME_NONNULL_BEGIN

@interface MessageManager : NSObject
@property (nonatomic,assign) ActionType currentActionType;
- (MessageModel *)getNextMessageModel;

@end

NS_ASSUME_NONNULL_END
