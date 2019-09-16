//
//  NoteView.h
//  SecretNoteApp
//

#import <UIKit/UIKit.h>
#import "Note+CoreDataProperties.h"

NS_ASSUME_NONNULL_BEGIN

@interface NoteView : UIView
{
    UILabel* titleLabel;
}
-(NSArray*)getNotes;
-(BOOL)deleteNote:(Note*)title;
//-(void)editNoteWithTitle:(NSString*)title;

@end

NS_ASSUME_NONNULL_END
