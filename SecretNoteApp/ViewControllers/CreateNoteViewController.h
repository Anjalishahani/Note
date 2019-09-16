//
//  CreateNoteViewController.h
//  SecretNoteApp
//
//  Created by husky pestcontrol on 2019-09-08.
//  Copyright © 2019 husky pestcontrol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note+CoreDataProperties.h"

NS_ASSUME_NONNULL_BEGIN

@interface CreateNoteViewController : UIViewController
@property(nonatomic, assign)BOOL isNewNote;
@property(nonatomic) Note * note;
@end

NS_ASSUME_NONNULL_END
