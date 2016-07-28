//
//  MyViewController.m
//  SmartSleep
//
//  Created by 许良 on 16/7/16.
//  Copyright © 2016年 fading. All rights reserved.
//

#import "ProfileViewController.h"
#import "UserInformationViewController.h"
#import "ChangePasswordViewController.h"
#import "SettingViewController.h"
#import "LoginViewController.h"

@interface ProfileViewController ()
//@property(strong,nonatomic) UIImageView *image;


@end

@implementation ProfileViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ProfileIdentifier = @"SettingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProfileIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ProfileIdentifier];
    }
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingCell" ];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch (indexPath.row) {
        case 0:
            cell.imageView.image = [UIImage imageNamed:@"avatar"];
            cell.textLabel.text = @"小小小";
            break;
        
        case 1:
            cell.textLabel.text = @"用户资料";
            break;
        case 2:
            cell.textLabel.text = @"修改密码";
            break;
        case 3:
            cell.textLabel.text = @"设置";
            break;
        case 4:
            cell.textLabel.text = @"注销账号";
            cell.textLabel.textColor = [UIColor redColor];
            break;
        default:
            break;
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 1: {
            UserInformationViewController *vc = [[UserInformationViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:{
            ChangePasswordViewController *vc = [[ChangePasswordViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3:{
            SettingViewController *vc = [[SettingViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 4:
            [self logout];
            break;
        default:
            break;
    }
}

-(void)logout{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"警告" message:@"是否确定注销" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alertView show];

    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserNameKey"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"PassWordKey"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        LoginViewController *vc = [[LoginViewController alloc]init];
        [vc setHidesBottomBarWhenPushed:NO];
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat h = 0;
    if (indexPath.row == 0) {
        h = 100;
    }else {
        h = 60;
    }
    return h;
}

@end
