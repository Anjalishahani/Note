//
//  ViewController.m
//  SecretNoteApp
//
//  Created by husky pestcontrol on 2019-09-06.
//  Copyright © 2019 husky pestcontrol. All rights reserved.
//

#import "ViewController.h"
#import "Appdelegate.h"
#import "NoteListViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    LoginView *subView = [[LoginView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    subView.delegate = self;
    subView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:subView];

}

-(void)loginBtnPressed:(NSString *)message{
    if ([message isEqualToString:@""])
    {
       NoteListViewController* noteViewController = [[NoteListViewController alloc] init];
        [self.navigationController pushViewController:noteViewController animated:YES];
    }
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
            
        }];
    
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
   // [self.view setNeedsLayout];
}
@end
