//
//  MobileInputContentView.m
//  MessageDemo
//
//  Created by LvesLi on 2019/1/17.
//  Copyright © 2019 LvesLi. All rights reserved.
//

#import "MobileInputContentView.h"
#import "NSBundle+JSQMessages.h"

typedef NS_ENUM(NSUInteger, CountryType) {
    CountryTypeChina,
    CountryTypeUSA,
};

@interface MobileInputContentView ()
@property (weak, nonatomic) IBOutlet JSQMessagesComposerTextView *textView;

//leftButton
@property (weak, nonatomic) IBOutlet UILabel *lblTopCountryCode;
@property (weak, nonatomic) IBOutlet UIImageView *imgTopCountryLogo;
@property (weak, nonatomic) IBOutlet UILabel *lblBottomCountryCode;
@property (weak, nonatomic) IBOutlet UIImageView *imgBottomCountryLogo;

@property (weak, nonatomic) IBOutlet UIView *bottomCheckView;
@property (nonatomic, assign) BOOL isChecking;
@property (nonatomic, assign) CountryType currentCountryType;
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
    [self.bottomCheckView setHidden:YES];
    self.isChecking = NO;
    [self updateChineUI];
}
- (IBAction)topButtonClick:(id)sender {
    if (self.isChecking) { //选择了china
        self.isChecking = NO;
        [self.bottomCheckView setHidden:YES];
    }else{
        [self.bottomCheckView setHidden:NO];
        self.isChecking = YES;
    }
   
}
- (IBAction)bottomCountryClick:(id)sender {
    self.isChecking = NO;
    [self.bottomCheckView setHidden:YES];
    [self exchangeButton];
}

- (void)exchangeButton{
    if (self.currentCountryType == CountryTypeChina) {
        self.lblTopCountryCode.text = @"+1";
        self.imgTopCountryLogo.image = [UIImage imageNamed:@"usa"];
        self.lblBottomCountryCode.text = @"+86";
        self.imgBottomCountryLogo.image = [UIImage imageNamed:@"china"];
        self.currentCountryType = CountryTypeUSA;
    }else if (self.currentCountryType == CountryTypeUSA){
        [self updateChineUI];
    }
}

- (void)updateChineUI{
    self.lblTopCountryCode.text = @"+86";
    self.imgTopCountryLogo.image = [UIImage imageNamed:@"china"];
    self.lblBottomCountryCode.text = @"+1";
    self.imgBottomCountryLogo.image = [UIImage imageNamed:@"usa"];
    self.currentCountryType = CountryTypeChina;
}
@end
