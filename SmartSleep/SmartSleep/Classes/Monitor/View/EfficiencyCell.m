//
//  EfficiencyCell.m
//  SmartSleep
//
//  Created by William Cai on 16/7/20.
//  Copyright © 2016年 William Cai. All rights reserved.
//

#import "EfficiencyCell.h"
#import "DataLabelModel.h"

@interface EfficiencyCell ()

@property (weak, nonatomic) IBOutlet UIProgressView *efficiencyProgressView;
@property (weak, nonatomic) IBOutlet UILabel *efficiencyPercentageLabel;

@end

@implementation EfficiencyCell

- (void)setDataLabel:(DataLabelModel *)dataLabel {
    _dataLabel = dataLabel;
    
    self.efficiencyPercentageLabel.text = [NSString stringWithFormat:@"%zd％", dataLabel.efficiency];
    [self.efficiencyProgressView setProgress:dataLabel.efficiency/100.0 animated:YES];
}


- (void)setFrame:(CGRect)frame {
    
    static CGFloat margin = 2;
    
    frame.size.height -= margin;
    frame.origin.y += margin;
    
    [super setFrame:frame];
}

@end
