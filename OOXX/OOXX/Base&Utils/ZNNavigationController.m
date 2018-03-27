//
//  ZNNavigationController.m
//  OOXX
//
//  Created by NanZhang on 2017/9/29.
//  Copyright © 2017年 NanZhang. All rights reserved.
//

#import "ZNNavigationController.h"
#import "UINavigationBar+BackgroundColor.h"


@interface ZNNavigationController ()

@end

@implementation ZNNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationBar lt_setBackgroundColor:MAIN_S_COLOR];
    
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor whiteColor] , NSFontAttributeName : [UIFont boldSystemFontOfSize:20]}];
    
    [self.navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---

#pragma mark -- 隐藏tabbar ---

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark -- 自定义返回按钮 --

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backBarButtonItemAction)];
    
    viewController.navigationItem.backBarButtonItem = backBarButtonItem;
    
}

- (void)backBarButtonItemAction
{
    [self popViewControllerAnimated:YES];
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
