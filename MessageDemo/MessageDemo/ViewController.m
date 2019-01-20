//
//  ViewController.m
//  MessageDemo
//
//  Created by LvesLi on 2019/1/17.
//  Copyright © 2019 LvesLi. All rights reserved.
//

#import "ViewController.h"
#import "JSQMessagesViewAccessoryButtonDelegate.h"
#import "MessageManager.h"
@interface ViewController ()<JSQMessagesViewAccessoryButtonDelegate>
@property (nonatomic,strong) NSMutableArray *messages;
@property (nonatomic,strong) JSQMessagesBubbleImage *incomingBubbleImageData;
@property (nonatomic,strong) JSQMessagesBubbleImage *outgoingBubbleImageData;
@property (nonatomic,strong) MessageManager *messageManager;
@end

@implementation ViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"首页";
    self.messageManager = [[MessageManager alloc] init];
    [self.inputToolbar setHidden:YES];
    
    self.inputToolbar.contentView.textField.pasteDelegate = self;
    JSQMessagesBubbleImageFactory *bubbleFactory = [[JSQMessagesBubbleImageFactory alloc] init];
    self.incomingBubbleImageData = [bubbleFactory incomingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleBlueColor]];
    self.outgoingBubbleImageData = [bubbleFactory outgoingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleLightGrayColor]];
    
    /**
     *  Load up our fake data for the demo
     */
    self.messages = [NSMutableArray array];
    /**
     *  Set up message accessory button delegate and configuration
     */
    self.collectionView.accessoryDelegate = self;
    self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero;
    self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero;
    self.showLoadEarlierMessagesHeader = NO;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage jsq_defaultTypingIndicatorImage]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(receiveMessagePressed:)];
    
    /**
     *  Register custom menu actions for cells.
     */
    [JSQMessagesCollectionViewCell registerMenuAction:@selector(customAction:)];
    
    
    /**
     *  OPT-IN: allow cells to be deleted
     */
    [JSQMessagesCollectionViewCell registerMenuAction:@selector(delete:)];
    
    /**
     *  Customize your toolbar buttons
     *
     *  self.inputToolbar.contentView.leftBarButtonItem = custom button or nil to remove
     *  self.inputToolbar.contentView.rightBarButtonItem = custom button or nil to remove
     */

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.collectionView.collectionViewLayout.springinessEnabled = NO;
    [self showMessageModel:[self.messageManager getNextMessageModel] index:0];
}



#pragma mark - Custom menu actions for cells

- (void)didReceiveMenuWillShowNotification:(NSNotification *)notification
{
    /**
     *  Display custom menu actions for cells.
     */
    UIMenuController *menu = [notification object];
    menu.menuItems = @[ [[UIMenuItem alloc] initWithTitle:@"Custom Action" action:@selector(customAction:)] ];
    
    [super didReceiveMenuWillShowNotification:notification];
}



#pragma mark - Testing
    //测试代码
- (void)showMessageModel:(MessageModel *)messageModel index:(NSUInteger)index{
    if (index < messageModel.messages.count) {
        JSQMessage *nextMessage = messageModel.messages[index];
        self.showTypingIndicator = YES;
        [self scrollToBottomAnimated:YES];
        __weak ViewController *weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.messages addObject:nextMessage];
            [weakSelf finishReceivingMessageAnimated:YES];
            [weakSelf showMessageModel:messageModel index:index+1];
        });
    }else if (index == messageModel.messages.count){//该用户输入了
        __weak ViewController *weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if(messageModel.actionType == ActionTypeMobile){
                [weakSelf.inputToolbar setHidden:NO];
                [weakSelf.inputToolbar setCententViewType:ToolbarContentViewTypeMobile delegate:weakSelf];
                [weakSelf.inputToolbar.contentView.textField becomeFirstResponder];
            }else if (messageModel.actionType == ActionTypePassword){
                [weakSelf.inputToolbar setHidden:NO];
                [weakSelf.inputToolbar setCententViewType:ToolbarContentViewTypePassword delegate:weakSelf];
                [weakSelf.inputToolbar.contentView.textField becomeFirstResponder];
            }else if (messageModel.actionType == ActionTypeCountry){
                [weakSelf.inputToolbar setHidden:NO];
                [weakSelf.inputToolbar setCententViewType:ToolbarContentViewTypeCountry delegate:weakSelf];
//                [weakSelf.inputToolbar.contentView.textField becomeFirstResponder];
                
                
                [UIView animateWithDuration:0.25
                                      delay:0.0
                                    options:UIViewAnimationOptionTransitionFlipFromBottom
                                 animations:^{
                                     const UIEdgeInsets insets = self.additionalContentInset;
                                     [self jsq_setCollectionViewInsetsTopValue:insets.top
                                                                   bottomValue:weakSelf.inputToolbar.contentView.frame.size.height + insets.bottom];
                                 }
                                 completion:^(BOOL finished) {
                                     [self scrollToBottomAnimated:YES];
                                 }];
            }
        });
       
    }
    
}


#pragma mark - Actions

- (void)receiveMessagePressed:(UIBarButtonItem *)sender
{
    
    /**
     *  Show the typing indicator to be shown
     */
    self.showTypingIndicator = !self.showTypingIndicator;
    [self scrollToBottomAnimated:YES];
    
    /**
     *  Allow typing indicator to show
     */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        JSQMessage *newMessage = [JSQMessage messageWithSenderId:@"Robot"
                                         displayName:@"robot"  //self.demoData.users[randomUserId]
                                                text:@"收到"];
        
        [self.messages addObject:newMessage];
        [self finishReceivingMessageAnimated:YES];
        
        
        if (newMessage.isMediaMessage) {
            /**
             *  Simulate "downloading" media
             */
        }
    });
}
#pragma mark - MessageToolBar Delegate
-(void)messagesInputToolbar:(CustomMessagesInputToolbar *)toolbar didPressCuntryType:(CuntryType)cuntryType{
    NSString *cuntry = cuntryType == 0 ? @"中国" : ( cuntryType == 1 ? @"美国" : @"其他");
    JSQMessage *message = [[JSQMessage alloc] initWithSenderId:[self.collectionView.dataSource senderId]
                                             senderDisplayName:[self.collectionView.dataSource senderDisplayName]
                                                          date:[NSDate date]
                                                          text:cuntry];
    [self.messages addObject:message];
    [self.inputToolbar setHidden:YES];
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options:UIViewAnimationOptionTransitionFlipFromBottom
                     animations:^{
                         const UIEdgeInsets insets = self.additionalContentInset;
                         [self jsq_setCollectionViewInsetsTopValue:insets.top
                                                       bottomValue:insets.bottom];
                     }
                     completion:nil];
    [self finishSendingMessageAnimated:YES];
    
    [self showMessageModel:[self.messageManager getNextMessageModel] index:0];
}

#pragma mark - JSQMessagesViewController method overrides

- (void)didPressSendButton:(UIButton *)button
           withMessageText:(NSString *)text
                  senderId:(NSString *)senderId
         senderDisplayName:(NSString *)senderDisplayName
                      date:(NSDate *)date
{
    /**
     *  Sending a message. Your implementation of this method should do *at least* the following:
     *
     *  1. Play sound (optional)
     *  2. Add new id<JSQMessageData> object to your data source
     *  3. Call `finishSendingMessage`
     */
    JSQMessage *message = [[JSQMessage alloc] initWithSenderId:senderId
                                             senderDisplayName:senderDisplayName
                                                          date:date
                                                          text:text];
    [self.messages addObject:message];
    [self finishSendingMessageAnimated:YES];
    
    //测试用
    [self.inputToolbar.contentView.textField resignFirstResponder];
//    [self.inputToolbar removeFromSuperview];
    [self showMessageModel:[self.messageManager getNextMessageModel] index:0];
}

- (void)didPressAccessoryButton:(UIButton *)sender
{
    [self.inputToolbar.contentView.textField resignFirstResponder];

    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Media messages", nil)
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:NSLocalizedString(@"Send photo", nil), NSLocalizedString(@"Send location", nil), NSLocalizedString(@"Send video", nil), NSLocalizedString(@"Send video thumbnail", nil), NSLocalizedString(@"Send audio", nil), nil];

    [sheet showFromToolbar:self.inputToolbar];

}
#pragma mark - JSQMessages CollectionView DataSource

- (NSString *)senderId {
    return @"userid";
}

- (NSString *)senderDisplayName {
    return @"Pintec";
}

- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.messages objectAtIndex:indexPath.item];
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView didDeleteMessageAtIndexPath:(NSIndexPath *)indexPath
{
    [self.messages removeObjectAtIndex:indexPath.item];
}

- (id<JSQMessageBubbleImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView messageBubbleImageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JSQMessage *message = [self.messages objectAtIndex:indexPath.item];
    JSQMessagesBubbleImageFactory *bubbleFactory = [[JSQMessagesBubbleImageFactory alloc] init];
    if ([message.senderId isEqualToString:self.senderId]) {
        return _outgoingBubbleImageData;
    }
    return _incomingBubbleImageData;
}
//显示头像
- (id<JSQMessageAvatarImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
//显示时间
- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    JSQMessage *message = [self.messages objectAtIndex:indexPath.item];
    
    /**
     *  iOS7-style sender name labels
     */
    if ([message.senderId isEqualToString:self.senderId]) {
        return nil;
    }
    
    if (indexPath.item - 1 > 0) {
        JSQMessage *previousMessage = [self.messages objectAtIndex:indexPath.item - 1];
        if ([[previousMessage senderId] isEqualToString:message.senderId]) {
            return nil;
        }
    }
    
    /**
     *  Don't specify attributes to use the defaults.
     */
    return [[NSAttributedString alloc] initWithString:message.senderDisplayName];
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.messages count];
}

- (UICollectionViewCell *)collectionView:(JSQMessagesCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  Override point for customizing cells
     */
    JSQMessagesCollectionViewCell *cell = (JSQMessagesCollectionViewCell *)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    
    /**
     *  Configure almost *anything* on the cell
     *
     *  Text colors, label text, label colors, etc.
     *
     *
     *  DO NOT set `cell.textView.font` !
     *  Instead, you need to set `self.collectionView.collectionViewLayout.messageBubbleFont` to the font you want in `viewDidLoad`
     *
     *
     *  DO NOT manipulate cell layout information!
     *  Instead, override the properties you want on `self.collectionView.collectionViewLayout` from `viewDidLoad`
     */
    
    JSQMessage *msg = [self.messages objectAtIndex:indexPath.item];
    
    if (!msg.isMediaMessage) {
        
        if ([msg.senderId isEqualToString:self.senderId]) {
            cell.textView.textColor = [UIColor blackColor];
        }
        else {
            cell.textView.textColor = [UIColor whiteColor];
        }
        
        cell.textView.linkTextAttributes = @{ NSForegroundColorAttributeName : cell.textView.textColor,
                                              NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid) };
    }
    
    cell.accessoryButton.hidden = ![self shouldShowAccessoryButtonForMessage:msg];
    
    return cell;
}
//是否显示气泡旁边的icon，可以预留修改的笔
- (BOOL)shouldShowAccessoryButtonForMessage:(id<JSQMessageData>)message
{
    return [message isMediaMessage];
}


#pragma mark - UICollectionView Delegate

#pragma mark - Custom menu items

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    if (action == @selector(customAction:)) {
        return YES;
    }
    
    return [super collectionView:collectionView canPerformAction:action forItemAtIndexPath:indexPath withSender:sender];
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    if (action == @selector(customAction:)) {
        [self customAction:sender];
        return;
    }
    
    [super collectionView:collectionView performAction:action forItemAtIndexPath:indexPath withSender:sender];
}

- (void)customAction:(id)sender
{
    NSLog(@"Custom action received! Sender: %@", sender);
    
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Custom Action", nil)
                                message:nil
                               delegate:nil
                      cancelButtonTitle:NSLocalizedString(@"OK", nil)
                      otherButtonTitles:nil]
     show];
}



#pragma mark - JSQMessages collection view flow layout delegate

#pragma mark - Adjusting cell label heights
//气泡之间间隔，原来留的是时间lable的高度
- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return kJSQMessagesCollectionViewCellLabelHeightDefault;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  iOS7-style sender name labels
     */
    JSQMessage *currentMessage = [self.messages objectAtIndex:indexPath.item];
    if ([[currentMessage senderId] isEqualToString:self.senderId]) {
        return 0.0f;
    }
    
    if (indexPath.item - 1 > 0) {
        JSQMessage *previousMessage = [self.messages objectAtIndex:indexPath.item - 1];
        if ([[previousMessage senderId] isEqualToString:[currentMessage senderId]]) {
            return 0.0f;
        }
    }
    
    return kJSQMessagesCollectionViewCellLabelHeightDefault;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.0f;
}

#pragma mark - Responding to collection view tap events

- (void)collectionView:(JSQMessagesCollectionView *)collectionView
                header:(JSQMessagesLoadEarlierHeaderView *)headerView didTapLoadEarlierMessagesButton:(UIButton *)sender
{
    NSLog(@"Load earlier messages!");
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView didTapAvatarImageView:(UIImageView *)avatarImageView atIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Tapped avatar!");
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView didTapMessageBubbleAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Tapped message bubble!");
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView didTapCellAtIndexPath:(NSIndexPath *)indexPath touchLocation:(CGPoint)touchLocation
{
    NSLog(@"Tapped cell at %@!", NSStringFromCGPoint(touchLocation));
}

#pragma mark - JSQMessagesComposerTextViewPasteDelegate methods

- (BOOL)composerTextView:(JSQMessagesComposerTextView *)textView shouldPasteWithSender:(id)sender
{
    if ([UIPasteboard generalPasteboard].image) {
        // If there's an image in the pasteboard, construct a media item with that image and `send` it.
        JSQPhotoMediaItem *item = [[JSQPhotoMediaItem alloc] initWithImage:[UIPasteboard generalPasteboard].image];
        JSQMessage *message = [[JSQMessage alloc] initWithSenderId:self.senderId
                                                 senderDisplayName:self.senderDisplayName
                                                              date:[NSDate date]
                                                             media:item];
        [self.messages addObject:message];
        [self finishSendingMessage];
        return NO;
    }
    return YES;
}

#pragma mark - JSQMessagesViewAccessoryDelegate methods

- (void)messageView:(JSQMessagesCollectionView *)view didTapAccessoryButtonAtIndexPath:(NSIndexPath *)path
{
    NSLog(@"Tapped accessory button!");
}


@end
