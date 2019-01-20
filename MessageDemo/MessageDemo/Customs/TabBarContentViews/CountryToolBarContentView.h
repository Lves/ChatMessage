//
//  CountryToolBarContentView.h
//  MessageDemo
//
//  Created by XINGLE LI on 2019/1/20.
//  Copyright © 2019 LvesLi. All rights reserved.
//

#import "BaseMessageToolBarContentView.h"

typedef NS_ENUM(NSUInteger, CuntryType) {
    CuntryTypeChina,
    CuntryTypeUSA,
    CuntryTypeOther,
};

@class CountryToolBarContentView;

@protocol CountryToolBarContentViewDelegate <UIToolbarDelegate>
@required
- (void)countryToolBarContentView:(CountryToolBarContentView *)contentView
          didPressCuntryType:(CuntryType)cuntryType;

@end


NS_ASSUME_NONNULL_BEGIN

@interface CountryToolBarContentView : BaseMessageToolBarContentView
@property (nonatomic, weak) id <CountryToolBarContentViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
