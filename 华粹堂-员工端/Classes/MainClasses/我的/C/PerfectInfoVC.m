//
//  PerfectInfoVC.m
//  WaterMan
//
//  Created by liqiang on 15/12/25.
//  Copyright © 2015年 baichun. All rights reserved.
//

#import "PerfectInfoVC.h"
#import "PerfectInfoPortraitCell.h"
#import "PerfectionfoCell.h"
#import "PerfectInfoModifyNameVC.h"
#import "PerfectInfoModifySelfIntroduceVC.h"
#import "GenderPickerView.h"
#import "RSKImageCropper.h"
#import "PerfectInfoModifyTelNumVC.h"

@interface PerfectInfoVC ()<UITableViewDelegate,UITableViewDataSource,GenderPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,RSKImageCropViewControllerDelegate>


@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) GenderPickerView *genderPickerView;

@end

@implementation PerfectInfoVC

- (GenderPickerView *)genderPickerView
{
    if (!_genderPickerView)
    {
        GenderPickerView *pickView = [[GenderPickerView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight)];
        pickView.delegate = self;
        [self.view.window addSubview: pickView];
        _genderPickerView = pickView;
    }
    
    return _genderPickerView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"个人信息";
    
    [self drawView];
    
}

- (void)dealloc
{
    NSLog(@"%@释放了",NSStringFromClass(self.class));
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)drawView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.sd_layout
    .topSpaceToView(self.view,0)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
}

- (void)changeIconImageView
{
    __weak typeof(self) weakSelf = self;
    LCActionSheet *sheet = [[LCActionSheet alloc] initWithTitle:nil buttonTitles:@[@"拍照",@"从相册中选取"] redButtonIndex:-1 delegate:nil];
    sheet.didClickedButtonAtIndex = ^(NSInteger btnIndex,NSString *title){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = weakSelf;
        
        if (btnIndex == 0)
        {
            //判断相机是否可用
            BOOL hasCamera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
            if (hasCamera)
            {
                UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
                picker.sourceType = sourceType;
                picker.allowsEditing = NO;
                [self presentViewController:picker animated:YES completion:nil];
            }
            else
            {
                [LCProgressHUD showFailure:@"相机不可用"];
            }
        }
        else if (btnIndex == 1)
        {
            // 从相册中选取
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.navigationBar.barTintColor = NAV_BAR_COLOR;
            picker.navigationBar.tintColor = [UIColor blackColor];
            picker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor]};
            [weakSelf presentViewController:picker animated:YES completion:nil];
        }
    };
    [sheet show];
}


#pragma mark -
#pragma mark ================= <UITableViewDelegate,UITableViewDataSource> =================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        PerfectInfoPortraitCell *cell = [[PerfectInfoPortraitCell alloc] init];
        [cell.iconImageView sd_setImageWithURL:IMAGE_URL([ModelMember sharedMemberMySelf].portrait) placeholderImage:[UIImage imageNamed:@"touxiang"]];
        return cell;
    }
    
    NSArray *array = @[@"头像",@"真实姓名",@"个性签名",@"性别",@"手机号"];
    PerfectionfoCell *cell = [[PerfectionfoCell alloc] init];
    cell.label.text = array[indexPath.section];
    
    if (indexPath.section == 1)
    {
        cell.contentLabel.text = [ModelMember sharedMemberMySelf].name;
    }
    
    if (indexPath.section == 2)
    {
        cell.contentLabel.text = [ModelMember sharedMemberMySelf].signature.length?[ModelMember sharedMemberMySelf].signature:@"";
    }
    
    if (indexPath.section == 3)
    {
        cell.contentLabel.text = [[ModelMember sharedMemberMySelf].sex isEqualToString:@"0"]?@"男":@"女";
    }
    
    if (indexPath.section == 4)
    {
        cell.contentLabel.text = [ModelMember sharedMemberMySelf].telephone;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 80;
    }
    
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 1)
    {
        return 10;
    }
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        NSLog(@"修改图片");
        [self changeIconImageView];
    }
    
    if (indexPath.section == 1) {
        PerfectInfoModifyNameVC *vc = [[PerfectInfoModifyNameVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.section == 2) {
        PerfectInfoModifySelfIntroduceVC *vc = [[PerfectInfoModifySelfIntroduceVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.section == 3) {
        self.genderPickerView.hidden = NO;
        [self.genderPickerView showMyPickerWithIsMan:1];
    }
    
    if (indexPath.section == 4) {
        PerfectInfoModifyTelNumVC *vc = [[PerfectInfoModifyTelNumVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark -
#pragma mark ================= GenderPickerViewDelegate =================
- (void)ensureWithGender:(NSString *)gender
{
    [self requestModifyGenderWithGender:gender];
}

#pragma mark -
#pragma mark ================= UIImagePickerControllerDelegate =================
/**
 *  从相册获取照片的回掉
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)aImage editingInfo:(NSDictionary *)editingInfo
{
    RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:aImage];
    imageCropVC.delegate = self;
    [picker presentViewController:imageCropVC animated:NO completion:nil];
}

#pragma mark -
#pragma mark ================= RSKImageCropViewControllerDelegate =================
- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imageCropViewController:(RSKImageCropViewController *)controller
                   didCropImage:(UIImage *)croppedImage
                  usingCropRect:(CGRect)cropRect
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self uploadPortraitRequestWithPortrait:croppedImage];
}

#pragma mark -
#pragma mark ================= 网络 =================
//上传头像
- (void)uploadPortraitRequestWithPortrait:(UIImage *)portrait
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[ModelMember sharedMemberMySelf].memberId forKey:@"employeeId"];
    
    NSMutableArray *fileInfos = [NSMutableArray array];
    NSDictionary *dic = @{@"kFileData":UIImageJPEGRepresentation(portrait, 0.1),
                          @"kName":@"portrait",
                          @"kFileName":@"header.jpg",
                          @"kMimeType":@"image/png"};
    [fileInfos addObject:dic];
    
    [[LQHTTPSessionManager sharedManager] LQPost:@"employee/modifyPortrait" parameters:params fileInfo:fileInfos showTips:@"正在上传..." success:^(id responseObject) {
        
        [LCProgressHUD showSuccess:@"上传成功"];
        [[SDImageCache sharedImageCache] storeImage:portrait forKey:[NSString stringWithFormat:@"%@%@",IMAGES_OSS_PIC,[ModelMember sharedMemberMySelf].portrait]];
        
        ModelMember *member = [ModelMember sharedMemberMySelf];
        member.portrait = responseObject;
        NSMutableDictionary *dic = [member mj_keyValues];
        [ModelMember doLoginWithMemberDic:dic];
        [self.tableView reloadData];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gaibian" object:nil];
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

//修改性别
- (void)requestModifyGenderWithGender:(NSString *)gender
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[ModelMember sharedMemberMySelf].memberId forKey:@"employeeId"];
    [params setValue:@([gender isEqualToString:@"男"]?0:1) forKey:@"sex"];
    
    [[LQHTTPSessionManager sharedManager] LQPost:@"employee/modifyGender" parameters:params showTips:@"正在修改..." success:^(id responseObject) {
        [LCProgressHUD showSuccess:@"修改成功"];
        
        ModelMember *member = [ModelMember sharedMemberMySelf];
        member.sex = [gender isEqualToString:@"男"]?@"0":@"1";
        
        NSMutableDictionary *dic = [[ModelMember sharedMemberMySelf] mj_keyValues];
        [ModelMember doLoginWithMemberDic:dic];
        
        [self.tableView reloadData];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gaibian" object:nil];
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

@end
