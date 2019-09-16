//
//  AppDelegate.m
//  SecretNoteApp
//
//  Created by husky pestcontrol on 2019-09-06.
//  Copyright © 2019 husky pestcontrol. All rights reserved.
//

#import "AppDelegate.h"
#import "EncryptedStore.h"
#import "ViewController.h"
@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.context = self.persistentContainer.viewContext;
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {}
- (void)applicationDidEnterBackground:(UIApplication *)application {}
- (void)applicationWillEnterForeground:(UIApplication *)application {}
- (void)applicationDidBecomeActive:(UIApplication *)application {}
- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
}

#pragma mark - Set RootView
+ (AppDelegate *)sharedAppDelegate{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;
- (NSPersistentContainer *)persistentContainer {
    if (_persistentContainer == nil) {
        _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"SecretNoteApp"];
        NSDictionary *options = @{
                                  EncryptedStorePassphraseKey : @"MY_SECRET_PASSPHRASE",
                                  EncryptedStoreFileManagerOption : [EncryptedStoreFileManager defaultManager]
                                  };
        NSPersistentStoreDescription *description = [EncryptedStore makeDescriptionWithOptions:options configuration:nil error:nil];
        
        _persistentContainer.persistentStoreDescriptions = @[description];
        
        [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *description, NSError * error) {
            if (error) {
                NSLog(@"error! %@", error);
            }
        }];
    }
    return _persistentContainer;
}
#pragma mark - Core Data Saving support

- (void)saveContext {
    NSError *error = nil;
    if ([self.context hasChanges] && ![self.context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
