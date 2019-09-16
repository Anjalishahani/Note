//
//  Note+CoreDataProperties.h
//  SecretNoteApp
//
//  Created by husky pestcontrol on 2019-09-15.
//  Copyright © 2019 husky pestcontrol. All rights reserved.
//
//

#import "Note+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Note (CoreDataProperties)

+ (NSFetchRequest<Note *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *content;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSDate *creationDate;

@end

NS_ASSUME_NONNULL_END
