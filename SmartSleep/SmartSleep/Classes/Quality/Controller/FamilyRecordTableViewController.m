//
//  FamilyRecordTableViewController.m
//  SmartSleep
//
//  Created by William Cai on 16/7/18.
//  Copyright © 2016年 William Cai. All rights reserved.
//

#import "FamilyRecordTableViewController.h"
#import "FamilyRecordTableViewCell.h"
#import "FamilyRecordModel.h"

#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>

@interface FamilyRecordTableViewController ()

@property (nonatomic, strong) NSArray *familyRecords;

@end

@implementation FamilyRecordTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTableView];
    [self setRefresh];
}

static NSString * const familyRecordCellID= @"FamilyRecordCell";

- (void)setTableView {
    
    self.view.backgroundColor = GlobalBackground;
    
    // 隐藏多余的cell
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 注册Cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FamilyRecordTableViewCell class]) bundle:nil] forCellReuseIdentifier:familyRecordCellID];
}

- (void)setRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

#pragma mark - 数据处理

// 加载我的睡眠数据
- (void)loadNewData {
    // 结束上拉
    [self.tableView.mj_footer endRefreshing];
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://121.42.151.185:8080/FamilySleep/sleepQuality_getHistoryQuality?userId=1" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 字典 转 模型
        self.familyRecords = [FamilyRecordModel mj_objectArrayWithKeyValuesArray:responseObject[@"objList"]];
        
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
    [[AFHTTPSessionManager manager] GET:@"http://121.42.151.185:8080/FamilySleep/sleepQuality_getHistoryQuality?userId=1" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 字典 转 模型
        self.familyRecords = [FamilyRecordModel mj_objectArrayWithKeyValuesArray:responseObject[@"objList"]];
        
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
    self.tableView.mj_footer.hidden = (self.familyRecords.count == 0);
    return self.familyRecords.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FamilyRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:familyRecordCellID];
    
    cell.familyRecord = self.familyRecords[indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


@end
