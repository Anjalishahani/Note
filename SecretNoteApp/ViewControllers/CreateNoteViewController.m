//
//  CreateNoteViewController.m
//  SecretNoteApp
//
//  Created by husky pestcontrol on 2019-09-08.
//  Copyright © 2019 husky pestcontrol. All rights reserved.
//

#import "CreateNoteViewController.h"
#import "Appdelegate.h"
@interface CreateNoteViewController ()
{
    UITextView* contentTextView;
}
@end

@implementation CreateNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavigation];
    [self setUpTextView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if( self.isNewNote )
        [self addTitle];
}

-(void)setupNavigation{
    self.navigationItem.hidesBackButton = false;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                   initWithTitle: self.isNewNote ?  @"✔️" : @"✏"
                                   style: UIBarButtonItemStyleDone
                                   target:self
                                   action:@selector(doneAction)];
    self.navigationItem.rightBarButtonItem = doneButton;
    [self.navigationController.navigationItem setLargeTitleDisplayMode:UINavigationItemLargeTitleDisplayModeNever];
    self.navigationItem.title = self.isNewNote ? @"" : self.note.title;
}

-(void)setUpTextView{
    contentTextView = [[UITextView alloc] initWithFrame:self.view.frame textContainer:nil];
    [contentTextView setScrollEnabled:YES];
    [contentTextView setFont:[UIFont systemFontOfSize:15]];
    if( self.isNewNote == NO)
    {
       contentTextView.text = self.note.content;
       [contentTextView setEditable:self.isNewNote];
       contentTextView.textColor = [UIColor lightGrayColor];
    }
    else
    {
        contentTextView.text = @"";
        [contentTextView setEditable:self.isNewNote];
        contentTextView.textColor = [UIColor blackColor];
    }
    [self.view addSubview:contentTextView];
}

-(void)addTitle{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Create New Note" message:@"Add title" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Enter title";
        [textField setClearButtonMode:UITextFieldViewModeWhileEditing] ;
        [textField setBorderStyle:UITextBorderStyleNone];
    }];
  
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
             [self.navigationController popViewControllerAnimated:YES ];
        }];
        [alert addAction:cancelAction];
    
    
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            [self setHeader: alert.textFields[0].text];
        }];
        [alert addAction:defaultAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    alert = nil;
}

-(void)setHeader:(NSString*)str{
     self.navigationItem.title = str;
    [contentTextView becomeFirstResponder];

}

-(void)doneAction{
    if(self.isNewNote == NO)
    {
        [contentTextView setEditable:YES];
        contentTextView.textColor = [UIColor blackColor];
        [contentTextView becomeFirstResponder];
        self.navigationItem.rightBarButtonItem.title =  @"✔️";
        self.isNewNote = YES;
    }
    else
    {
        if( contentTextView.text.length == 0 )
            [self dissmiss:@"No content added for this note. Do you want to save note?" showOk:YES];
        else
            [self dissmiss:@"Note saved" showOk:NO];
    }
    
}

-(void)cancelAction{
    if(contentTextView.text.length > 0)
        [self dissmiss:@"Note will be lost. Are you sure?" showOk:YES];
    else
        [self dissmiss:@"" showOk:NO];
}

-(void)dissmiss:(NSString *)message showOk:(BOOL)shouldShowOK 
{
    if ([message isEqualToString:@""] )
    {
        [self.navigationController popViewControllerAnimated:YES ];
    }
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Message" message:message preferredStyle:UIAlertControllerStyleAlert];
       
         if ( ![message isEqualToString:@"Note saved"] )
         {
             UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
            
             }];
             [alert addAction:cancelAction];
         }
        
        if (shouldShowOK || [message isEqualToString:@"Note saved"] ) {
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                [self saveNote];
                [self.navigationController popViewControllerAnimated:YES ];
            }];
            [alert addAction:defaultAction];
        }
        [self presentViewController:alert animated:YES completion:nil];
        alert = nil;
    }
}
-(void)saveNote{
    [self updateNoteWithDate:self.note.creationDate];
}

-(void)createNote
{
    Note* noteInstance = [[Note alloc] initWithContext:[[AppDelegate sharedAppDelegate]context]];
    noteInstance.title = self.navigationItem.title;
    noteInstance.content = contentTextView.text;
    noteInstance.creationDate = [NSDate date];
    [[AppDelegate sharedAppDelegate] saveContext];
}

-(void)updateNoteWithDate:(NSDate*)date{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Note" inManagedObjectContext:[[AppDelegate sharedAppDelegate]context]]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title == %@ AND creationDate == %@" ,  self.navigationItem.title, date];
    [request setPredicate:predicate];
    NSSortDescriptor* sectionSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"creationDate" ascending:YES];
    NSArray* sortDescriptors = [NSArray arrayWithObject:sectionSortDescriptor];
    [request setSortDescriptors:sortDescriptors];
    NSError *error = nil;
    NSArray *results = [[[AppDelegate sharedAppDelegate]context] executeFetchRequest:request error:&error];
    if(results.count != 0)
    {
        Note* noteInstance = results[0];
        noteInstance.title = self.navigationItem.title;
        noteInstance.content = contentTextView.text;
    }
    else{
        [self createNote];
    }
}

@end
