//
//  ReportDetailViewController.m
//  SmartSleep
//
//  Created by 许良 on 16/7/25.
//  Copyright © 2016年 William Cai. All rights reserved.
//

#import "ReportDetailViewController.h"

#import "PNChart.h"

#import "SleepEfficiencyViewController.h"
#import "SleepDurationViewController.h"
#import "FallAsleepViewController.h"
#import "SleepLeaveViewController.h"
#import "SleepMoveViewController.h"

@interface ReportDetailViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIView *titlesView;
@property (nonatomic, weak) UIScrollView *contentView;
@property (nonatomic, weak) UIView *bar;
@property (nonatomic, weak) UIButton *selectedButton;
@property (nonatomic) PNLineChart * lineChart;
@property (nonatomic) UIView * legend;
@end

@implementation ReportDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleView];
    [self setContentView];
    self.view.backgroundColor = GlobalBackground;
    
    [self setupHead];
    
    
}

- (void)setupHead {
    UILabel *HeadLabel = [[UILabel alloc] init];
    HeadLabel.backgroundColor = RGBColor(47, 191, 104);
    HeadLabel.text = @"爸爸";
    HeadLabel.textColor = [UIColor whiteColor];
    HeadLabel.textAlignment = NSTextAlignmentCenter;
    HeadLabel.width = self.view.width;
    HeadLabel.height = TitlesViewH;
    HeadLabel.y = TitlesViewY;
    [self.view addSubview:HeadLabel];

}


- (void)setTitleView {
    // 顶部标签栏view
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [UIColor whiteColor];
    titlesView.width = self.view.width;
    titlesView.height = TitlesViewH;
    titlesView.y = TitlesViewY + TitlesViewH;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 底部的绿色指示器
    UIView *bar = [[UIView alloc] init];
    bar.backgroundColor = RGBColor(47, 191, 104);
    bar.height = 2.3;
    bar.y = titlesView.height - bar.height;
    self.bar = bar;
    
    // 内部的子标签
    NSArray *titles = @[@"睡眠效率", @"睡眠时长", @"入睡时长", @"离床次数", @"体动次数"];
    CGFloat width = titlesView.width / titles.count;
    CGFloat height = titlesView.height;
    
    for (NSInteger i = 0; i<titles.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i * width;
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:RGBColor(47, 191, 104) forState:UIControlStateDisabled];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        // 默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            [self setupChartLine:@[@"0%",@"20%",@"40%",@"60%",@"80%",@"100%"] yMaxValue:100 dataArr: @[@89, @83, @98, @78, @81] dataTitle:@"睡眠效率"];
            // 让按钮内部的label根据文字内容来计算尺寸
            self.bar.width = button.width;
            self.bar.centerX = button.centerX;
        }
    }
    [titlesView addSubview:bar];
}

- (void)titleClick:(UIButton *)button {
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        self.bar.width = button.width;
        self.bar.centerX = button.centerX;
    }];
    
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
    
    [self.lineChart removeFromSuperview];
    [self.legend removeFromSuperview];
    switch (button.tag) {
        case 0:
            [self setupChartLine:@[@"0%",@"20%",@"40%",@"60%",@"80%",@"100%"] yMaxValue:100 dataArr: @[@89, @83, @98, @78, @81] dataTitle:@"睡眠效率"];
            break;
        case 1:
            [self setupChartLine:@[@"0小时",@"2小时",@"4小时",@"6小时",@"8小时",@"10小时",@"12小时"] yMaxValue:12.0 dataArr:@[@9, @8.3, @8, @9, @9] dataTitle:@"睡眠时长"];
            break;
        case 2:
            [self setupChartLine:@[@"0分钟",@"20分钟",@"40分钟",@"60分钟",@"80分钟",@"100分钟",@"120分钟"] yMaxValue:120.0 dataArr:@[@30, @60, @30, @10, @30] dataTitle:@"入睡时长"];
            break;
        case 3:
            [self setupChartLine:@[@"0次",@"5次",@"10次",@"15次",@"20次"] yMaxValue:20.0 dataArr:@[@0, @2, @0, @0, @0] dataTitle:@"离床次数"];
            break;
        case 4:
            [self setupChartLine:@[@"0次",@"5次",@"10次",@"15次",@"20次"] yMaxValue:20.0 dataArr:@[@1, @5, @0, @2, @0] dataTitle:@"体动次数"];
            break;
       
        default:
            break;
    }
}

- (void)setupChartLine:(NSArray *)Ylael yMaxValue:(NSInteger)yMaxValue dataArr:(NSArray*)dataArr dataTitle:(NSString*)dataTitle{
    
    self.lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(20, 180.0, SCREEN_WIDTH-20, 200.0)];
    self.lineChart.yLabelFormat = @"%1.1f";
    self.lineChart.backgroundColor = [UIColor clearColor];
    [self.lineChart setXLabels:@[@"12-05",@"12-06",@"01-10",@"01-18",@"01-24"]];
    self.lineChart.showCoordinateAxis = YES;
    
    // added an examle to show how yGridLines can be enabled
    // the color is set to clearColor so that the demo remains the same
    self.lineChart.yGridLinesColor = [UIColor clearColor];
    self.lineChart.showYGridLines = YES;
    
    //Use yFixedValueMax and yFixedValueMin to Fix the Max and Min Y Value
    //Only if you needed
    self.lineChart.yFixedValueMax = yMaxValue;
    self.lineChart.yFixedValueMin = 0.0;
    
    [self.lineChart setYLabels:Ylael];
    
    // Line Chart #1
    NSArray * data01Array = dataArr;
    PNLineChartData *data01 = [PNLineChartData new];
    data01.dataTitle = dataTitle;
    data01.color = PNFreshGreen;
    data01.alpha = 0.3f;
    data01.itemCount = data01Array.count;
    data01.inflexionPointColor = PNRed;
    data01.inflexionPointStyle = PNLineChartPointStyleTriangle;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    self.lineChart.chartData = @[data01];
    [self.lineChart strokeChart];
    //    self.lineChart.delegate = self;
    
    
    [self.view addSubview:self.lineChart];
    
    self.lineChart.legendStyle = PNLegendItemStyleStacked;
    self.lineChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
    self.lineChart.legendFontColor = [UIColor redColor];
    
    self.legend = [self.lineChart getLegendWithMaxWidth:320];
    [self.legend setFrame:CGRectMake(30, 400, self.legend.frame.size.width, self.legend.frame.size.width)];
    [self.view addSubview:self.legend];
    
}




-(void)setupLabel {
    
    NSArray *titleArrL = @[@"已记录天数",@"平均睡眠时长",@"平均体动次数"];
    NSArray *titleArrR = @[@"平均睡眠效率",@"平均入睡时长",@"平均离床次数"];
    NSArray *dataArrL = @[@"5",@"8小时42分钟",@"1.6"];
    NSArray *dataArrR = @[@"86.8",@"30分钟",@"0.2"];
    
    for (NSInteger i = 0; i < 3; i++) {
        UILabel *titleLabelL = [[UILabel alloc]initWithFrame:CGRectMake(50, 480+i*50, 110, 30)];
        UILabel *titleLabelR = [[UILabel alloc]initWithFrame:CGRectMake(self.view.width - 150, 480+i*50, 110, 30)];
        UILabel *dataLabelL = [[UILabel alloc]initWithFrame:CGRectMake(50, 460+i*50, 110, 30)];
        UILabel *dataLabelR = [[UILabel alloc]initWithFrame:CGRectMake(self.view.width - 150, 460+i*50, 110, 30)];
        titleLabelL.textAlignment = NSTextAlignmentCenter;
        titleLabelR.textAlignment = NSTextAlignmentCenter;
        dataLabelL.textAlignment = NSTextAlignmentCenter;
        dataLabelR.textAlignment = NSTextAlignmentCenter;
        
        titleLabelL.textColor = [UIColor grayColor];
        titleLabelR.textColor = [UIColor grayColor];
        dataLabelL.textColor = RGBColor(47, 191, 104);
        dataLabelR.textColor = RGBColor(47, 191, 104);
        titleLabelL.text = titleArrL[i];
        titleLabelR.text = titleArrR[i];
        dataLabelL.text = dataArrL[i];
        dataLabelR.text = dataArrR[i];
        [self.view addSubview:titleLabelL];
        [self.view addSubview:titleLabelR];
        [self.view addSubview:dataLabelL];
        [self.view addSubview:dataLabelR];
        
        
    }
    
}







- (void)setContentView{
    
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
//    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}


#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // 当前的索引
//    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
//    // 取出子控制器
//    UITableViewController *vc = self.childViewControllers[index];
//    vc.view.x = scrollView.contentOffset.x;
//    vc.view.y = 0;
//    vc.view.height = scrollView.height;
//    
//    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
}



@end
