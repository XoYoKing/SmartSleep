//
//  PieChartCell.m
//  SmartSleep
//
//  Created by William Cai on 16/7/21.
//  Copyright © 2016年 William Cai. All rights reserved.
//

#import "PieChartCell.h"
#import "DataLabelModel.h"

#import <PNChart.h>

@interface PieChartCell ()

@property (weak, nonatomic) IBOutlet UIView *pieChartView;

@property (nonatomic, strong) PNPieChart *pieChart;

@property (nonatomic, assign) CGFloat deepSleepData;
@property (nonatomic, assign) CGFloat lightSleepData;
@property (nonatomic, assign) CGFloat dreamSleepData;
@property (nonatomic, assign) CGFloat wakeSleepData;

@property (nonatomic, copy) NSArray *items;

@end

@implementation PieChartCell

/*
- (void)awakeFromNib {
    
    NSArray *items = @[
                   [PNPieChartDataItem dataItemWithValue:1 color:RGBColor(47, 191, 104) description:@"深睡"],
                   [PNPieChartDataItem dataItemWithValue:1 color:RGBColor(248, 88,33) description:@"浅睡"],
                   [PNPieChartDataItem dataItemWithValue:1 color:RGBColor(245, 147, 49) description:@"做梦"],
                   [PNPieChartDataItem dataItemWithValue:1 color:RGBColor(37, 89, 222) description:@"醒来"]
                   ];
    
    PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(10, 10, 220, 220) items:items];
    pieChart.descriptionTextColor = [UIColor whiteColor];
    pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium"size:14.0];
    
    // 绘制
    [self.pieChart strokeChart];
    
    //加载在视图上
    [self.pieChartView addSubview:self.pieChart];
}
*/

- (void)setDataLabel:(DataLabelModel *)dataLabel {
    _dataLabel = dataLabel;
    
    self.deepSleepData = dataLabel.deepSleep;
    self.lightSleepData = dataLabel.lightSleep;
    self.dreamSleepData = dataLabel.dreamSleep;
    self.wakeSleepData = dataLabel.wakeSleep;
    
    self.items = @[
                   [PNPieChartDataItem dataItemWithValue:self.deepSleepData color:RGBColor(47, 191, 104) description:@"深睡"],
                   [PNPieChartDataItem dataItemWithValue:self.lightSleepData color:RGBColor(248, 88,33) description:@"浅睡"],
                   [PNPieChartDataItem dataItemWithValue:self.dreamSleepData color:RGBColor(245, 147, 49) description:@"做梦"],
                   [PNPieChartDataItem dataItemWithValue:self.wakeSleepData color:RGBColor(37, 89, 222) description:@"醒来"]
                   ];
    
    
    self.pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(10, 10, 220, 220) items:self.items];
    self.pieChart.descriptionTextColor = [UIColor whiteColor];
    self.pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium"size:14.0];
    
    // 绘制
    [self.pieChart strokeChart];
    
    //加载在视图上
    [self.pieChartView addSubview:self.pieChart];
    
}

@end
