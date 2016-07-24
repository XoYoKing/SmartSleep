//
//  FamilyListModel.h
//  SmartSleep
//
//  Created by William Cai on 16/7/20.
//  Copyright © 2016年 William Cai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FamilyListModel : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userImg;
@property (nonatomic, assign) SexType userSex;

@end
