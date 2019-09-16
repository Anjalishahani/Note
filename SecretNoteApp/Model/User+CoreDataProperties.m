//
//  User+CoreDataProperties.m
//  SecretNoteApp
//
//  Created by husky pestcontrol on 2019-09-07.
//  Copyright © 2019 husky pestcontrol. All rights reserved.
//
//

#import "User+CoreDataProperties.h"

@implementation User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"User"];
}

@dynamic name;
@dynamic pin;

@end
