//
//  ForgetPasswordViewController.m
//  SmartSleep
//
//  Created by 许良 on 16/7/28.
//  Copyright © 2016年 William Cai. All rights reserved.
//

#import "ForgetPasswordViewController.h"

@interface ForgetPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *PhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *Identifying;
@property (weak, nonatomic) IBOutlet UIButton *GetCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *RefoundPwd;

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.navigationItem.title = @"找回密码";
}
- (IBAction)RefoundAction:(id)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
