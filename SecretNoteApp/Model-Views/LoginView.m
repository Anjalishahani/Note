//
//  LoginView.m
//  SecretNoteApp
//

#import "LoginView.h"
#import "User+CoreDataClass.h"
#import "Appdelegate.h"


@implementation LoginView
- (id)initWithFrame:(CGRect)frame
    {
        self = [super initWithFrame:frame];
        if (self) {
            UIView* innerView = [[UIView alloc] initWithFrame:CGRectMake(8, self.frame.size.height, self.frame.size.width - 16, 200)];
            innerView.backgroundColor = [[UIColor alloc] initWithRed:254/255.0 green:252/255.0 blue:210/255.0 alpha:1.0] ;
            
            [UIView animateWithDuration:1.0
                                  delay:0.1
                                options: UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 innerView.frame = CGRectMake(8, self.frame.size.height/2 - 170, self.frame.size.width - 16, 200);
                             }
                             completion:^(BOOL finished){
                             }];
            [self addSubview:innerView];
            innerView.layer.cornerRadius = 10;
            innerView.layer.masksToBounds = true;
            loggedInUser = [self checkUserExist];
            if( [ loggedInUser isEqualToString:@""])
            {
                // Initialization code
                usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
                usernameLabel.text = @"Username:";
                usernameLabel.translatesAutoresizingMaskIntoConstraints = false;
                [innerView addSubview:usernameLabel];
                // set constraints for username Label
                [usernameLabel.leadingAnchor constraintEqualToAnchor:self.layoutMarginsGuide.leadingAnchor constant:8].active = YES;
                [usernameLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor constant:-150].active = YES;
                
                usernameTextField = [[UITextField alloc] initWithFrame:CGRectZero];
                usernameTextField.placeholder = @"Username";
                usernameTextField.borderStyle = UITextBorderStyleRoundedRect;
                usernameTextField.translatesAutoresizingMaskIntoConstraints = false;
                usernameTextField.keyboardType = UIKeyboardTypeDefault;
                usernameTextField.returnKeyType = UIReturnKeyDone;
                usernameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
                usernameTextField.delegate = self;
                
                [innerView addSubview:usernameTextField];
                // set constraints for inputTextField textfield
                [usernameTextField.leadingAnchor constraintEqualToAnchor:self.layoutMarginsGuide.leadingAnchor constant:8].active = YES;
                [usernameTextField.topAnchor constraintEqualToAnchor:usernameLabel.bottomAnchor constant:8].active = YES;
                [usernameTextField.trailingAnchor constraintEqualToAnchor:self.layoutMarginsGuide.trailingAnchor constant:-8].active = YES;
                
                pinLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
                pinLabel.text = @"Pin:";
                pinLabel.translatesAutoresizingMaskIntoConstraints = false;
                [innerView addSubview:pinLabel];
                // set constraints for pin Label
                [pinLabel.leadingAnchor constraintEqualToAnchor:self.layoutMarginsGuide.leadingAnchor constant:8].active = YES;
                [pinLabel.topAnchor constraintEqualToAnchor:usernameTextField.bottomAnchor constant:16].active = YES;
            }
            else
            {
                usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
                usernameLabel.text = [ @"Welcome " stringByAppendingString:loggedInUser ];
                usernameLabel.textAlignment = NSTextAlignmentCenter;
                usernameLabel.translatesAutoresizingMaskIntoConstraints = false;
                [innerView addSubview:usernameLabel];
                // set constraints for username Label
                [usernameLabel.leadingAnchor constraintEqualToAnchor:self.layoutMarginsGuide.leadingAnchor constant:20].active = YES;
                 [usernameLabel.trailingAnchor constraintEqualToAnchor:self.layoutMarginsGuide.trailingAnchor constant:-8].active = YES;
                [usernameLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor constant:-150].active = YES;
                
                pinLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
                pinLabel.text = @"Pin:";
                pinLabel.translatesAutoresizingMaskIntoConstraints = false;
                [innerView addSubview:pinLabel];
                // set constraints for pin Label
                [pinLabel.leadingAnchor constraintEqualToAnchor:self.layoutMarginsGuide.leadingAnchor constant:8].active = YES;
                [pinLabel.topAnchor constraintEqualToAnchor:usernameLabel.bottomAnchor constant:16].active = YES;
            }
           
            
            pinTextField = [[UITextField alloc] initWithFrame:CGRectZero];
            pinTextField.placeholder = @"Pin";
            pinTextField.borderStyle = UITextBorderStyleRoundedRect;
            [pinTextField setSecureTextEntry:YES];
            pinTextField.translatesAutoresizingMaskIntoConstraints = false;
            pinTextField.keyboardType = UIKeyboardTypeNumberPad;
            pinTextField.returnKeyType = UIReturnKeyDone;
            pinTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
            pinTextField.delegate = self;
            [innerView addSubview:pinTextField];
            // set constraints for inputTextField textfield
            [pinTextField.leadingAnchor constraintEqualToAnchor:self.layoutMarginsGuide.leadingAnchor constant:8].active = YES;
            [pinTextField.topAnchor constraintEqualToAnchor:pinLabel.bottomAnchor constant:8].active = YES;
            [pinTextField.trailingAnchor constraintEqualToAnchor:self.layoutMarginsGuide.trailingAnchor constant:-8].active = YES;
            
            // Login Button
            NSString* title = [loggedInUser isEqualToString:@""]  ? @"Create User" : @"Login";
            loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            [loginBtn setTitle:title forState:UIControlStateNormal];
            [loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchUpInside];

            [loginBtn sizeToFit];
            loginBtn.translatesAutoresizingMaskIntoConstraints = false;
            
            [innerView addSubview:loginBtn];
            // set constraints for login button
            [loginBtn.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
            [loginBtn.topAnchor constraintEqualToAnchor:pinTextField.bottomAnchor constant:20].active = YES;
        }
        return self;
    }

#pragma mark - User Action

-(void)createUser: (NSString*)name andPin:(int64_t)pin{
    User* userInstance = [[User alloc] initWithContext:[[AppDelegate sharedAppDelegate]context]];
    userInstance.name = name;
    userInstance.pin = pin;
    [[AppDelegate sharedAppDelegate] saveContext];
}

-(NSString*)checkUserExist{
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    NSArray <User*>* user =[[[AppDelegate sharedAppDelegate] context] executeFetchRequest:request error:nil];
    if(user.count == 1)
    {
        checkPin = user[0].pin;
        return user[0].name;
    }
    else
    {
        return @"";
    }
}


#pragma mark -Login Action

-(void)loginBtnAction{

    if([loggedInUser isEqualToString:@""])
    {
        BOOL isUsernameTextfieldIsEmpty = usernameTextField.text.length == 0;
        BOOL isPinTextfieldIsEmpty = pinTextField.text.length == 0;
        NSString * message = @"";
        if( isUsernameTextfieldIsEmpty  ){
            message = @"Username is empty!";
        }
        if( isPinTextfieldIsEmpty  ){
            message = @"Pin is empty!";
        }
        if( isPinTextfieldIsEmpty && isUsernameTextfieldIsEmpty ){
            message = @"Username and Pin is empty!";
        }
        if(!isUsernameTextfieldIsEmpty || !isPinTextfieldIsEmpty){
            [self createUser:usernameTextField.text andPin:[pinTextField.text integerValue]];
            [self.delegate loginBtnPressed:message];
        }
    }
    else{
            if(checkPin == [pinTextField.text integerValue])
            {
                [self.delegate loginBtnPressed:@""];
            }
            else
            {
                NSString* message = @"Please enter correct pin";
                [self.delegate loginBtnPressed:message];
            }
    }
}

@end
