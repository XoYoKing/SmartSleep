//
//  DataLabelCell.m
//  SmartSleep
//
//  Created by William Cai on 16/7/20.
//  Copyright © 2016年 William Cai. All rights reserved.
//

#import "DataLabelCell.h"
#import "DataLabelModel.h"

@interface DataLabelCell ()

@property (weak, nonatomic) IBOutlet UIButton *bedButton;
@property (weak, nonatomic) IBOutlet UIButton *asleepButton;
@property (weak, nonatomic) IBOutlet UIButton *sleeptimeButton;
@property (weak, nonatomic) IBOutlet UIButton *fallasleepButton;

@end

@implementation DataLabelCell

/*
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
*/

- (void)setDataLabel:(DataLabelModel *)dataLabel {
    _dataLabel = dataLabel;
    
    // 将字典中[@"time"]对应的值取到，再转换成NSString类型
    NSString *sleepTimeStr = [NSString stringWithFormat:@"%@", dataLabel.sleepDate[@"time"]];
    NSString *offBedTimeStr = [NSString stringWithFormat:@"%@", dataLabel.offBedTime[@"time"]];
    NSString *fallAsleepTimeStr = [NSString stringWithFormat:@"%@", dataLabel.fallAsleepTime[@"time"]];
    NSString *wakeTimeStr = [NSString stringWithFormat:@"%@", dataLabel.wakeTime[@"time"]];
    
    // 将NSString类型的数据转成doubleValue/1000，再转换成NSDate类型
    NSDate *sleepTimeDate = [NSDate dateWithTimeIntervalSince1970:[sleepTimeStr doubleValue]/1000];
    NSDate *offBedTimeDate = [NSDate dateWithTimeIntervalSince1970:[offBedTimeStr doubleValue]/1000];
    NSDate *fallAsleepTimeDate = [NSDate dateWithTimeIntervalSince1970:[fallAsleepTimeStr doubleValue]/1000];
    NSDate *wakeTimeDate = [NSDate dateWithTimeIntervalSince1970:[wakeTimeStr doubleValue]/1000];
    
    // 格式化日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    
    // 将NSDate类型数据格式化成需要的日期格式，再转成NSString类型
    NSString *sleepTimeDetail = [dateFormatter stringFromDate:sleepTimeDate];
    NSString *offBedTimeDetail = [dateFormatter stringFromDate:offBedTimeDate];
    NSString *fallAsleepTimeDetail = [dateFormatter stringFromDate:fallAsleepTimeDate];
    NSString *wakeTimeDetail = [dateFormatter stringFromDate:wakeTimeDate];
    
    [self.bedButton setTitle:[NSString stringWithFormat:@"%@-%@", sleepTimeDetail, offBedTimeDetail] forState:UIControlStateNormal];
    [self.asleepButton setTitle:[NSString stringWithFormat:@"%@-%@", fallAsleepTimeDetail, wakeTimeDetail] forState:UIControlStateNormal];
    [self.sleeptimeButton setTitle:[NSString stringWithFormat:@"%zd 小时", dataLabel.sleepDuration] forState:UIControlStateNormal];
    [self.fallasleepButton setTitle:[NSString stringWithFormat:@"%.0f 分钟", dataLabel.fallAsleepDuration*60] forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame {
    
    static CGFloat margin = 2;
    
//    frame.size.height -= margin;
    frame.origin.y += margin;
    
    [super setFrame:frame];
}

@end
