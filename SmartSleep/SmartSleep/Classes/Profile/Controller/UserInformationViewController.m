//
//  UserInformationViewController.m
//  SmartSleep
//
//  Created by 许良 on 16/7/16.
//  Copyright © 2016年 fading. All rights reserved.
//

#import "UserInformationViewController.h"

@interface UserInformationViewController ()
@property(strong,nonatomic) NSArray *MenuItem;
@property(strong,nonatomic) NSArray *ShowData;
@end

@implementation UserInformationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    self.MenuItem = [NSArray arrayWithObjects:@"头像",@"手机号",@"用户名",@"性别",@"出生日期", nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.MenuItem.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *UserInfoIdentifier = @"UserInfo";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UserInfoIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:UserInfoIdentifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.MenuItem[indexPath.row];
    self.ShowData = [NSArray arrayWithObjects:@"15100000000",@"儿子",@"男",@"2016-05-16",nil];
    if (indexPath.row == 0) {
        UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"clearlove"]];
        image.frame = CGRectMake(220, 0, 120, 100);
        [cell addSubview:image];
        
    }else {
        UILabel *lab = [[UILabel alloc]init];
        lab.text = self.ShowData[indexPath.row - 1];
        lab.frame = CGRectMake(220, 20, 120, 20);
        [cell addSubview:lab];
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat h = 1;
    if (indexPath.row == 0) {
        h = 110;
    }else {
        h = 60;
    }
    return h;
}

@end
