//
//  Note+CoreDataProperties.m
//  SecretNoteApp
//
//  Created by husky pestcontrol on 2019-09-15.
//  Copyright © 2019 husky pestcontrol. All rights reserved.
//
//

#import "Note+CoreDataProperties.h"

@implementation Note (CoreDataProperties)

+ (NSFetchRequest<Note *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Note"];
}

@dynamic content;
@dynamic title;
@dynamic creationDate;

@end
