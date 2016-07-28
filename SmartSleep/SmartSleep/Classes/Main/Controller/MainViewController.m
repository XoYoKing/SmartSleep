//
//  MainViewController.m
//  SmartSleep
//
//  Created by William Cai on 16/7/15.
//  Copyright © 2016年 William Cai. All rights reserved.
//

#import "MainViewController.h"
#import "MonitorViewController.h"
#import "QualityViewController.h"
#import "StatisticsViewController.h"
#import "KnowledgeViewController.h"
#import "ProfileViewController.h"
#import "CustomNavigationController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addChildViewController];
//    self.navigationController.navigationItem.backBarButtonItem.accessibilityElementsHidden = YES;
    
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addChildViewController {
    
    self.tabBar.tintColor = RGBColor(47, 191, 104);
    
    [self setChildViewController:[[MonitorViewController alloc] init] title:@"睡眠监测" image:@"tabbar_monitor" selectedImage:@"tabbar_monitor_highlighted"];

    [self setChildViewController:[[QualityViewController alloc] init] title:@"睡眠质量" image:@"tabbar_quality" selectedImage:@"tabbar_quality_highlighted"];

    [self setChildViewController:[[StatisticsViewController alloc] init] title:@"睡眠报表" image:@"tabbar_statistics" selectedImage:@"tabbar_statistics_highlighted"];

    [self setChildViewController:[[KnowledgeViewController alloc] init] title:@"睡眠知识" image:@"tabbar_knowledge" selectedImage:@"tabbar_knowledge_highlighted"];
    
    [self setChildViewController:[[ProfileViewController alloc] init] title:@"我的" image:@"tabbar_profile" selectedImage:@"tabbar_profile_highlighted"];
    
}

- (void)setChildViewController:(UIViewController *)childController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    // 设置文字和图片
    //vc.navigationItem.title = title;
    //vc.tabBarItem.title = title;
    childController.title = title;
    childController.tabBarItem.image = [UIImage imageNamed:image];
    childController.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    CustomNavigationController *nav = [[CustomNavigationController alloc] initWithRootViewController:childController];
    [self addChildViewController:nav];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
