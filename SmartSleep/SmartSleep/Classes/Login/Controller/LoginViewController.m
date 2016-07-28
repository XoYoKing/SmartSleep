//
//  LoginViewController.m
//  SmartSleep
//
//  Created by 许良 on 16/7/25.
//  Copyright © 2016年 William Cai. All rights reserved.
//

#import "LoginViewController.h"
#import "CustomNavigationController.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"

#import "MainViewController.h"
#import "RegisterViewController.h"
#import "ForgetPasswordViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self notificationCenter:self.username];
    [self notificationCenter:self.password];
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}

- (void)notificationCenter:(UITextField*)textField{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:textField];
    
}
-(void)textChange{
    self.loginBtn.enabled = [self.username.text length] != 0 && [self.password.text length] != 0;

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];

    return YES;
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
}

- (IBAction)loginAction:(id)sender {
    [SVProgressHUD show];
    [self connectUrl];
}
- (IBAction)ForgetPasswordAction:(id)sender {
    ForgetPasswordViewController *vc = [[ForgetPasswordViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)RegisterAction:(id)sender {
    RegisterViewController *vc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)setupNav{
   
    self.navigationItem.title = @"用户登录";

}
- (void)connectUrl {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString *requestUrl = [NSString stringWithFormat:@"http://121.42.151.185:8080/FamilySleep/user_login?cellphone=%@&&password=%@",self.username.text,self.password.text];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:requestUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSDictionary *json = responseObject;
             //             NSString *flag = json[@"flag"];
             int flag = [[json objectForKey:@"flag"]intValue];
             //             NSLog(@"json = %@",json);
             //             NSDictionary *obj = [json objectForKey:@"obj"];
             //             NSString *deviceid = [obj objectForKey:@"deviceId"];
             
             if (flag == 1) {
//                 NSLog(@"flag get");
                 [[NSUserDefaults standardUserDefaults]setObject:self.username.text forKey:@"UserNameKey"];
                 [[NSUserDefaults standardUserDefaults]setObject:self.password.text forKey:@"PassWordKey"];
                 [[NSUserDefaults standardUserDefaults]synchronize];
                 
                 MainViewController *vc = [[MainViewController alloc]init];
                 [vc setHidesBottomBarWhenPushed:YES];
                 [self.navigationController pushViewController:vc animated:YES];

             }
             else {
                 UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"账号密码错误" preferredStyle:UIAlertControllerStyleAlert];
                 [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
                 [self presentViewController:alert animated:YES completion:nil];
             }
             
             [SVProgressHUD dismiss];
             
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             
             NSLog(@"%@",error);
             
         }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
