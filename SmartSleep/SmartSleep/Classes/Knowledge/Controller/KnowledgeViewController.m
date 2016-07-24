//
//  KnowledgeViewController.m
//  SmartSleep
//
//  Created by William Cai on 16/7/15.
//  Copyright © 2016年 William Cai. All rights reserved.
//

#import "KnowledgeViewController.h"
#import "AuthorizationViewController.h"
#import "HotKnowledgeTableViewCell.h"
#import "HotKnowledgeModel.h"
#import "KnowledgeClassifyModel.h"

#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>

@interface KnowledgeViewController ()

@property (nonatomic, strong) NSArray *hotKnowledgeLists;
@property (nonatomic, strong) NSArray *knowledgeClassifyLists;

@end

@implementation KnowledgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBar];
    [self setTableView];
    [self setRefresh];
}

- (void)setNavigationBar {
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_addfriends" highlightedImage:@"navigationbar_addfriends_highlighted" target:self action:@selector(addFriends)];
    
    self.view.backgroundColor = GlobalBackground;
}

- (void)setTableView {
    // 设置内边距
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    // 设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    // 隐藏多余的cell
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = GlobalBackground;
    //self.tableView.tableFooterView = [[UIView alloc] init];
    
    // 注册Cell
//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MyRecordTableViewCell class]) bundle:nil] forCellReuseIdentifier:myRecordCellID];
}

- (void)setRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)addFriends {
    AuthorizationViewController *vc = [[AuthorizationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 数据处理

// 加载我的睡眠数据
- (void)loadNewData {
    // 结束上拉
    [self.tableView.mj_footer endRefreshing];
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://121.42.151.185:8080/FamilySleep/knowledge_getHotKnowledge?hotNum=3" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 字典 -> 模型
        self.hotKnowledgeLists = [HotKnowledgeModel mj_objectArrayWithKeyValuesArray:responseObject[@"objList"]];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
    
    // 发送请求获取知识分类
    [[AFHTTPSessionManager manager] GET:@"http://121.42.151.185:8080/FamilySleep/knowledge_getKnowledgeClassify" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 字典 -> 模型
        self.knowledgeClassifyLists = [KnowledgeClassifyModel mj_objectArrayWithKeyValuesArray:responseObject[@"objList"]];
        
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
    [[AFHTTPSessionManager manager] GET:@"http://121.42.151.185:8080/FamilySleep/knowledge_getHotKnowledge?hotNum=3" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 字典 转 模型
        self.hotKnowledgeLists = [HotKnowledgeModel mj_objectArrayWithKeyValuesArray:responseObject[@"objList"]];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
    
    // 发送请求获取知识分类
    [[AFHTTPSessionManager manager] GET:@"http://121.42.151.185:8080/FamilySleep/knowledge_getKnowledgeClassify" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 字典 转 模型
        self.knowledgeClassifyLists = [KnowledgeClassifyModel mj_objectArrayWithKeyValuesArray:responseObject[@"objList"]];
        
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

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    self.tableView.mj_footer.hidden = (self.hotKnowledgeLists.count == 0);
//    return self.hotKnowledgeLists.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    HotKnowledgeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@""];
//    
////    cell.hotKnowledge = self.hotKnowledgeLists[indexPath.row];
//    
//    return cell;
//}

//#pragma mark - Table view delegate
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 100;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
////    MonitorViewController *monitorVC = [[MonitorViewController alloc] init];
////    [self.navigationController pushViewController:monitorVC animated:YES];
//}

@end
