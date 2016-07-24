//
//  DeviceStatisticsTableViewController.m
//  SmartSleep
//
//  Created by William Cai on 16/7/20.
//  Copyright © 2016年 William Cai. All rights reserved.
//

#import "DeviceStatisticsTableViewController.h"
#import "DataLabelModel.h"
#import "DataLabelCell.h"
#import "PieChartCell.h"
#import "EfficiencyCell.h"
#import "MovementCell.h"

#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>

@interface DeviceStatisticsTableViewController ()

@property (nonatomic, strong) DataLabelModel *dataLabel;

@end

@implementation DeviceStatisticsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTableView];
    [self setRefresh];
    
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

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DataLabelCell class]) bundle:nil] forCellReuseIdentifier:@"LabelCell"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PieChartCell class]) bundle:nil] forCellReuseIdentifier:@"PieChartCell"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([EfficiencyCell class]) bundle:nil] forCellReuseIdentifier:@"EfficiencyCell"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MovementCell class]) bundle:nil] forCellReuseIdentifier:@"MovementCell"];

}

- (void)setRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
//    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

#pragma mark - 数据处理

// 加载我的睡眠数据
- (void)loadNewData {
    // 结束上拉
    [self.tableView.mj_footer endRefreshing];
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://121.42.151.185:8080/FamilySleep/sleepQuality_getLastQuality?deviceId=34567&&sideId=0" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 字典 转 模型
        self.dataLabel = [DataLabelModel mj_objectWithKeyValues:responseObject[@"obj"]];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}


// 加载更多数据
- (void)loadMoreData {
    
    // 结束下拉
    [self.tableView.mj_header endRefreshing];
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://121.42.151.185:8080/FamilySleep/sleepQuality_getLastQuality?deviceId=34567&&sideId=0" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 字典 转 模型
        self.dataLabel = [DataLabelModel mj_objectWithKeyValues:responseObject[@"obj"]];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DataLabelCell *cell0 = [tableView dequeueReusableCellWithIdentifier:@"LabelCell"];
    DataLabelCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"PieChartCell"];
    EfficiencyCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"EfficiencyCell"];
    DataLabelCell *cell3 = [tableView dequeueReusableCellWithIdentifier:@"MovementCell"];
    
    cell0.dataLabel = self.dataLabel;
    cell1.dataLabel = self.dataLabel;
    cell2.dataLabel = self.dataLabel;
    cell3.dataLabel = self.dataLabel;
    
    cell0.selectionStyle = UITableViewCellSelectionStyleNone;
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    cell2.selectionStyle = UITableViewCellSelectionStyleNone;
    cell3.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0 ) {
        return cell0;
    } else if (indexPath.row == 1) {
        return cell1;
    } else if (indexPath.row == 2) {
        return cell2;
    }
    return cell3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 ) {
        return 80;
    }
    else if (indexPath.row == 1) {
        return 240;
    }
    return 60;
}
 
@end
