//
//  AppDelegate.h
//  SecretNoteApp
//
//  Created by husky pestcontrol on 2019-09-06.
//  Copyright © 2019 husky pestcontrol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *navigation ;
}
+ (AppDelegate *)sharedAppDelegate;
@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (nonatomic) NSManagedObjectContext *context;

- (void)saveContext;


@end

