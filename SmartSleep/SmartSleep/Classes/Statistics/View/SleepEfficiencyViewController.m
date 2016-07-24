//
//  SleepEfficiencyViewController.m
//  SmartSleep
//
//  Created by 许良 on 16/7/24.
//  Copyright © 2016年 William Cai. All rights reserved.
//

#import "SleepEfficiencyViewController.h"
#import "PNChart.h"

@interface SleepEfficiencyViewController ()
@property (nonatomic) PNLineChart * lineChart;
@end

@implementation SleepEfficiencyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChartLine];
    [self setupLabel];
}

-(void)setupChartLine {
    
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
    self.lineChart.yFixedValueMax = 100.0;
    self.lineChart.yFixedValueMin = 0.0;
    
    [self.lineChart setYLabels:@[@"0%",@"20%",@"40%",@"60%",@"80%",@"100%"]];
    
    // Line Chart #1
    NSArray * data01Array = @[@89, @83, @98, @78, @81];
    PNLineChartData *data01 = [PNLineChartData new];
    data01.dataTitle = @"睡眠效率";
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
    
    UIView *legend = [self.lineChart getLegendWithMaxWidth:320];
    [legend setFrame:CGRectMake(30, 400, legend.frame.size.width, legend.frame.size.width)];
    [self.view addSubview:legend];

    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
