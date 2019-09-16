//
//  LoginView.h
//  SecretNoteApp
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol LoginButtonProtocol
    
    - (void)loginBtnPressed:(NSString*)message;
    
@end
@interface LoginView : UIView<UITextFieldDelegate>
    {
        UILabel *usernameLabel;
        UITextField *usernameTextField ;
        UILabel *pinLabel ;
        UITextField *pinTextField;
        UIButton *loginBtn;
        NSString* loggedInUser;
        int64_t checkPin;
        
    }
    @property (nonatomic, assign) id <LoginButtonProtocol> delegate;
-(NSString*)checkUserExist;

@end

NS_ASSUME_NONNULL_END
