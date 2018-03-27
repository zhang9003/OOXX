//
//  AppDelegate.m
//  OOXX
//
//  Created by NanZhang on 2017/10/1.
//  Copyright © 2017年 NanZhang. All rights reserved.
//

#import "AppDelegate.h"
#import "ZNNavigationController.h"
#import "RDVTabBarController.h"
#import "RDVTabBar.h"
#import "RDVTabBarItem.h"

@interface AppDelegate ()

@property (strong, nonatomic) RDVTabBarController *tabBarController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self setupViewControllers];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    [self judgeNet];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



- (void)setupViewController
{
    UIViewController *loginVC = [[UIViewController alloc] init];
    ZNNavigationController *guideNavigationController = [[ZNNavigationController alloc]
                                                         initWithRootViewController:loginVC];
    self.viewController = guideNavigationController;
}

- (void)setupViewControllers {
    
    
    //    LTFindViewController *firstViewController = [[LTFindViewController alloc] init];
    UIViewController *firstViewController  = [[UIViewController alloc] init];
    firstViewController.title = @"主页";
    UIViewController *firstNavigationController = [[ZNNavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
    UIViewController *secondViewController = [[UIViewController alloc] init];
    secondViewController.title = @"收藏";
    UIViewController *secondNavigationController = [[ZNNavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    
    UIViewController *thirdViewController = [[UIViewController alloc] init];
    thirdViewController.title = @"我的";
    UIViewController *thirdNavigationController = [[ZNNavigationController alloc]
                                                   initWithRootViewController:thirdViewController];
    
    self.tabBarController = [[RDVTabBarController alloc] init];
    [self.tabBarController setViewControllers:@[firstNavigationController, secondNavigationController,
                                                thirdNavigationController]];
    
    [self customizeTabBarForController:self.tabBarController];
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"find", @"like", @"mine"];
    NSArray *tabBarItemTitles = @[@"发现",@"喜欢",@"我的"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];
        
        index++;
    }
}


- (void)judgeNet
{
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未识别的网络");
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
            {
                NSLog(@"不可达的网络(未连接)");
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"网络异常" message:@"请检查网络" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alertView show];
                NSDictionary *dict = @{NFC_NETISCONNECT:@"0"};
                [[NSNotificationCenter defaultCenter] postNotificationName:NFC_NETISCONNECT object:nil userInfo:dict];
                
            }
                
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                //                NSLog(@"2G,3G,4G...的网络");
                NSDictionary *dict = @{NFC_NETISCONNECT:@"1"};
                [[NSNotificationCenter defaultCenter] postNotificationName:NFC_NETISCONNECT object:nil userInfo:dict];
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                //                NSLog(@"wifi的网络");
            {
                NSDictionary *dict = @{NFC_NETISCONNECT:@"2"};
                [[NSNotificationCenter defaultCenter] postNotificationName:NFC_NETISCONNECT object:nil userInfo:dict];
                
            }
                break;
            default:
                break;
        }
    }];
    
}

@end
