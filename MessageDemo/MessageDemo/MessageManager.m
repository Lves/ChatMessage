//
//  MessageManager.m
//  MessageDemo
//
//  Created by XINGLE LI on 2019/1/20.
//  Copyright © 2019 LvesLi. All rights reserved.
//

#import "MessageManager.h"
#import "JSQMessages.h"



@implementation MessageModel
@end


@interface MessageManager ()
@property (nonatomic,strong) NSArray *actionArray;
@end

@implementation MessageManager
-(instancetype)init{
    if (self = [super init]) {
        self.currentActionType = ActionTypeNone;
        self.actionArray = [NSArray arrayWithObjects:
                            [NSNumber numberWithInt:ActionTypeMobile],
                            [NSNumber numberWithInt:ActionTypePassword],
                            [NSNumber numberWithInt:ActionTypeCountry], nil];
    }
    return self;
}

-(ActionType)nextAction{
    if (self.currentActionType == ActionTypeNone) {
        return  ActionTypeMobile;
    }else if (self.currentActionType == ActionTypeMobile){
        return ActionTypePassword;
    }else if (self.currentActionType == ActionTypePassword){
        return ActionTypeCountry;
    }
    return ActionTypeNone;
}
- (MessageModel *)getNextMessageModel{
    self.currentActionType = [self nextAction];
    return [self getMessagesByType:self.currentActionType];
}

- (MessageModel *)getMessagesByType:(ActionType)actionType{
    MessageModel *messageModel=[[MessageModel alloc] init];
    NSMutableArray *mutableArray = nil;
    if (actionType == ActionTypeMobile) {
        JSQMessage *newMessage1 = [JSQMessage messageWithSenderId:@"Robot"
                                                     displayName:@"robot"  //self.demoData.users[randomUserId]
                                                            text:@"要开户需要先验证一下个人信息，它应该只需要5分钟"];
        JSQMessage *newMessage2 = [JSQMessage messageWithSenderId:@"Robot"
                                                     displayName:@"robot"  //self.demoData.users[randomUserId]
                                                            text:@"首先你的电话号码是多少？"];
        JSQMessage *newMessage3 = [JSQMessage messageWithSenderId:@"Robot"
                                                      displayName:@"robot"  //self.demoData.users[randomUserId]
                                                             text:@"请注意目前我们只能支持美国和h中国大陆的电话号码"];
        
       
        mutableArray = [[NSMutableArray alloc] initWithObjects:newMessage1, newMessage2, newMessage3, nil];
        messageModel.messages = mutableArray;
        messageModel.actionType = ActionTypeMobile;
    }else if(actionType == ActionTypePassword){
        JSQMessage *newMessage1 = [JSQMessage messageWithSenderId:@"Robot"
                                                      displayName:@"robot"  //self.demoData.users[randomUserId]
                                                             text:@"我们发送了一次性安全吗，请在下面输入。"];
        JSQMessage *newMessage2 = [JSQMessage messageWithSenderId:@"Robot"
                                                      displayName:@"robot"  //self.demoData.users[randomUserId]
                                                             text:@"如果你没有得到它，我们可以重新发送。"];
        
        mutableArray = [[NSMutableArray alloc] initWithObjects:newMessage1, newMessage2, nil];
        messageModel.messages = mutableArray;
        messageModel.actionType = ActionTypePassword;
    }else if (actionType == ActionTypeCountry){
        JSQMessage *newMessage1 = [JSQMessage messageWithSenderId:@"Robot"
                                                      displayName:@"robot"  //self.demoData.users[randomUserId]
                                                             text:@"谢谢。出于税收目的，我们需要知道你的合法居住地"];
        JSQMessage *newMessage2 = [JSQMessage messageWithSenderId:@"Robot"
                                                      displayName:@"robot"  //self.demoData.users[randomUserId]
                                                             text:@"你的合法居住地在哪里？"];
        
        mutableArray = [[NSMutableArray alloc] initWithObjects:newMessage1, newMessage2, nil];
        messageModel.messages = mutableArray;
        messageModel.actionType = ActionTypeCountry;
    }
    return messageModel;
}
@end
