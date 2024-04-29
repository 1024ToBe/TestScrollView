//
//  AppDelegate.m
//  TestScrollView
//
//  Created by jolly2 on 4/29/24.
//

#import "AppDelegate.h"
#import "JLMainVC.h"
#import "JLMainVC1.h"
@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    JLMainVC1 *vc = [[JLMainVC1 alloc]init];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
