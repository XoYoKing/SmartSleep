//
//  FamilyListTableViewController.m
//  SmartSleep
//
//  Created by William Cai on 16/7/20.
//  Copyright © 2016年 William Cai. All rights reserved.
//

#import "FamilyListTableViewController.h"
#import "FamilyListTableViewCell.h"
#import "FamilyListModel.h"

#import "FamilyRecordTableViewController.h"

#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>

@interface FamilyListTableViewController ()

@property (nonatomic, strong) NSArray *familyLists;

@end

@implementation FamilyListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTableView];
    [self setRefresh];
}

static NSString * const familyListCellID= @"FamilyListCell";

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
    
    // 注册Cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FamilyListTableViewCell class]) bundle:nil] forCellReuseIdentifier:familyListCellID];
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
    [[AFHTTPSessionManager manager] GET:@"http://121.42.151.185:8080/FamilySleep/family_listFamilys?userId=3" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 字典 转 模型
        self.familyLists = [FamilyListModel mj_objectArrayWithKeyValuesArray:responseObject[@"objList"]];
        
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
    [[AFHTTPSessionManager manager] GET:@"http://121.42.151.185:8080/FamilySleep/family_listFamilys?userId=3" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 字典 转 模型
        self.familyLists = [FamilyListModel mj_objectArrayWithKeyValuesArray:responseObject[@"objList"]];
        
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
    self.tableView.mj_footer.hidden = (self.familyLists.count == 0);
    return self.familyLists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FamilyListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:familyListCellID];
    
    cell.familyList = self.familyLists[indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FamilyRecordTableViewController *familyRecordTableVC = [[FamilyRecordTableViewController alloc] init];
    [self.navigationController pushViewController:familyRecordTableVC animated:YES];
}

@end
