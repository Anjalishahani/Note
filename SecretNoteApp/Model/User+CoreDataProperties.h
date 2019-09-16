//
//  User+CoreDataProperties.h
//  SecretNoteApp
//
//  Created by husky pestcontrol on 2019-09-07.
//  Copyright © 2019 husky pestcontrol. All rights reserved.
//
//

#import "User+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int64_t pin;

@end

NS_ASSUME_NONNULL_END
