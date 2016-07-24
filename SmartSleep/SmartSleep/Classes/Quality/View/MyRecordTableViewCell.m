//
//  MyRecordTableViewCell.m
//  SmartSleep
//
//  Created by William Cai on 16/7/19.
//  Copyright © 2016年 William Cai. All rights reserved.
//

#import "MyRecordTableViewCell.h"
#import "MyRecordModel.h"

@interface MyRecordTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *sleepDurationLabel;
@property (weak, nonatomic) IBOutlet UILabel *sleepEfficiencyLabel;

@end

@implementation MyRecordTableViewCell

- (void)setMyRecord:(MyRecordModel *)myRecord {
    _myRecord = myRecord;
    
    NSString *str = [NSString stringWithFormat:@"%@", myRecord.sleepDate[@"time"]];
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:[str doubleValue]/1000];
    
    //格式化日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss EEEE"];
    NSString *detailTime = [dateFormatter stringFromDate:time];
    
    self.timeLable.text = detailTime;
    self.sleepDurationLabel.text = [NSString stringWithFormat:@"%zd小时", myRecord.sleepDuration];
    self.sleepEfficiencyLabel.text = [NSString stringWithFormat:@"%zd％", myRecord.efficiency];
}

- (void)setFrame:(CGRect)frame {
    
    static CGFloat margin = 5;
    
    //frame.origin.x = margin;
    //frame.size.width -= 2 * margin;
    frame.size.height -= margin;
    frame.origin.y += margin;
    
    [super setFrame:frame];
}

@end
