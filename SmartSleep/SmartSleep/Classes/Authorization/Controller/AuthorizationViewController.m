//
//  AuthorizationViewController.m
//  SmartSleep
//
//  Created by William Cai on 16/7/18.
//  Copyright © 2016年 William Cai. All rights reserved.
//

#import "AuthorizationViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>

@interface AuthorizationViewController ()<UISearchBarDelegate>
@property (weak, nonatomic)  UITextField *childNum;
@property (weak, nonatomic)  UIButton *searchBtn;
@property (strong,nonatomic) NSMutableArray *displayArray;//展示的数据
@property (strong,nonatomic) NSArray *oldDataArray;//存放原始数据

@end

@implementation AuthorizationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"添加账号";
    // 设置背景色
    self.view.backgroundColor = GlobalBackground;
    
    [self setupSearchBar];
    [self ConnectUrl];
    //显示指示器
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
}

-(void)setupSearchBar{
    self.childNum.frame = CGRectMake(20, 20, self.view.width-100, 30);
    
    [self.view addSubview:_childNum];

    
}

-(void)ConnectUrl {
    
    //发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";
    
    [[AFHTTPSessionManager manager] GET:@"http://121.42.151.185:8080/FamilySleep/device_getChild?childNum=12" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 隐藏指示器
        [SVProgressHUD dismiss];
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.displayArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Mycell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (self.displayArray.count == 0)
    {
        return cell;
    }
    cell.textLabel.text=self.displayArray[indexPath.row];
    
    return cell;
}




@end
