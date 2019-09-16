//
//  NoteView.m
//  SecretNoteApp
//


#import "NoteView.h"
#import "Appdelegate.h"

@implementation NoteView
- (id)initWithFrame:(CGRect)frame andTitle:(NSString*)title
{
    titleLabel.text = @"Notes";
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

#pragma mark - Note Action

-(BOOL)deleteNote:(Note *)noteObj{
    [[[AppDelegate sharedAppDelegate] context] deleteObject:noteObj];
    
    NSError *error = nil;
    if (![[[AppDelegate sharedAppDelegate] context] save:&error]) {
        NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
        return NO;
    }
    else return YES;

}

-(NSArray*)getNotes{
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Note"];
    NSArray <Note*>* notes =[[[AppDelegate sharedAppDelegate] context] executeFetchRequest:request error:nil];
    return notes;
}


@end
