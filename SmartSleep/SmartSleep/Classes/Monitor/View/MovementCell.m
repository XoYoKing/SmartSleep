//
//  MovementCell.m
//  SmartSleep
//
//  Created by William Cai on 16/7/21.
//  Copyright © 2016年 William Cai. All rights reserved.
//

#import "MovementCell.h"
#import "DataLabelModel.h"

@interface MovementCell ()

@property (weak, nonatomic) IBOutlet UILabel *sleepLeaveLabel;
@property (weak, nonatomic) IBOutlet UILabel *sleepMoveLabel;

@end

@implementation MovementCell

- (void)setDataLabel:(DataLabelModel *)dataLabel {
    _dataLabel = dataLabel;
    
    self.sleepLeaveLabel.text = [NSString stringWithFormat:@"    离床次数    %zd", dataLabel.sleepLeave];
    self.sleepMoveLabel.text = [NSString stringWithFormat:@"    体动次数    %zd", dataLabel.sleepMove];
}


- (void)setFrame:(CGRect)frame {
    
    static CGFloat margin = 2;
    
    frame.size.height -= margin;
    frame.origin.y += margin;
    
    [super setFrame:frame];
}


@end
