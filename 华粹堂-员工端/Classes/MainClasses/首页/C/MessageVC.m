//
//  MessageVC.m
//  ZhouMo
//
//  Created by liqiang on 16/9/20.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "MessageVC.h"
#import "RedDotManager.h"
#import "ModelMessage.h"
#import "NewsCategoryCell.h"
#import "NewsListViewController.h"
#import "AppDelegate.h"



//#import "EaseConversationModel.h"
//#import "EaseConversationCell.h"
//#import "EaseMob.h"
//#import "EaseSDKHelper.h"
//#import "EaseEmotionEscape.h"
//#import "EaseConversationCell.h"
//#import "EaseConvertToCommonEmoticonsHelper.h"
#import "NSDate+Category.h"

@interface MessageVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *messagesArray;
@property (nonatomic, strong) NSMutableArray *showDataArray;

@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic, weak) UIView *notLoginView;


@end

@implementation MessageVC

- (NSMutableArray *)showDataArray
{
    if (!_showDataArray)
    {
        _showDataArray = [NSMutableArray array];
    }
    
    return _showDataArray;
}

- (NSMutableArray *)messagesArray
{
    if (!_messagesArray) {
        _messagesArray = [NSMutableArray array];
    }
    
    return _messagesArray;
}

- (UIView *)notLoginView
{
    if (!_notLoginView)
    {
        UIView *notLoginView = [[UIView alloc] init];
        notLoginView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:notLoginView];
        _notLoginView = notLoginView;
        
        UIImageView *notLoginImageView = [[UIImageView alloc] init];
        notLoginImageView.image = [UIImage imageNamed:@"notLogin"];
        notLoginImageView.userInteractionEnabled = YES;
        [notLoginView addSubview:notLoginImageView];
        
        notLoginView.sd_layout
        .leftSpaceToView(self.view,0)
        .rightSpaceToView(self.view,0)
        .topSpaceToView(self.view,0)
        .bottomSpaceToView(self.view,48);
        
        notLoginImageView.sd_layout
        .centerXEqualToView(notLoginView)
        .centerYEqualToView(notLoginView)
        .widthIs(132)
        .heightIs(111);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoLogin)];
        [notLoginImageView addGestureRecognizer:tap];
    }
    
    return _notLoginView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.navigationController.childViewControllers.count == 1)
    {
        self.navigationItem.leftBarButtonItems = nil;
    }
    
    self.navigationItem.title = @"消息";
    self.dataArray = [[NSMutableArray alloc]init];
    
    [self drawView];
}

-(void)newsUpdate:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [self requestData];
    completionHandler(UIBackgroundFetchResultNewData);
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([ModelMember isLogin])
    {
        self.notLoginView.hidden = YES;
        [self requestData];
    }
    else
    {
        self.notLoginView.hidden = NO;
    }
    
    [self tableViewDidTriggerHeaderRefresh];
    
}

- (void)gotoLogin
{
//    AppDelegate *dele = APPDELEGATE;
//    [dele gotoLogin];
}

-(void)back
{
    [super back];
    if(!self.dataArray||self.dataArray.count==0)
    {
        return;
    }
    
    RedDotManager *reddotmanager = [RedDotManager sharedManager];
    
    if ([self checkIfHasMessageUnread])
    {
        [reddotmanager setIsAllRead:NO];
    }
    else
    {
        [reddotmanager setIsAllRead:YES];
    }
}

-(BOOL)checkIfHasMessageUnread
{
    for (ModelMessage *message in self.dataArray)
    {
        if (message.isViewed ==0)
        {
            return YES;
        }
    }
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void)drawView
{
    self.tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    
    self.tableview.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
}


#pragma mark -
#pragma mark ================= data =================
- (void)tableViewDidTriggerHeaderRefresh
{
//    [self removeEmptyConversationsFromDB];
    
    //获取会话数组
    self.messagesArray = [NSMutableArray arrayWithArray:[[EMClient sharedClient].chatManager getAllConversations]];
    
    //排序未置顶的会话的最后消息的时间
    NSArray* notTopChatArray = [self.messagesArray sortedArrayUsingComparator:
                                ^(EMConversation *obj1, EMConversation* obj2){
                                    EMMessage *message1 = [obj1 latestMessage];
                                    EMMessage *message2 = [obj2 latestMessage];
                                    
                                    if(message1.timestamp > message2.timestamp)
                                    {
                                        return(NSComparisonResult)NSOrderedAscending;
                                    }
                                    else
                                    {
                                        return(NSComparisonResult)NSOrderedDescending;
                                    }
                                }];
    
    self.showDataArray = [NSMutableArray array];
    
    for (ModelMessage *model in self.dataArray)
    {
        [self.showDataArray addObject:model];
    }
    
    for (EMConversation *converstion in notTopChatArray)
    {
        EaseConversationModel *model = nil;
        model = [[EaseConversationModel alloc] initWithConversation:converstion];
        
        NSLog(@"==>%@",model.title);
        
        if (model)
        {
            [self.showDataArray addObject:model];
        }
    }
    
    [self.tableview reloadData];
    
//    [self tableViewDidFinishTriggerHeader:YES reload:YES];
}

- (NSString *)_latestMessageTitleForConversationModel:(id<IConversationModel>)conversationModel
{
    NSString *latestMessageTitle = @"";
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];
    
    if (lastMessage)
    {
        switch (lastMessage.body.type)
        {
            case EMMessageBodyTypeImage:
            {
                latestMessageTitle = @"[图片]";
            }
                break;
                
            case EMMessageBodyTypeText:
            {
                // 表情映射。
                NSString *didReceiveText = [EaseConvertToCommonEmoticonsHelper
                                            convertToSystemEmoticons:((EMTextMessageBody *)lastMessage.body).text];
                latestMessageTitle = didReceiveText;
                
            }
                break;
                
            case EMMessageBodyTypeVoice:
            {
                latestMessageTitle = @"[语音]";
            }
                break;
                
            case EMMessageBodyTypeLocation:
            {
                latestMessageTitle = @"[位置]";
            }
                break;
                
            case EMMessageBodyTypeVideo:
            {
                latestMessageTitle = @"[视频]";
            }
                break;
                
            case EMMessageBodyTypeFile:
            {
                latestMessageTitle = @"[文件]";
            }
                break;
                
            default:
            {
                
            }
                break;
        }
    }
    
    return latestMessageTitle;
}

/**
 *  设置每条会话最后一条聊天的时间
 */
- (NSString *)setLatestMessageTimeForConversationModel:(id<IConversationModel>)conversationModel
{
    NSString *latestMessageTime = @"";
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];;
    if (lastMessage) {
        //        latestMessageTime = [NSDate formattedTimeFromTimeInterval:lastMessage.timestamp];
        latestMessageTime = [[NSDate dateWithTimeIntervalInMilliSecondSince1970:lastMessage.timestamp] formattedChatTime];
        
    }
    
    return latestMessageTime;
}

#pragma mark -
#pragma mark ================= 网络 =================
-(void)requestData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:[ModelMember sharedMemberMySelf].memberId forKey:@"memberId"];
    [params setObject:[UtilString getNoNilString:[UserDefaults valueForKey:@"deviceToken"]] forKey:@"deviceId"];
//    [params setValue:@"867465029895262" forKey:@"deviceId"];
//    [params setObject:@"2" forKey:@"deviceType"];

    [[LQHTTPSessionManager sharedManager] LQPost:@"message/listLastMessagesOfGroup" parameters:params showTips:@"正在加载..." success:^(id responseObject) {
        if (responseObject) {
            self.dataArray = [ModelMessage mj_objectArrayWithKeyValuesArray:responseObject];
        }
        
        [self tableViewDidTriggerHeaderRefresh];
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark -
#pragma mark ================= <UITableViewDelegate,UITableViewDataSource> =================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.showDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    id model = self.showDataArray[indexPath.row];
    
    if ([model isKindOfClass:[ModelMessage class]])
    {
        NewsCategoryCell *cell = [NewsCategoryCell cellWithIdentify:@"NewsCategoryCell" tableview:tableView];
        [cell loadData:self.showDataArray[indexPath.row]];
        return cell;
        
        //    ModelMessage *msgModel = self.dataArray[indexPath.row];
        //
        //    MessagePlistManager *manager = [MessagePlistManager sharedManager];
        //    BOOL isRead = [manager checkIfHasMessageId:msgModel.messageId groupType:msgModel.groupType];
        //    [cell showRedDot:!isRead];
    }
    
    
    if ([model isKindOfClass:[EaseConversationModel class]])
    {
        
        NSString *CellIdentifier = [EaseConversationCell cellIdentifierWithModel:nil];
        EaseConversationCell *cell = (EaseConversationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[EaseConversationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.titleLabelColor = HEXCOLOR(0x333333);
            cell.titleLabelFont = SYSTEM_FONT_(16);
        }
        
        EaseConversationModel *model =self.showDataArray[indexPath.row];
        
        cell.model = model;
        cell.detailLabel.text = [self _latestMessageTitleForConversationModel:model];
        cell.detailLabelFont=FONT_TEXTSIZE_Mid;
        cell.detailLabelColor = COLOR_darkGray;
        cell.titleLabelFont = FONT_TEXTSIZE_Big;
        cell.titleLabelColor = COLOR_Black;
        cell.timeLabelFont = FONT_TEXTSIZE_Mid;
        cell.timeLabelColor = COLOR_darkGray;
        cell.avatarView.showBadge = NO;
        cell.avatarView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor whiteColor];
        
        EMMessage *lastMessage = [model.conversation latestMessage];
        
        if (!lastMessage.isRead)
        {
            cell.detailLabel.textColor = [UIColor redColor];
            
        }
        else
        {
            cell.detailLabel.textColor = cell.detailLabelColor;
            
        }
        cell.timeLabel.text = [self setLatestMessageTimeForConversationModel:model];
        return cell;
    }
    
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.showDataArray[indexPath.row] isKindOfClass:[ModelMessage class]])
    {
        ModelMessage *model = self.showDataArray[indexPath.row];
        
        NewsListViewController *vc = [[NewsListViewController alloc] init];
        vc.groupType = model.groupType;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        
        
        EaseConversationModel *model =self.showDataArray[indexPath.row];
        EMMessage *message = [model.conversation latestMessage];
        EMMessage *message2 = [model.conversation lastReceivedMessage];
        
        EaseMessageViewController *vc = [[EaseMessageViewController alloc] initWithConversationChatter:model.conversation.conversationId conversationType:EMConversationTypeChat];
        vc.navigationItem.title = model.title;
        
        if (!message2)
        {
            NSDictionary *ext = message.ext;
            vc.receiverName = [ext valueForKey:@"receiverName"];
            vc.receiverPortrait = [ext valueForKey:@"receiverPortrait"];
            vc.receiverMemberId = [ext valueForKey:@"receiverMemberId"];
            vc.receiverPhone = [ext valueForKey:@"receiverPhone"];
            vc.navigationItem.title = [ext valueForKey:@"receiverName"];
        }else{
            NSDictionary *ext = message2.ext;
            vc.receiverName = [ext valueForKey:@"senderName"];
            vc.receiverPortrait = [ext valueForKey:@"senderPortrait"];
            vc.receiverMemberId = [ext valueForKey:@"senderMemberId"];
            vc.receiverPhone = [ext valueForKey:@"senderPhone"];
            vc.navigationItem.title = [ext valueForKey:@"senderName"];
        }
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
