//
//  ViewController.h
//  MessageDemo
//
//  Created by LvesLi on 2019/1/17.
//  Copyright © 2019 LvesLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseMessagesViewController.h"
#import "JSQMessages.h"

@interface ViewController : BaseMessagesViewController<UIActionSheetDelegate, JSQMessagesComposerTextViewPasteDelegate>

- (void)receiveMessagePressed:(UIBarButtonItem *)sender;

@end

