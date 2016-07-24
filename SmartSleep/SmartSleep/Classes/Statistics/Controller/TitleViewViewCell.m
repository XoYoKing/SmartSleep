//
//  TitleViewViewCell.m
//  SmartSleep
//
//  Created by 许良 on 16/7/24.
//  Copyright © 2016年 William Cai. All rights reserved.
//

#import "TitleViewViewCell.h"

@implementation TitleViewViewCell


+ (instancetype)ReportViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"";//对应xib中设置的identifier
    NSInteger index = 0; //xib中第几个Cell
    switch (indexPath.row) {
        case 0:
            identifier = @"TitleViewCell";
            index = 0;
            break;
        case 1:
            identifier = @"LabelViewCell";
            index = 1;
            break;
        default:
            break;
    }
    TitleViewViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TitleViewViewCell" owner:self options:nil] objectAtIndex:index];
    }
    return cell;
    
}

- (void)awakeFromNib {

}


@end
