//
//  RegisterViewController.m
//  SmartSleep
//
//  Created by 许良 on 16/7/25.
//  Copyright © 2016年 William Cai. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *PhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *UserName;
@property (weak, nonatomic) IBOutlet UITextField *Password;
@property (weak, nonatomic) IBOutlet UITextField *Identifying;
@property (weak, nonatomic) IBOutlet UIButton *GetCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *RegisterBtn;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"用户注册";
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)GetCodeAction:(id)sender {
}
- (IBAction)RegisterAction:(id)sender {
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
