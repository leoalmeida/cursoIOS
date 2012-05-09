//
//  AppDelegate.m
//  FirstContacts
//
//  Created by ios2686 on 08/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate() {
    NSMutableArray *contatos;
}
@end

@implementation AppDelegate

@synthesize navigationController = _navigationController;
@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self carregaDoPlist];
            
    ViewController *listagemContatos = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    listagemContatos.contatos = contatos;
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:listagemContatos];
    
    self.window.rootViewController = self.navigationController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)carregaDoPlist{
    NSString *caminho = [[NSBundle mainBundle] pathForResource:@"contatos" ofType:@"plist"];
    NSMutableDictionary *arrayContatos = [[NSMutableDictionary alloc] initWithContentsOfFile:caminho];
    contatos = [[NSMutableArray alloc] init];
    
    for(NSString *key in arrayContatos){
        NSDictionary *d = [arrayContatos objectForKey:key];
        
        //array para armazenar os contatos
        [contatos addObject:[d objectForKey:@"nome"]];
    }
}

@end
