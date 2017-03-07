/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */

#import "EaseConversationModel.h"

#import "EMConversation.h"

@implementation EaseConversationModel

- (instancetype)initWithConversation:(EMConversation *)conversation
{
    self = [super init];
    if (self) {
        
        _conversation = conversation;
        
        EMMessage *message = [conversation lastReceivedMessage];
        NSDictionary *ext = message.ext;
        
        if (message)
        {
            _title = [ext valueForKey:@"senderName"];
            _avatarImage = [UIImage imageNamed:@"default"];
            _avatarURLPath = [ext valueForKey:@"senderPortrait"];
        }else{
            EMMessage *message = [conversation latestMessage];
            NSDictionary *ext = message.ext;
            _title = [ext valueForKey:@"receiverName"];
            _avatarImage = [UIImage imageNamed:@"default"];
            _avatarURLPath = [ext valueForKey:@"receiverPortrait"];
        }
        
    }
    
    return self;
}

@end
