//
//  MyReportViewController.m
//  SmartSleep
//
//  Created by 许良 on 16/7/24.
//  Copyright © 2016年 William Cai. All rights reserved.
//

#import "MyReportViewController.h"
#import "TitleViewViewCell.h"

@interface MyReportViewController ()<UIScrollViewDelegate>


@end

@implementation MyReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTableView];
    
    
}

- (void)setTableView {
    // 设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = TitlesViewH + TitlesViewY;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    // 隐藏多余的cell
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    //self.tableView.tableFooterView = [[UIView alloc] init];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TitleViewViewCell *cell = [TitleViewViewCell ReportViewCellWith:tableView indexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//     [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger h = 0;
    switch (indexPath.row) {
        case 0:
            h = 300;
            break;
        case 1:
            h = 300;
            break;
        default:
            break;
    }
    return h;
}






@end
