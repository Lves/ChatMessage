//
//  CountryToolBarContentView.m
//  MessageDemo
//
//  Created by XINGLE LI on 2019/1/20.
//  Copyright © 2019 LvesLi. All rights reserved.
//

#import "CountryToolBarContentView.h"

@implementation CountryToolBarContentView
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([CountryToolBarContentView class])
                          bundle:[NSBundle bundleForClass:[CountryToolBarContentView class]]];
}
#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
}
- (IBAction)tapUSA:(id)sender {
    if ( [[self delegate] respondsToSelector:@selector(countryToolBarContentView:didPressCuntryType:)]) {
        [[self delegate] countryToolBarContentView:self didPressCuntryType:CuntryTypeUSA];
    }
}
- (IBAction)tapChina:(id)sender {
    if ( [[self delegate] respondsToSelector:@selector(countryToolBarContentView:didPressCuntryType:)]) {
        [[self delegate] countryToolBarContentView:self didPressCuntryType:CuntryTypeChina];
    }
}
- (IBAction)tapOther:(id)sender {
    if ( [[self delegate] respondsToSelector:@selector(countryToolBarContentView:didPressCuntryType:)]) {
        [[self delegate] countryToolBarContentView:self didPressCuntryType:CuntryTypeOther];
    }
}
@end
