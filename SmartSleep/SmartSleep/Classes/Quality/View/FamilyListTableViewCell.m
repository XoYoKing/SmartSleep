//
//  FamilyListTableViewCell.m
//  SmartSleep
//
//  Created by William Cai on 16/7/20.
//  Copyright © 2016年 William Cai. All rights reserved.
//

#import "FamilyListTableViewCell.h"
#import "FamilyListModel.h"
#import <UIImageView+WebCache.h>

@interface FamilyListTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *familyListHeadImageView;
@property (weak, nonatomic) IBOutlet UILabel *familyListNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *familyListSexImageView;

@end

@implementation FamilyListTableViewCell

- (void)setFamilyList:(FamilyListModel *)familyList {
    _familyList = familyList;
    
    [self.familyListHeadImageView sd_setImageWithURL:[NSURL URLWithString:familyList.userImg] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.familyListNameLabel.text = familyList.userName;
    if (familyList.userSex == SexTypeMale) {
        _familyListSexImageView.image = [UIImage imageNamed:@"male"];
    }
    if (familyList.userSex == SexTypeFemale) {
        _familyListSexImageView.image = [UIImage imageNamed:@"female"];
    }
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
