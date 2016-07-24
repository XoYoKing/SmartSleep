//
//  FamilyRecordTableViewCell.m
//  SmartSleep
//
//  Created by William Cai on 16/7/19.
//  Copyright © 2016年 William Cai. All rights reserved.
//

#import "FamilyRecordTableViewCell.h"
#import "FamilyRecordModel.h"
#import <UIImageView+WebCache.h>

@interface FamilyRecordTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *familyRecordTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *familyRecordSleepDurationLabel;
@property (weak, nonatomic) IBOutlet UILabel *familyRecordSleepEfficiencyLabel;

@end


@implementation FamilyRecordTableViewCell

- (void)setFamilyRecord:(FamilyRecordModel *)familyRecord {
    _familyRecord = familyRecord;
    
    NSString *str = [NSString stringWithFormat:@"%@", familyRecord.sleepDate[@"time"]];
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:[str doubleValue]/1000];
    
    //格式化日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss EEEE"];
    NSString *detailTime = [dateFormatter stringFromDate:time];
    
    self.familyRecordTimeLabel.text = detailTime;
    self.familyRecordSleepDurationLabel.text = [NSString stringWithFormat:@"%zd小时", familyRecord.sleepDuration];
    self.familyRecordSleepEfficiencyLabel.text = [NSString stringWithFormat:@"%zd％", familyRecord.efficiency];
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
